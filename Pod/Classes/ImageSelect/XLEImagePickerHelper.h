//
//  XLEImagePickerHelper.h
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import <Foundation/Foundation.h>
#import "XLEImagePickerController.h"

typedef void(^XLEImagePickerSelectCallback) (NSArray<XLEAssetModel *> *urls);

@interface XLEImagePickerHelper : NSObject<XLEImagePickerDelegate>
@property (copy, nonatomic) XLEImagePickerSelectCallback selectCallback;
@property (copy, nonatomic) void(^imagePickerCancel)();
@property (copy, nonatomic) void(^imagePickerBrowser)(NSArray<XLEAssetModel *> *assets, NSMutableArray<XLEAssetModel *> *selectedAssets, NSInteger index);
@end
