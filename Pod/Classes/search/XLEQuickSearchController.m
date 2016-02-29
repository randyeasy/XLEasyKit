//
//  XLECSearchController.m
//  Pods
//
//  Created by Randy on 15/12/8.
//
//

#import "XLEQuickSearchController.h"
#import "XLESearchHistoryTableViewCell.h"
#import "XLELabel.h"

@interface XLEQuickSearchController ()<
    XLEBaseTableViewDelegate,
    UITableViewDataSource,
    XLESearchDisplayDelegate>
@property (strong, nonatomic) XLESearchDisplayController *searchDisplay;
@property (strong, nonatomic) NSMutableArray *searchList;

@property (copy, nonatomic) NSString *searchString;

@property (assign, nonatomic) BOOL hasMore;
@property (strong, nonatomic) XLEPageModel *pageModel;

//历史记录
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) XLELabel *headerView;
@property (strong, nonatomic) NSMutableArray *historyList;

@property (strong, nonatomic) UIView *blankView;
@property (strong, nonatomic) UIView *errorView;

@end

@implementation XLEQuickSearchController

- (instancetype)initWithDelegate:(id<XLEQuickSearchListDelegate>)delegate;
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _rowHeight = 44;
    }
    return self;
}

- (void)showSearch;
{
    if ([self.historyList count]) {
        self.searchDisplay.searchResultsTableView.tableFooterView = self.footerView;
        self.searchDisplay.searchResultsTableView.tableHeaderView = self.headerView;
    }
    [self.searchDisplay setActive:YES animated:YES];
    self.searchDisplay.searchResultsTableView.delegate = self;
    self.searchDisplay.searchResultsTableView.dataSource = self;
}

- (void)closeSearch;
{
    [self clearSearch];
    [self.searchDisplay setActive:NO animated:YES];
}

#pragma mark - UISearchController delegate

- (void) searchDisplayControllerDidCancel:(XLESearchDisplayController *)controller;
{
    [self clearSearch];
}

- (void) searchDisplayControllerDidEndSearch:(XLESearchDisplayController *)controller
{
}

- (void) searchDisplayControllerDidSearch:(XLESearchDisplayController *)controller;
{
    [self insertKeyword:self.searchString];
    [self.searchDisplay.searchBar resignFirstResponder];
}

- (BOOL)searchDisplayController:(XLESearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    self.searchString = [searchString xle_trim];
    if ([self.searchString length]>0) {
        [self onSearchWithStr:self.searchString];

        return NO;
    } else {
        self.searchList = nil;
        if ([self.historyList count]>0) {
            self.searchDisplay.searchResultsTableView.tableHeaderView = self.headerView;
            self.searchDisplay.searchResultsTableView.tableFooterView = self.footerView;
        }
        return YES;
    }
}

- (BOOL)searchDisplayController:(XLESearchDisplayController *)controller shouldReloadTableForSearchScope:(NSUInteger)searchOption
{
    return NO;
}

#pragma mark - UITableView delegate datasource
- (BOOL)hasMoreInTableView:(XLEBaseTableView *)tableView
{
    if ([self shouldShowHistory]) {
        return NO;
    } else {
        return self.hasMore;
    }
}

- (void)tableView:(XLEBaseTableView *)tableView getMore:(void (^)())callback
{
    XLEWS(weakSelf);
    NSString *searchString = self.searchString;
    
    XLEListRequestCallback requestCallback = ^(NSArray *items, XLEPageModel *pageModel, XLEError *error){
        if ([searchString isEqualToString:weakSelf.searchString]) {
            if (items.count>0) {
                [weakSelf.searchList addObjectsFromArray:items];
                [weakSelf.searchDisplay.searchResultsTableView reloadData];
            }
            if (callback) {
                callback();
            }
        }
    };
    
    if ([self.requestDelegate respondsToSelector:@selector(requestOpeGetMore:callback:)]) {
        [self.requestDelegate requestOpeGetMore:self.pageModel callback:requestCallback];
    }
    else if([self.requestDelegate respondsToSelector:@selector(requestOpeGetMoreWithLastItem:callback:)])
    {
        [self.requestDelegate requestOpeGetMoreWithLastItem:self.searchList.lastObject callback:requestCallback];
    }
    else
    {
        if (callback) {
            callback();
        }
    }
}

