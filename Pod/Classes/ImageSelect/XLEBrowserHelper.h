//
//  XLEBrowserHelper.h
//  Pods
//
//  Created by Randy on 16/1/27.
//
//

#import <Foundation/Foundation.h>
#import "XLEImageBrowserDelegate.h"

@class XLEAssetModel;

@interface XLEBrowserHelper : NSObject<XLEImageBrowserDelegate>
@property (assign, getter=isFullImage, nonatomic) BOOL fullImage;
@property (copy, nonatomic) void(^imageBrowserSend)(NSArray<XLEAssetModel *> *assets);
@property (copy, nonatomic) void(^imageBrowserCancel)();
@end
