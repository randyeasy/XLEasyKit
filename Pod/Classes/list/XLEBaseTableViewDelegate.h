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
- (BOOL)hasMoreViewInTableView:(XLEBaseTableView *)tableView;
//默认no
- (BOOL)hasMoreDataInTableView:(XLEBaseTableView *)tableView;
//默认no
- (BOOL)hasRefreshInTableView:(XLEBaseTableView *)tableView;

/**
 *  当列表数据为空时会调用error和blank回调，优先调用error，如果error回调为空，则调用blank，此时任何一个回调有值都会在tableView上显示
 *
 *  @param UIView <#UIView description#>
 *
 *  @return <#return value description#>
 */
//默认不显示 目前只支持最后一个section。
- (UIView *)viewForBlankInTableView:(XLEBaseTableView *)tableView;
//默认不显示 目前只支持最后一个section。
- (UIView *)viewForErrorInTableView:(XLEBaseTableView *)tableView;

@end
