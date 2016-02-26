//
//  XLEBaseTableViewDelegate.h
//  Pods
//
//  Created by Randy on 15/12/19.
//
//

#import <UIKit/UIKit.h>

@class XLEBaseTableView;

@protocol XLEBaseTableViewDelegate <UITableViewDelegate>

@optional
//默认no
- (void)tableView:(XLEBaseTableView *)tableView getMore:(void(^)(BOOL isSuc))callback;
//默认no
- (void)tableView:(XLEBaseTableView *)tableView refresh:(void(^)(BOOL isSuc))callback;

//默认no
- (BOOL)hasMoreInTableView:(XLEBaseTableView *)tableView;
//默认no
- (BOOL)hasRefreshInTableView:(XLEBaseTableView *)tableView;
//默认不显示 目前只支持最后一个section。
- (UIView *)viewForBlankInTableView:(XLEBaseTableView *)tableView;
//默认不显示 目前只支持最后一个section。
- (UIView *)viewForErrorInTableView:(XLEBaseTableView *)tableView;

@end
