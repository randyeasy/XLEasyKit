//
//  XLEBaseTableView.h
//  Pods
//
//  Created by Randy on 15/12/19.
//
//

#import <UIKit/UIKit.h>
#import "XLEBaseTableViewDelegate.h"
#import "XLEKeyboardTableView.h"

@interface XLEBaseTableView : XLEKeyboardTableView

- (void)startRefresh;
- (void)showErrorView:(UIView *)errorView;
- (void)setDelegate:(id<XLEBaseTableViewDelegate>)delegate;

@end
