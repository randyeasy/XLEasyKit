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
#import "XLETableViewListDelegate.h"

@class XLETableConfigModel;

NS_ASSUME_NONNULL_BEGIN

@interface XLEBaseTableViewController : XLEBaseViewController<XLETableViewListDelegate>
@property (weak, nonatomic) id<XLEListRequestOpeProtocol> requestDelegate;
@property (strong, nonatomic) XLEBaseTableView *tableView;
@property (assign, nonatomic) UIEdgeInsets tableViewInsets;

@property (strong, nonatomic) XLEPageModel *pageModel;

/**
 *  控制是否每次进入界面的时候强制刷新 默认NO
 */
@property (assign, nonatomic) BOOL forceRefreshWhenViewAppear;

- (instancetype)initWithConfig:(XLETableConfigModel *)config;

@end

NS_ASSUME_NONNULL_END
