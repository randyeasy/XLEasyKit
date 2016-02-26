//
//  XLECameraViewController.m
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import "XLECameraHelper.h"
#import <AVFoundation/AVFoundation.h>
#import "XLEAssetModel.h"
#import "UIAlertView+XLEBlock.h"

@interface XLECameraHelper ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (copy, nonatomic)void(^cameraFinish)(XLEAssetModel *asset, BOOL isSuc);

@end

@implementation XLECameraHelper


- (void)showWithParentVC:(UIViewController *)vc finish:(void(^)(XLEAssetModel *asset, BOOL isSuc))finish
{
    [self isCameraAuthorized:^(BOOL authed) {
        if (authed) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //_imagePicker.showsCameraControls = NO;
                BOOL show = YES;
                if (self.frontCamera) {
                    BOOL isRearSupport = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
                    if (isRearSupport) {
                        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                    }else
                    {
                        show = NO;
                        UIAlertView *show = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持前置摄像头" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                        [show show];
                    }
                }
                if (show) {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                        self.imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    }
                    self.cameraFinish = finish;
                    [vc presentViewController:self.imagePicker animated:YES completion:nil];
                }
            }else
            {
                UIAlertView *show = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持摄像头" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [show show];
            }
        }
    }];
}

- (void)isCameraAuthorized:(void (^)(BOOL authed)) callback
{
    // iOS7.0及以上
    if ([[AVCaptureDevice class] respondsToSelector:@selector(authorizationStatusForMediaType:)]){
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
        {
            UIAlertView *show = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请去隐私设置打开应用的\"相机\"访问权限" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [show xle_showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:appSettings]) {
                            [[UIApplication sharedApplication] openURL:appSettings];
                        }
                    }
                }
            }];
            callback(NO);
        } else if (authStatus == AVAuthorizationStatusAuthorized){
            callback(YES);
        } else { // AVAuthorizationStatusNotDetermined
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                // Make sure we execute our code on the main thread so we can update the UI immediately.
                //
                // See documentation for ABAddressBookRequestAccessWithCompletion where it says
                // "The completion handler is called on an arbitrary queue."
                //
                // Though there is no similar mention for requestAccessForMediaType, it appears it does
                // the same thing.
                //
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(granted);
                });
            }];
        }
        
    } else {
        if ([AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].count) {
            callback(YES);
        } else {
            callback(NO);
        }
    }
}

#pragma mark - imagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    XLEAssetModel *asset = [[XLEAssetModel alloc] initWithMediaInfo:info];
    if (self.cameraFinish) {
        self.cameraFinish(asset, YES);
    }
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - set get
- (void)setFrontCamera:(BOOL)frontCamera{
    _frontCamera = frontCamera;
    if (frontCamera) {
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    else{
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}

- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            _imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
    }
    return _imagePicker;
}

@end