- (UIView *)viewForBlankInTableView:(XLEBaseTableView *)tableView{
    if (![self shouldShowHistory]) {
        UIView *blankView = self.blankView;
        if (!blankView) {
            blankView = [[self.blankClass alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        }
        if ([self.delegate respondsToSelector:@selector(onTableView:updateBlankView:)]) {
            [self.delegate onTableView:tableView updateBlankView:self.blankView];
        }
        return blankView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self shouldShowHistory]) {
        return self.historyList.count;
    }
    return self.searchList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self shouldShowHistory]) {
        XLESearchHistoryTableViewCell *cell = (XLESearchHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
        if (cell == nil) {
            cell = [[XLESearchHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCell"];
        }
        xleWeakifyself
        [cell setClickBubbleBlock:^(NSString *keyword) {
            xleStrongifyself
            self.searchDisplay.searchBar.text = keyword;
            [self onSearchWithStr:keyword];
        }];
        NSString *keyword = self.historyList[indexPath.row];
        [cell updateWithTitle:keyword];
        return cell;
    }
    else
    {
        id<NSObject> item = [self.searchList xle_objectAtIndex:indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[[self.delegate onTableView:tableView cellForItem:item indexPath:indexPath] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        if ([self.delegate respondsToSelector:@selector(onTableView:updateCell:item:indexPath:)]) {
            [self.delegate onTableView:tableView updateCell:cell item:item indexPath:indexPath];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self shouldShowHistory]) {
        return 34;
    } else if ([self.delegate respondsToSelector:@selector(onTableView:heightForItem:indexPath:)]) {
        id<NSObject> item = nil;
        if (self.searchList.count>indexPath.row) {
            item = self.searchList[indexPath.row];
        }
        return [self.delegate onTableView:tableView heightForItem:item indexPath:indexPath];
    }
    else
        return self.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self shouldShowHistory]) {
        [self.searchDisplay.searchBar setText:self.historyList[indexPath.row]];
        [self onSearchWithStr:self.historyList[indexPath.row]];
    }
    else
    {
        id<NSObject> item = nil;
        if (self.searchList.count>indexPath.row) {
            item = self.searchList[indexPath.row];
        }
        [self.delegate onTableView:tableView heightForItem:item indexPath:indexPath];
    }
}

#pragma mark - internal
- (void)onSearchWithStr:(NSString *)searchString
{
    XLEWS(weakSelf);
    [self.requestDelegate requestOpeRefreshWithSearchStr:searchString callback:^(NSArray *items, XLEPageModel *pageModel, XLEError *error) {
        weakSelf.pageModel = pageModel;
        weakSelf.searchList = [items mutableCopy];
        weakSelf.searchDisplay.searchResultsTableView.tableHeaderView = nil;
        weakSelf.searchDisplay.searchResultsTableView.tableFooterView = nil;
        [weakSelf.searchDisplay.searchResultsTableView reloadData];
    }];
}

- (void)insertKeyword:(NSString *)keyword {
    
    //keyword = [];
    
    if (keyword.length<=0) {
        return;
    }
    
    for (NSString *existKeyword in self.historyList) {
        if ([existKeyword isEqualToString:keyword]) {
            [self.historyList removeObject:keyword];
            break;
        }
    }
    [self.historyList insertObject:keyword atIndex:0];
    
    //移除多余的数据
    if ([self.historyList count]> 50) {
        [self.historyList removeObjectAtIndex:[self.historyList count] - 1];
    }

    [[XLEUserCache sharedCache] setObject:self.historyList forKey:self.historyKey];
}

- (BOOL)shouldShowHistory {
    NSString *searchString = [self.searchDisplay.searchBar.text xle_trim];
    return ![searchString length] && [self.delegate respondsToSelector:@selector(onHistoryKeyInTableView:)];
}

- (void)clearSearch
{
    self.searchString = nil;
    self.hasMore = NO;
    self.searchList = nil;
    self.searchDisplay.searchBar.text = @"";
}

- (void)clearHistoryAction {
    [[XLEUserCache sharedCache] setObject:self.historyList forKey:self.historyKey];
    self.searchDisplay.searchResultsTableView.tableFooterView = nil;
    self.searchDisplay.searchResultsTableView.tableHeaderView = nil;
    self.historyList = nil;
    [self.searchDisplay.searchResultsTableView reloadData];
}

- (NSString *)historyKey
{
    if ([self.delegate respondsToSelector:@selector(onHistoryKeyInTableView:)]) {
        return [self.delegate onHistoryKeyInTableView:self.searchDisplay.searchResultsTableView];
    }
    return nil;
}


#pragma mark - set get
- (XLESearchDisplayController *)searchDisplay
{
    if (_searchDisplay == nil) {
        _searchDisplay = [[XLESearchDisplayController alloc] initWithSearchBar:nil];
        _searchDisplay.delegate = self;
    }
    return _searchDisplay;
}


- (BOOL)isSearch
{
    return self.searchDisplay.active;
}

- (NSMutableArray *)historyList
{
    if (_historyList == nil && [self.delegate respondsToSelector:@selector(onHistoryKeyInTableView:)]) {
        _historyList = [[XLEUserCache sharedCache] objectForKey:[self.delegate onHistoryKeyInTableView:nil]];
    }
    
    return _historyList;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 34)];
        _footerView.backgroundColor = [UIColor clearColor];
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = CGRectMake(5, 0, 100, 34);
        clearBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [clearBtn setTitleColor:XLE_TINT_COLOR forState:UIControlStateNormal];
        [clearBtn setTitleColor:[XLE_TINT_COLOR colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [clearBtn setTitle:@"清除历史记录" forState:UIControlStateNormal];
        clearBtn.titleLabel.font = XLE_MIDDLE_FONT;
        [clearBtn addTarget:self action:@selector(clearHistoryAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:clearBtn];
    }
    return _footerView;
}

- (XLELabel *)headerView {
    if (!_headerView) {
        _headerView =
        _headerView = [[XLELabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 34)];
        _headerView.insets = UIEdgeInsetsMake(9, 5, 0, 0);
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.textAlignment = NSTextAlignmentLeft;
        _headerView.textColor = XLE_TEXT_HEAVY_COLOR;
        _headerView.font = XLE_MIDDLE_FONT;
        _headerView.text = @"搜索历史";
    }
    return _headerView;
}

- (XLEPageModel *)pageModel{
    if (_pageModel == nil) {
        _pageModel = [[XLEPageModel alloc] init];
    }
    return _pageModel;
}

@end
