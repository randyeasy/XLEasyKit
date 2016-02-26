//
//  XLEImagePickerDelegate.h
//  Pods
//
//  Created by Randy on 16/1/25.
//
//

#import <UIKit/UIKit.h>

@class XLEAssetModel;

@protocol XLEImagePickerDelegate <NSObject>

- (void)imagePicker:(UINavigationController *)imagePicker didSelectAssets:(NSArray<XLEAssetModel *> *)imageAssets;

@optional
- (void)imagePickerDidCancel:(UINavigationController *)imagePicker;
- (BOOL)imagePicker:(UINavigationController *)imagePicker shouldSelectAsset:(XLEAssetModel *)assetURL;
- (void)imagePicker:(UINavigationController *)imagePicker didBrowserAssets:(NSArray<XLEAssetModel *> *)imageAssets selectedAssets:(NSMutableArray<XLEAssetModel *> *)selectedAssets assetIndex:(NSInteger)index;

@end
