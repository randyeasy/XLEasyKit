//
//  XLECSearchController.h
//  Pods
//
//  Created by Randy on 15/12/8.
//
//

#import <Foundation/Foundation.h>
#import "XLESearchDisplayController.h"
#import "XLEListRequestOpeProtocol.h"
#import "XLETableViewListDelegate.h"

@class XLEError;
@class XLEListTableViewCell;

@protocol XLEQuickSearchRequestDelegate <XLEListRequestOpeProtocol>

@required
- (void)requestOpeRefreshWithSearchStr:(NSString *)searchStr
                              callback:(XLEListRequestCallback)callback;

@end

@protocol XLEQuickSearchListDelegate <XLETableViewListDelegate>

- (NSString *)onHistoryKeyInTableView:(UITableView *)tableView;

@end

@interface XLEQuickSearchController : NSObject
@property (weak, nonatomic) id<XLEQuickSearchListDelegate> delegate;
@property (weak, nonatomic) id<XLEQuickSearchRequestDelegate> requestDelegate;

@property (assign, readonly, getter=isSearch, nonatomic) BOOL search;
@property (assign, nonatomic) CGFloat rowHeight;//默认44
@property (readonly, nonatomic) XLESearchDisplayController *searchDisplay;

@property (strong, nonatomic) Class blankClass;
@property (strong, nonatomic) Class errorClass;

- (void)showSearch;
- (void)closeSearch;

- (instancetype)initWithDelegate:(id<XLETableViewListDelegate>)delegate;

@end
