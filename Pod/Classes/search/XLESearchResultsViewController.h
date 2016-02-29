//
//  XLESearchResultsTableViewController.h
//  Pods
//
//  Created by binluo on 15/12/16.
//
//

#import <UIKit/UIKit.h>
#import "XLEBaseTableView.h"
#import "XLEBaseViewController.h"

@interface XLESearchResultsViewController : XLEBaseViewController<UITableViewDataSource, XLEBaseTableViewDelegate>

@property (nonatomic, strong, null_resettable) XLEBaseTableView *tableView;

@end
