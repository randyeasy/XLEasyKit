//
//  XLEImageSelectConfig.h
//  Pods
//
//  Created by Randy on 16/1/25.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XLEImagePickerAssetype) {
    XLE_IMAGEPICKER_ASSET_ANY = 0,
    XLE_IMAGEPICKER_ASSET_PHOTO,
    XLE_IMAGEPICKER_ASSET_VIDEO,
};

NS_ASSUME_NONNULL_BEGIN

@interface XLEImagePickerConfig : NSObject

@property (assign, nonatomic) XLEImagePickerAssetype assetType;

@property (assign, getter=isBatch, nonatomic) BOOL batch;//是否是批量选择
@property (assign, nonatomic) NSInteger maxNumberOfSelection;//选择的最大图片数，isBatch为YES时起作用
@property (assign, nonatomic) NSInteger minNumberOfSelection;//选择的最小图片数，isBatch为YES时起作用
@property (assign, nonatomic) BOOL hasFullImage;//是否发送原图，isBatch为YES时起作用

@property (copy, nonatomic) NSString *batchFinishTitle;//批量发送的时候 右下角的title 默认是 “完成”，isBatch为YES时起作用
@end

NS_ASSUME_NONNULL_END
