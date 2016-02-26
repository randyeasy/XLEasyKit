//
//  XLEDialogProtocol.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>

typedef void(^XLEDialogCompletionBlock)(NSInteger buttonIndex);

@protocol XLEDialogProtocol <NSObject>
/**
 *  显示XLEDialog
 *
 *  @param message 显示消息
 */
+ (void)show:(NSString *)message;
/**
 *  显示XLEDialog
 *
 *  @param message  显示消息
 *  @param tapBlock 完成Block
 */
+ (void)show:(NSString *)message tapBlock:(XLEDialogCompletionBlock) tapBlock;
/**
 *  显示XLEDialog
 *
 *  @param title             标题
 *  @param message           消息
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitles 其他按钮标题
 *  @param tapBlock          完成Block
 */
+ (void)show:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(XLEDialogCompletionBlock) tapBlock;
@end
