//
//  XLEListVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEListVC.h"
#import "XLEListTestManager.h"

@interface XLEListVC ()<XLEListRequestOpeProtocol>

@end

@implementation XLEListVC

- (instancetype)init
{
    XLETableConfigModel *config = [[XLETableConfigModel alloc] init];
    config.hasMore = NO;
    config.hasPull = NO;
    config.hasRemove = NO;
    
    self = [super initWithConfig:config];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.requestDelegate = self;
}

- (void)requestOpeRefresh:(XLEListRequestCallback)callback;
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

- (void)onTableView:(UITableView *)tableView updateBlankView:(UIView *)blankView;
{
    XLELogInfo(@"空白页更新回调");
}

- (void)onTableView:(UITableView *)tableView updateErrorView:(UIView *)blankView;{
    XLELogInfo(@"错误页更新回调");
    
}


@end
