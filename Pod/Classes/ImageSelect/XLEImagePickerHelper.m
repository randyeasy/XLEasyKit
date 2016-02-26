//
//  XLEImagePickerHelper.m
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import "XLEImagePickerHelper.h"

@interface XLEImagePickerHelper ()
@end

@implementation XLEImagePickerHelper

- (void)imagePicker:(UINavigationController *)imagePicker didSelectAssets:(NSArray<XLEAssetModel *> *)imageAssets;
{
    if (self.selectCallback) {
        self.selectCallback(imageAssets);
    }
}

- (void)imagePickerDidCancel:(UINavigationController *)imagePicker;
{
    if (self.imagePickerCancel) {
        self.imagePickerCancel();
    }
}

- (void)imagePicker:(UINavigationController *)imagePicker didBrowserAssets:(NSArray<XLEAssetModel *> *)imageAssets selectedAssets:(NSMutableArray<XLEAssetModel *> *)selectedAssets assetIndex:(NSInteger)index;
{
    if (self.imagePickerBrowser) {
        self.imagePickerBrowser(imageAssets, selectedAssets, index);
    }
}

@end
