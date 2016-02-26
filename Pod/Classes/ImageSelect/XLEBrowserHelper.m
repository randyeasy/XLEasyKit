//
//  XLEBrowserHelper.m
//  Pods
//
//  Created by Randy on 16/1/27.
//
//

#import "XLEBrowserHelper.h"
#import "XLEAssetModel.h"

@implementation XLEBrowserHelper

- (void)imageBrowser:(UIViewController *)imageBrowser didSelectAssets:(NSArray<XLEAssetModel *> *)imageAssets;{
    if (self.imageBrowserSend) {
        self.imageBrowserSend(imageAssets);
    }
}

- (void)imageBrowser:(UIViewController *)imageBrowser fullImage:(BOOL)isFullImage;
{
    self.fullImage = isFullImage;
}

- (void)imageBrowserDidCancel:(UIViewController *)imageBrowser;
{
    if (self.imageBrowserCancel) {
        self.imageBrowserCancel();
    }
}

@end
