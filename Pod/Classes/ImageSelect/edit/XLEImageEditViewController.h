//
//  XLEImageEditViewController.h
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import <UIKit/UIKit.h>

@class XLEAssetModel;
@class XLEImageCropConfig;

NS_ASSUME_NONNULL_BEGIN

@interface XLEImageEditViewController : UIViewController
@property (copy, nonatomic) void(^finishCallback)(UIViewController *vc, XLEAssetModel *asset, BOOL used);
- (instancetype)initWithAsset:(XLEAssetModel *)asset config:(nullable XLEImageCropConfig *)config;

@end

NS_ASSUME_NONNULL_END
