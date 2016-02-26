//
//  XLEAssetModel.m
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import "XLEAssetModel.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface XLEAssetModel ()
@property (strong, nonatomic) ALAsset *asset;

@property (strong, nonatomic) NSDictionary *pickerMediaInfo;

@property (strong, nonatomic) NSDictionary *cameraInfo;

@property (strong, nonatomic) UIImage *originalImage;
@property (assign, nonatomic) XLEImagePickerAssetype assetType;
@property (strong, nonatomic) NSURL *assetURL;

@property (assign, nonatomic) CGRect cropRect;
@property (strong, nonatomic) UIImage *cropImage;
@end

@implementation XLEAssetModel

- (instancetype)initWithAsset:(ALAsset *)asset;
{
    self = [super init];
    if (self) {
        _asset = asset;
    }
    return self;
}

- (instancetype)initWithMediaInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        _pickerMediaInfo = info;
    }
    return self;
}

- (instancetype)initWithCameraInfo:(NSDictionary *)info image:(UIImage *)image assetType:(XLEImagePickerAssetype)assetType;
{
    self = [super init];
    if (self) {
        _cameraInfo = info;
        _originalImage = image;
        _assetType = assetType;
    }
    return self;
}

- (UIImage *)originalImage;
{
    if (_originalImage) {
        return _originalImage;
    }
    else if (self.asset) {
        return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
    }
    else if (self.pickerMediaInfo)
    {
        UIImage *image = [self.pickerMediaInfo objectForKey:UIImagePickerControllerOriginalImage];
        return image;
    }
    return nil;
}

- (UIImage *)thumbnailImageWithSize:(CGSize)size;
{
    if (_originalImage) {//TODO
        return _originalImage;
    }
    else if (self.asset) {
        return [UIImage imageWithCGImage:self.asset.thumbnail];
    }
    else if (self.pickerMediaInfo)
    {
        //TODO
        UIImage *image = [self.pickerMediaInfo objectForKey:UIImagePickerControllerOriginalImage];
        return image;
    }
    return nil;
}

- (long long)originalImageSize;
{
    if (self.asset) {
        return [self.asset defaultRepresentation].size;
    }
    else if (self.pickerMediaInfo)
    {
        return 0;
    }
    return 0;
}

- (void)updateCropImage:(UIImage *)cropImage cropRect:(CGRect)cropRect;{
    self.cropRect = cropRect;
    self.cropImage = cropImage;
}

- (XLEImagePickerAssetype)assetType;
{
    if (self.asset) {
        NSString *assetType = [self.asset valueForKey:ALAssetPropertyType];
        if ([assetType isEqualToString:ALAssetTypePhoto]) {
            return XLE_IMAGEPICKER_ASSET_PHOTO;
        }
        else if ([assetType isEqualToString:ALAssetTypeVideo])
            return XLE_IMAGEPICKER_ASSET_VIDEO;
        return XLE_IMAGEPICKER_ASSET_ANY;
    }
    else if (self.pickerMediaInfo)
    {
        NSString *mediaType = [self.pickerMediaInfo objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            return XLE_IMAGEPICKER_ASSET_PHOTO;
        }
        else if ([mediaType isEqualToString:( NSString *)kUTTypeMovie])
            return XLE_IMAGEPICKER_ASSET_VIDEO;
        return XLE_IMAGEPICKER_ASSET_ANY;
    }
    return _assetType;
}

- (NSURL *)assetURL;
{
    if (self.asset) {
        return [[self.asset defaultRepresentation] url];
    }
    else if (self.pickerMediaInfo)
    {
        return [self.pickerMediaInfo objectForKey:UIImagePickerControllerMediaURL];
    }
    return nil;
}

- (id)copyWithZone:(nullable NSZone *)zone;
{
    XLEAssetModel *asset = nil;
    if (self.asset) {
        asset = [[XLEAssetModel alloc] initWithAsset:self.asset];
    }
    else if (self.pickerMediaInfo)
    {
        asset = [[XLEAssetModel alloc] initWithMediaInfo:self.pickerMediaInfo];
    }
    else
    {
        asset = [[XLEAssetModel alloc] init];
        asset.originalImage = self.originalImage;
        asset.assetType = self.assetType;
        asset.cropImage = self.cropImage;
        asset.cropRect = self.cropRect;
        asset.cameraInfo = self.cameraInfo;
    }
    return asset;
}

@end
