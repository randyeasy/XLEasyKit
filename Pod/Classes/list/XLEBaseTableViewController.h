//
//  XLEBaseTableViewController.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <UIKit/UIKit.h>
#import "XLEBaseViewController.h"
#import "XLEListRequestOpeProtocol.h"
#import "XLEBaseTableView.h"
#import "XLETableViewCell.h"

@class XLETableConfigModel;

NS_ASSUME_NONNULL_BEGIN

@interface XLEBaseTableViewController : XLEBaseViewController
@property (weak, nonatomic) id<XLEListRequestOpeProtocol> requestDelegate;
@property (strong, nonatomic) XLEBaseTableView *tableView;
@property (assign, nonatomic) UIEdgeInsets tableViewInsets;

@property (strong, nonatomic) XLEPageModel *pageModel;

/**
 *  控制是否每次进入界面的时候强制刷新 默认NO
 */
@property (assign, nonatomic) BOOL forceRefreshWhenViewAppear;

- (instancetype)initWithConfig:(XLETableConfigModel *)config;

/**
 *  override method
 *
 *  @param data      选择的item
 *  @param indexPath
 */
- (void)onTableView:(XLEBaseTableView *)tableView
       selectedItem:(id)data
          indexPath:(NSIndexPath *)indexPath;

/**
 *  override method
 *
 *  @param cell
 *  @param item
 */
- (void)onTableView:(XLEBaseTableView *)tableView
         updateCell:(UITableViewCell *)cell
                item:(id<NSObject>)item
          indexPath:(NSIndexPath *)indexPath;

/**
 *  override method
 *
 *  @return 高度
 */
- (CGFloat)onTableView:(XLEBaseTableView *)tableView
         heightForItem:(id)data
             indexPath:(NSIndexPath *)indexPath;

- (void)onTableView:(XLEBaseTableView *)tableView updateBlankView:(UIView *)blankView;
- (void)onTableView:(XLEBaseTableView *)tableView updateErrorView:(UIView *)blankView;

/**
 *  override method 点击Error或者空白等情况的按钮事件
 *
 *  @param sender sender
 */
- (void)onTapButton:(id)sender data:(id)data;

@end

NS_ASSUME_NONNULL_END
