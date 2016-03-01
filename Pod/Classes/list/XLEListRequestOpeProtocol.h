//
//  XLEListRequestOpeProtocol.h
//  Pods
//
//  Created by Randy on 15/12/7.
//
//

#import <Foundation/Foundation.h>
#import "XLEPageModel.h"

@class XLEError;

typedef void (^XLEListRequestCallback)(NSArray *items, XLEPageModel *pageModel, XLEError *error);
typedef void (^XLEListRequestDeleteCallback)(XLEError *error);


@protocol XLEListRequestOpeProtocol <NSObject>
@optional
- (void)requestOpeRefresh:(XLEListRequestCallback)callback;

/**
 *  以下两个回调选择其中一个实现
 */
- (void)requestOpeGetMore:(XLEPageModel *)pageMode callback:(XLEListRequestCallback)callback;
- (void)requestOpeGetMoreWithLastItem:(id)lastItem callback:(XLEListRequestCallback)callback;


- (void)requestOpeDelete:(id<NSObject>)item callback:(XLEListRequestDeleteCallback)callback;

@end
