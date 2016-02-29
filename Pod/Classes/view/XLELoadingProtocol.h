//
//  XLELoadingProtocol.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>

@protocol XLELoadingProtocol <NSObject>
@required
/**
 *  显示TXLoading
 *
 *  @param message 显示消息
 */
+ (void)show:(NSString *)message;

/**
 *  显示TXLoading
 *
 *  @param message 显示消息
 *  @param view    Super view
 */
+ (void)show:(NSString *)message toView:(UIView *)view;

/**
 *  显示GIF动画
 */
+ (void)showAnimation:(NSString *)messgae;

/**
 *  显示GIF动画
 */
+ (void)showAnimation:(NSString *)messgae toView:(UIView *)view;

/**
 *  隐藏TXLoading
 */
+ (void)hide;

@end
