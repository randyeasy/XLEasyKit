//
//  XLESearchQuickTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLESearchQuickTestVC.h"
#import "XLEListTestManager.h"

@interface XLESearchQuickTestVC ()<
    XLEQuickSearchListDelegate,
    XLEQuickSearchRequestDelegate>
@property (strong, nonatomic) XLEQuickSearchController *searchController;
@end

@implementation XLESearchQuickTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"quick";
    
    self.searchController.requestDelegate = self;
    
    UIButton *theButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"搜索" forState:UIControlStateNormal];
        [button setTitleColor:XLE_TEXT_DARK_COLOR forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showSearchView) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    theButton.frame = CGRectMake(10, 30, 200, 44);
    [self.view addSubview:theButton];
}

- (void)showSearchView
{
    [self.searchController showSearch];
}

#pragma mark - delegate
- (NSString *)onHistoryKeyInTableView:(UITableView *)tableView;
{
    return @"searchQuickTest";
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
    if (self.showNodata) {
        callback(nil,[XLEPageModel new],nil);
    }
    else if (self.showError)
    {
        callback(nil,nil,[XLEError errorWithSubsystem:16 code:1001 reason:@"搜索错误"]);
    }
    else
    {
        if (callback) {
            XLEPageModel *pageModel = [XLEPageModel new];
            pageModel.pageNum ++;
            pageModel.hasMore = YES;
            callback([XLEListTestManager testItems],pageModel,nil);
        }
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

- (XLEQuickSearchController *)searchController{
    if (_searchController == nil) {
        _searchController = [[XLEQuickSearchController alloc] initWithDelegate:self];
        _searchController.hasMore = YES;
        _searchController.blankClass = [XLEBlankView class];
        _searchController.errorClass = [XLEErrorView class];
    }
    return _searchController;
}


@end
