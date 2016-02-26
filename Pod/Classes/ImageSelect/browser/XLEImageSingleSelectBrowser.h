//
//  XLEImageSingleSelectBrowser.h
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import <UIKit/UIKit.h>

#import "XLEImageEditViewController.h"

@class XLEAssetModel;

@interface XLEImageSingleSelectBrowser : UIViewController
@property (copy, nonatomic) void(^finishCallback)(UIViewController *vc, XLEAssetModel *asset, BOOL used);

- (instancetype)initWithAsset:(XLEAssetModel *)asset;

@end
