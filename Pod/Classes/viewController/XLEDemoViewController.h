//
//  XLEDemoViewController.h
//
//  Created by Randy on 16/1/20.
//  Copyright © 2016年 Randy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLEDemoItem : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) void(^handleBlock)();

+ (XLEDemoItem *)itemWithName:(NSString *)name desc:(nullable NSString *)desc callback:(void(^)())callback;

@end

@interface XLEDemoViewController : XLEBaseViewController
@property (strong, readonly, nonatomic) NSMutableArray<XLEDemoItem *> *items;

- (void)doAddItemsOperation NS_REQUIRES_SUPER;
- (void)showDemoResultString:(NSString *)result;
@end

NS_ASSUME_NONNULL_END
