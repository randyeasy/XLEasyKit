//
//  XLETipProtocol.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>

typedef void (^XLETipCompletionBlock)();

@protocol XLETipProtocol <NSObject>
@required
/**
 *  显示XLETip
 *
 *  @param message 显示消息
 */
+ (void)show:(NSString *)message;
/**
 *  显示XLETip
 *
 *  @param message    显示消息
 *  @param completion 完成Block
 */
+ (void)show:(NSString *)message completion:(XLETipCompletionBlock)completion;
/**
 *  显示XLETip
 *
 *  @param message    显示消息
 *  @param view       Super view
 *  @param completion 完成Block
 */
+ (void)show:(NSString *)message toView:(UIView *)view completion:(XLETipCompletionBlock)completion;

/**
 *  显示成功Tip
 *
 *  @param message    显示消息
 *  @param completion 完成Block
 */
+ (void)showSuccess:(NSString *)message completion:(XLETipCompletionBlock)completion;
/**
 *  显示成功Tip
 *
 *  @param message    显示消息
 *  @param view       Super view
 *  @param completion 完成Block
 */
+ (void)showSuccess:(NSString *)message toView:(UIView *)view completion:(XLETipCompletionBlock)completion;

/**
 *  显示错误Tip
 *
 *  @param message    显示消息
 *  @param completion 完成Block
 */
+ (void)showError:(NSString *)message completion:(XLETipCompletionBlock)completion;
/**
 *  显示错误Tip
 *
 *  @param message    显示消息
 *  @param view       Super view
 *  @param completion 完成Block
 */
+ (void)showError:(NSString *)message toView:(UIView *)view completion:(XLETipCompletionBlock)completion;

@end
