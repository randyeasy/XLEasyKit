//
//  XLEAlbumViewController.h
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import <UIKit/UIKit.h>
#import "XLEImagePickerDelegate.h"
@class XLEImagePickerConfig;

NS_ASSUME_NONNULL_BEGIN

@interface XLEAlbumViewController : UIViewController
@property (weak, nonatomic) id<XLEImagePickerDelegate> pickerDelegate;

- (instancetype)initWithConfig:(nullable XLEImagePickerConfig *)config;

@end

NS_ASSUME_NONNULL_END
