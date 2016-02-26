//
//  XLEMJRefreshFactory.h
//  Pods
//
//  Created by Randy on 16/2/20.
//
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>

@interface XLEMJRefreshFactory : NSObject

+ (MJRefreshFooter *)createFooterWithBlock:(MJRefreshComponentRefreshingBlock)block;
+ (MJRefreshHeader *)createHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block;

@end
