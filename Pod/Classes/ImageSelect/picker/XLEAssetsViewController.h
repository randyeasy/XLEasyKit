//
//  XLEAssetsViewController.h
//  Pods
//
//  Created by Randy on 16/1/21.
//  TODO 检测PhotoLibrary的图片库有变化，及时更新
//
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XLEImagePickerDelegate.h"

@class XLEImagePickerConfig;

NS_ASSUME_NONNULL_BEGIN

@interface XLEAssetsViewController : UIViewController
@property (weak, nonatomic) id<XLEImagePickerDelegate> pickerDelegate;

/**
 *  初始化方法，只能通过此方法初始化
 *
 *  @param group  可为空 为空时默认选择photo role
 *  @param config 可为空，为空时为单选，并且assetType 为any
 *
 *  @return 
 */
- (instancetype)initWithAssetGroup:(nullable ALAssetsGroup *)group config:(nullable XLEImagePickerConfig *)config;

@end

NS_ASSUME_NONNULL_END
