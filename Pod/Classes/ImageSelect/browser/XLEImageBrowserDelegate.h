//
//  XLEImageBrowserDelegate.h
//  Pods
//
//  Created by Randy on 16/1/27.
//
//

#import <Foundation/Foundation.h>

@class XLEAssetModel;

@protocol XLEImageBrowserDelegate <NSObject>

- (void)imageBrowser:(UIViewController *)imageBrowser didSelectAssets:(NSArray<XLEAssetModel *> *)imageAssets;

@optional
- (void)imageBrowserDidCancel:(UIViewController *)imageBrowser;
- (void)imageBrowser:(UIViewController *)imageBrowser fullImage:(BOOL)isFullImage;
- (BOOL)imageBrowser:(UIViewController *)imageBrowser shouldSelectAsset:(XLEAssetModel *)assetURL;

@end
