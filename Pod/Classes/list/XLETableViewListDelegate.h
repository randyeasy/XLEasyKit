//
//  XLEListDelegate.h
//  Pods
//
//  Created by Randy on 16/2/29.
//
//

#import <Foundation/Foundation.h>

@protocol XLETableViewListDelegate <NSObject>

@required
/**
 *   method
 *
 *  @param data      选择的item
 *  @param indexPath
 */
- (void)onTableView:(UITableView *)tableView
       selectedItem:(id)data
          indexPath:(NSIndexPath *)indexPath;

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

/**
 *   method
 *
 *  @return 高度
 */
- (CGFloat)onTableView:(UITableView *)tableView
         heightForItem:(id)data
             indexPath:(NSIndexPath *)indexPath;
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

@optional
- (void)onTableView:(UITableView *)tableView
    updateBlankView:(UIView *)blankView;

- (void)onTableView:(XLEBaseTableView *)tableView
    updateErrorView:(UIView *)errorView
              error:(XLEError *)error;

@end
