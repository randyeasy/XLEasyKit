//
//  XLEAlertProtocol.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XLEAlertProtocol <NSObject>
/**
 *  显示一条弹框消息 ，按钮title为"确定"
 *
 *  @param message 消息内容
 */
- (void)showWithMessage:(NSString *)message;

- (void)showWithTitle:(nullable NSString *)title
              message:(NSString *)message;

- (void)showWithMessage:(NSString *)message
       cancelButtonItem:(XLEBlockItem *)cancelItem;

- (void)showWithTitle:(nullable NSString *)title
              message:(NSString *)message
     cancelButtonItem:(XLEBlockItem *)cancelItem;

- (void)showWithTitle:(nullable NSString *)title
              message:(NSString *)message
     cancelButtonItem:(XLEBlockItem *)cancelItem
       doneButtonItem:(nullable XLEBlockItem *)doneItem;

- (void)showWithTitle:(nullable NSString *)title
              message:(NSString *)message
     cancelButtonItem:(XLEBlockItem *)cancelItem
     otherButtonItems:(nullable NSArray *)otherItems;
@end

NS_ASSUME_NONNULL_END