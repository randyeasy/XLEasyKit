//
//  XLETipProtocol.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^XLETipCompletionBlock)();

@protocol XLETipProtocol <NSObject>
@required

/**
 *  显示XLETip
 *
 *  @param message 显示消息
 */
- (void)showWithMessage:(NSString *)message;

/**
 *  显示XLETip
 *
 *  @param message    显示消息
 *  @param completion 完成Block
 */
- (void)showWithMessage:(NSString *)message
             completion:(nullable XLETipCompletionBlock)completion;

/**
 *  显示XLETip
 *
 *  @param message    显示消息
 *  @param view       Super view
 *  @param completion 完成Block
 */
- (void)showWithMessage:(NSString *)message
                 toView:(UIView *)view
             completion:(nullable XLETipCompletionBlock)completion;

/**
 *  显示成功tip
 *
 *  @param message    显示消息
 *  @param completion 完成回调
 */
- (void)showWithSuccessMessage:(NSString *)message
                    completion:(nullable XLETipCompletionBlock)completion;

/**
 *  显示成功Tip
 *
 *  @param message    显示消息
 *  @param completion 完成Block
 */
- (void)showWithSuccessMessage:(NSString *)message
                        toView:(UIView *)view
                    completion:(nullable XLETipCompletionBlock)completion;
/**
 *  显示错误Tip
 *
 *  @param message    显示消息
 *  @param completion 完成Block
 */
- (void)showWithErrorMessage:(NSString *)message
                  completion:(nullable XLETipCompletionBlock)completion;

/**
 *  显示错误Tip
 *
 *  @param message    显示消息
 *  @param view       Super view
 *  @param completion 完成Block
 */
- (void)showWithErrorMessage:(NSString *)message
                      toView:(UIView *)view
                  completion:(nullable XLETipCompletionBlock)completion;

/**
 *  显示message和图片
 *
 *  @param message    显示消息
 *  @param image      显示icon
 *  @param view       super view
 *  @param completion 显示完成回调
 */
- (void)showWithMessage:(NSString *)message
                  image:(nullable UIImage *)image
                 toView:(UIView *)view
             completion:(nullable XLETipCompletionBlock)completion;

/**
 *  在状态栏显示消息内容
 *
 *  @param message    显示消息
 *  @param completion 完成block
 */
- (void)showInStatusBarWithMessage:(NSString *)message
                        completion:(XLETipCompletionBlock)completion;


@end

NS_ASSUME_NONNULL_END
