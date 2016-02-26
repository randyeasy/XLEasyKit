//
//  XLEImageSelectProxy.m
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import "XLEImageSelectController.h"
#import "XLEImagePickerController.h"
#import "XLEImagePickerHelper.h"
#import "UIActionSheet+XLEBlocks.h"
#import "XLEImageEditViewController.h"
#import "XLEImageBatchSelectBrowser.h"
#import "XLEImageSingleSelectBrowser.h"
#import "XLECameraHelper.h"
#import "XLEImagePickerConfig.h"
#import "XLEBrowserHelper.h"
#import "XLEAssetMananger.h"

#import "XLECameraViewController.h"

#import <objc/runtime.h>

@interface XLEImageSelectController ()
@property (strong, nonatomic) XLEImagePickerHelper *pickerHelper;
@property (strong, nonatomic) XLECameraHelper *cameraHelper;
@property (strong, nonatomic) XLEBrowserHelper *browserHelper;
@end

@implementation XLEImageSelectController

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)showBatchSelectController:(UIViewController *)parentVC
                      batchConfig:(XLEImagePickerConfig *)config
                        selectCallback:(void(^)(NSArray<XLEAssetModel *> *urls, BOOL isFullImage))callback;
{
    self.browserHelper = nil;
    
    __weak XLEImageSelectController *weakSelf = self;

    XLEImagePickerController *pickerController = [[XLEImagePickerController alloc] initWithPickerDelegate:self.pickerHelper config:config];
    
    __weak XLEImagePickerController *weakPicker = pickerController;
    self.pickerHelper.selectCallback = ^(NSArray<XLEAssetModel *> *assets) {
        if (callback) {
            callback(assets, weakSelf.browserHelper.isFullImage);
            [weakPicker dismissViewControllerAnimated:YES completion:^{
            }];
        }
    };
    self.pickerHelper.imagePickerCancel = ^(){
        [weakPicker dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.pickerHelper.imagePickerBrowser = ^(NSArray<XLEAssetModel *> *assets, NSMutableArray<XLEAssetModel *> *selectedAssets, NSInteger index){
        XLEImageBatchSelectBrowser *batchBrowser = [[XLEImageBatchSelectBrowser alloc] initWithAssets:assets selectedAssets:selectedAssets index:index fullImage:weakSelf.browserHelper.isFullImage];
        batchBrowser.finishTitle = config.batchFinishTitle;
        batchBrowser.delegate = weakSelf.browserHelper;
        batchBrowser.hasFullImage = config.hasFullImage;
        weakSelf.browserHelper.imageBrowserSend = ^(NSArray<XLEAssetModel *> * assets){
            if (callback) {
                callback(selectedAssets,weakSelf.browserHelper.isFullImage);
                [weakPicker dismissViewControllerAnimated:YES completion:^{
                }];
            }
        };
        
        weakSelf.browserHelper.imageBrowserCancel = ^(){
            [weakPicker popViewControllerAnimated:YES];
        };
        
        [weakPicker pushViewController:batchBrowser animated:YES];
    };
    
    [parentVC presentViewController:pickerController animated:YES completion:nil];
}

- (void)showSelectController:(UIViewController *)parentVC
              selectCallback:(XLESelectImageCallback)callback;
{
    [UIActionSheet xle_showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view withTitle:@"选择照片" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相册",@"拍照"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        switch (buttonIndex) {
            case 0:
            {
                [self showSelectControllerFromPhoto:parentVC selectCallback:callback];
                break;
            }
            case 1:
            {
                [self showSelectControllerFromCamera:parentVC cameraConfig:[XLECameraConfig new] selectCallback:callback];
                break;
            }
            default:
                break;
        }
    }];
    
}

- (void)showSelectControllerFromPhoto:(UIViewController *)parentVC
                   selectCallback:(XLESelectImageCallback)callback;
{
    [self showSingleSelectImageController:parentVC selectCallback:^(XLEAssetModel *asset, XLEImagePickerController *imagePicker) {
        XLEImageSingleSelectBrowser *browser = [[XLEImageSingleSelectBrowser alloc] initWithAsset:asset];
        __weak UIViewController *topVC = imagePicker.topViewController;
        __weak UINavigationController *weakPicker = imagePicker;
        browser.finishCallback = ^(UIViewController *vc, XLEAssetModel *finishAsset, BOOL used){
            if (used && callback) {
                callback(asset);
                [weakPicker dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [weakPicker popToViewController:topVC animated:YES];
            }
        };
        [weakPicker pushViewController:browser animated:YES];
    }];
}

- (void)showSelectControllerFromCamera:(UIViewController *)parentVC
                          cameraConfig:(XLECameraConfig *)config
                    selectCallback:(XLESelectImageCallback)callback;
{
    [self showCameraViewController:parentVC cameraConfig:config selectCallback:^(XLEAssetModel *asset,UINavigationController *navi) {
        XLEImageSingleSelectBrowser *browser = [[XLEImageSingleSelectBrowser alloc] initWithAsset:asset];
        __weak UIViewController *topVC = navi.topViewController;
        __weak UINavigationController *weakNavi = navi;
        browser.finishCallback = ^(UIViewController *vc, XLEAssetModel *finishAsset, BOOL used){
            if (used && callback) {
                callback(asset);
                [weakNavi dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [weakNavi popToViewController:topVC animated:NO];
            }
        };
        [weakNavi pushViewController:browser animated:NO];
    }];
}

- (void)showSelectController:(UIViewController *)parentVC
                    cropConfig:(XLEImageCropConfig *)cropConfig
              selectCallback:(XLESelectImageCallback)callback;
{
    [UIActionSheet xle_showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view withTitle:@"选择照片" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相册",@"拍照"] tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        switch (buttonIndex) {
            case 0:
            {
                [self showSelectControllerFromPhoto:parentVC cropConfig:cropConfig selectCallback:callback];
                break;
            }
            case 1:
            {
                [self showSelectControllerFromCamera:parentVC cameraConfig:[XLECameraConfig new]
                                          cropConfig:cropConfig
                                      selectCallback:callback];
                break;
            }
            default:
                break;
        }
    }];
}

