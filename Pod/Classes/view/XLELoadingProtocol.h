//
//  XLELoadingProtocol.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XLELoadingProtocol <NSObject>
@required
/**
 *  显示Loading
 *
 *  @param message 显示消息
 */
- (void)showWithMessage:(NSString *)message;

/**
 *  显示Loading
 *
 *  @param message 显示消息
 *  @param view    Super view
 */
- (void)showWithMessage:(NSString *)message toView:(UIView *)view;

/**
 *  显示GIF动画
 */
- (void)showWithMessage:(NSString *)messgae animated:(BOOL)animated;

/**
 *  显示GIF动画
 */
- (void)showWithMessage:(NSString *)messgae toView:(UIView *)view animated:(BOOL)animated;

/**
 *  隐藏Loading
 */
- (void)hide;

@end

NS_ASSUME_NONNULL_END
