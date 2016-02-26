//
//  XLEAssetModel.h
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XLEImagePickerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLEAssetModel : NSObject<NSCopying>

- (instancetype)initWithAsset:(ALAsset *)asset;
- (instancetype)initWithMediaInfo:(NSDictionary *)info;
- (instancetype)initWithCameraInfo:(NSDictionary *)info image:(UIImage *)image assetType:(XLEImagePickerAssetype)assetType;

- (UIImage *)originalImage;
/**
 *  不一定有这个值
 *
 *  @return 图片的内存占用大小
 */
- (long long)originalImageSize;

/**
 *  根据size获取缩略图 8.0以上size生效
 *
 *  @param size 要获取的缩略图大小
 *
 *  @return 合适的缩略图图片
 */
- (UIImage *)thumbnailImageWithSize:(CGSize)size;

/**
 *  不一定有值，只有调用updateCropImage方法之后才会有值
 *
 *  @return
 */
- (nullable UIImage *)cropImage;
/**
 *  裁剪大小
 *
 *  @return
 */
- (CGRect)cropRect;

- (XLEImagePickerAssetype)assetType;

/**
 *  图片资源对应的url
 *
 *  @return url 拍照的不会有这个值
 */
- (NSURL *)assetURL;

- (void)updateCropImage:(UIImage *)cropImage cropRect:(CGRect)cropRect;

@end

NS_ASSUME_NONNULL_END