- (void)showSelectControllerFromPhoto:(UIViewController *)parentVC
                           cropConfig:(XLEImageCropConfig *)cropConfig
                   selectCallback:(XLESelectImageCallback)callback;
{
    [self showSingleSelectImageController:parentVC selectCallback:^(XLEAssetModel *asset, XLEImagePickerController *imagePicker) {
        XLEImageEditViewController *edit = [[XLEImageEditViewController alloc] initWithAsset:asset config:cropConfig];
        __weak UIViewController *topVC = imagePicker.topViewController;
        __weak UINavigationController *weakPicker = imagePicker;
        edit.finishCallback = ^(UIViewController *vc, XLEAssetModel *finishAsset, BOOL used){
            if (callback && used) {
                callback(finishAsset);
                [weakPicker dismissViewControllerAnimated:YES completion:^{
                }];
            }
            else
            {
                [weakPicker popToViewController:topVC animated:YES];
            }
        };
        [weakPicker pushViewController:edit animated:YES];
    }];
}

- (void)showSelectControllerFromCamera:(UIViewController *)parentVC
                          cameraConfig:(XLECameraConfig *)config
                            cropConfig:(XLEImageCropConfig *)cropConfig
                    selectCallback:(XLESelectImageCallback)callback;
{
    [self showCameraViewController:parentVC cameraConfig:config selectCallback:^(XLEAssetModel *asset,UINavigationController *navi) {
        XLEImageEditViewController *edit = [[XLEImageEditViewController alloc] initWithAsset:asset config:cropConfig];
        __weak UIViewController *topVC = navi.topViewController;
        __weak UINavigationController *weakNavi = navi;
        edit.finishCallback = ^(UIViewController *vc, XLEAssetModel *finishAsset, BOOL used){
            if (callback && used) {
                callback(finishAsset);
                [weakNavi dismissViewControllerAnimated:YES completion:^{
                }];
            }
            else
            {
                [weakNavi popToViewController:topVC animated:NO];
            }
        };
        [weakNavi pushViewController:edit animated:NO];
    }];
}

#pragma mark - internal
- (void)showSingleSelectImageController:(UIViewController *)parentVC
                   selectCallback:(void(^)(XLEAssetModel *asset,XLEImagePickerController *imagePicker))callback;
{
    XLEImagePickerConfig *config = [[XLEImagePickerConfig alloc] init];
    config.assetType = XLE_IMAGEPICKER_ASSET_PHOTO;
    XLEImagePickerController *pickerController = [[XLEImagePickerController alloc] initWithPickerDelegate:self.pickerHelper config:config];
    __weak XLEImagePickerController *weakPicker = pickerController;
    self.pickerHelper.selectCallback =  ^(NSArray *urls) {
        if (callback) {
            if (urls.count>0) {
                
            }
            callback(urls[0],weakPicker);
        }
    };
    self.pickerHelper.imagePickerCancel = ^(){
        [weakPicker dismissViewControllerAnimated:YES completion:nil];
    };

    [parentVC presentViewController:pickerController animated:YES completion:nil];
}

- (void)showCameraViewController:(UIViewController *)parentVC
                    cameraConfig:(XLECameraConfig *)config
                  selectCallback:(void(^)(XLEAssetModel *asset,UINavigationController *navi))callback;
{
    XLECameraViewController *cameraPicker = [[XLECameraViewController alloc] initWithConfig:config];
    [cameraPicker showWithParentVC:parentVC cameraFinish:^(XLECameraViewController *cameraVC, BOOL isSuc, XLEAssetModel * _Nullable asset) {
        if (isSuc && callback) {
            callback(asset, cameraVC.navigationController);
        }
        else
        {
            [cameraVC dismissWithAnimated:YES completion:^{
                
            }];
        }
    }];
}

#pragma mark - set get
- (XLEImagePickerHelper *)pickerHelper{
    if (_pickerHelper == nil) {
        _pickerHelper = [[XLEImagePickerHelper alloc] init];
    }
    return _pickerHelper;
}

- (XLEBrowserHelper *)browserHelper
{
    if (_browserHelper == nil) {
        _browserHelper = [[XLEBrowserHelper alloc] init];
    }
    return _browserHelper;
}

- (XLECameraHelper *)cameraHelper{
    if (_cameraHelper == nil) {
        _cameraHelper = [[XLECameraHelper alloc] init];
    }
    return _cameraHelper;
}

@end
