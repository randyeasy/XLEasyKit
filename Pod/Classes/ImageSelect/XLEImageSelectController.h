//
//  XLEImageSelectProxy.h
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import <Foundation/Foundation.h>
#import "XLEImageCropConfig.h"
#import "XLEImagePickerConfig.h"
#import "XLECameraConfig.h"

@class XLEAssetModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^XLESelectImageCallback)(XLEAssetModel *asset);

@interface XLEImageSelectController : NSObject
+ (instancetype)sharedInstance;

/**
 *  从相册批量选择
 *
 *  @param parentVC 父视图，用于presentViewController
 *  @param batchConfig      批量选择的配置
 *  @param callback 选择回调，选取成功才走 XLEAssetModel对象在block执行完后会失效，请另外保存原图或者url
 */
- (void)showBatchSelectController:(UIViewController *)parentVC
                      batchConfig:(XLEImagePickerConfig *)config
                   selectCallback:(void(^)(NSArray<XLEAssetModel *> *asserts, BOOL isFullImage))callback;

/**
 *  单个选择图片，先弹出actionSheet选择相册或拍照
 *
 *  @param parentVC 父视图，用于presentViewController
 *  @param callback 选择成功的回调
 */
- (void)showSelectController:(UIViewController *)parentVC
              selectCallback:(XLESelectImageCallback)callback;

/**
 *  通过相册单个选择图片
 *
 *  @param parentVC 父视图，用于presentViewController
 *  @param callback 选择成功的回调
 */
- (void)showSelectControllerFromPhoto:(UIViewController *)parentVC
                   selectCallback:(XLESelectImageCallback)callback;

/**
 *  通过拍照单个选择图片
 *
 *  @param parentVC 父视图，用于presentViewController
 *  @param callback 选择成功的回调
 */
- (void)showSelectControllerFromCamera:(UIViewController *)parentVC
                          cameraConfig:(XLECameraConfig *)config
                    selectCallback:(XLESelectImageCallback)callback;

/**
 *  单个选择图片，先弹出actionSheet选择相册或拍照 图片可裁剪
 *
 *  @param parentVC 父视图，用于presentViewController
 *  @param cropConfig     裁剪配置
 *  @param callback 选择成功的回调
 */
- (void)showSelectController:(UIViewController *)parentVC
                  cropConfig:(XLEImageCropConfig *)cropConfig
              selectCallback:(XLESelectImageCallback)callback;

/**
 *  通过相册单个选择图片 图片可裁剪
 *
 *  @param parentVC 父视图，用于presentViewController
 *  @param cropConfig     裁剪配置
 *  @param callback 选择成功的回调
 */
- (void)showSelectControllerFromPhoto:(UIViewController *)parentVC
                  cropConfig:(XLEImageCropConfig *)cropConfig
              selectCallback:(XLESelectImageCallback)callback;
/**
 *  通过拍照单个选择图片 图片可裁剪
 *
 *  @param parentVC 父视图，用于presentViewController
 *  @param cropConfig     裁剪配置
 *  @param callback 选择成功的回调
 */
- (void)showSelectControllerFromCamera:(UIViewController *)parentVC
                          cameraConfig:(XLECameraConfig *)config
                            cropConfig:(XLEImageCropConfig *)cropConfig
                    selectCallback:(XLESelectImageCallback)callback;

@end

NS_ASSUME_NONNULL_END
