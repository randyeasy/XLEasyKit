//
//  XLEImagePickerController.h
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import <UIKit/UIKit.h>
#import "XLEImagePickerConfig.h"
#import "XLEImagePickerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLEImagePickerController : UINavigationController
@property (strong, readonly, nonatomic) XLEImagePickerConfig *config;

@property (weak, readonly, nonatomic) id<XLEImagePickerDelegate> pickerDelegate;

/**
 *  只能使用此初始化方法
 */
- (instancetype)initWithPickerDelegate:(id<XLEImagePickerDelegate>)pickerDelegate config:(XLEImagePickerConfig *)config;

@end

NS_ASSUME_NONNULL_END
