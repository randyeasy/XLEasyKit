//
//  XLESearchDisplayTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLESearchDisplayTestVC.h"
#import "XLEListTestManager.h"

@interface XLESearchDisplayTestVC ()
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) XLEQuickSearchController *searchController;

@end

@implementation XLESearchDisplayTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"searchBar";
    [self.view addSubview:self.searchBar];
}

#pragma mark - delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first responder
{
    [self.searchController showSearch];
    return NO;
}

- (void)requestOpeGetMore:(XLEPageModel *)pageMode callback:(XLEListRequestCallback)callback;
{
    if (callback) {
        XLEPageModel *pageModel = [XLEPageModel new];
        pageModel.pageNum ++;
        pageModel.hasMore = NO;
        callback([XLEListTestManager testItems],pageModel,nil);
    }
}

- (void)requestOpeRefreshWithSearchStr:(NSString *)searchStr
                              callback:(XLEListRequestCallback)callback;
{
    if (callback) {
        XLEPageModel *pageModel = [XLEPageModel new];
        pageModel.pageNum ++;
        pageModel.hasMore = YES;
        callback([XLEListTestManager testItems],pageModel,nil);
    }
}

/**
 *   method
 *
 *  @param data      选择的item
 *  @param indexPath
 */
- (void)onTableView:(UITableView *)tableView
       selectedItem:(id)data
          indexPath:(NSIndexPath *)indexPath;
{
    XLELogInfo(@"点击 data:%@, row:%ld",data, (long)indexPath.row);
}

/**
 *   method
 *
 *  @param cell
 *  @param item
 */
- (void)onTableView:(UITableView *)tableView
         updateCell:(UITableViewCell *)cell
               item:(id<NSObject>)item
          indexPath:(NSIndexPath *)indexPath;
{
    XLETableViewCell *theCell = (XLETableViewCell *)cell;
    XLEDemoItem *demoItem = (XLEDemoItem *)item;
    theCell.nameLabel.text = demoItem.name;
}

/**
 *   method
 *
 *  @return 高度
 */
- (CGFloat)onTableView:(UITableView *)tableView
         heightForItem:(id)data
             indexPath:(NSIndexPath *)indexPath;
{
    return XLEApperanceInstance.rowHeight;
}
/**
 *  获取某一个item对应的cell
 *
 *  @param tableView
 *  @param data
 *  @param indexPath
 *
 *  @return cellClass
 */
- (Class)onTableView:(UITableView *)tableView
         cellForItem:(id)data
           indexPath:(NSIndexPath *)indexPath;
{
    return [XLETableViewCell class];
}

#pragma mark - set get
- (UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (XLEQuickSearchController *)searchController{
    if (_searchController == nil) {
        _searchController = [[XLEQuickSearchController alloc] initWithDelegate:self];
        _searchController.hasMore = YES;
        _searchController.requestDelegate = self;
        _searchController.blankClass = [XLEBlankView class];
        _searchController.errorClass = [XLEErrorView class];
    }
    return _searchController;
}


@end
