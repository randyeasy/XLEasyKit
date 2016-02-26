//
//  XLECameraViewController.h
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import <UIKit/UIKit.h>

@class XLEAssetModel;

@interface XLECameraHelper : NSObject<UIImagePickerControllerDelegate>
@property (assign, getter=isFrontCamera, nonatomic) BOOL frontCamera;
@property (nonatomic, readonly, strong) UIImagePickerController *imagePicker;

- (void)showWithParentVC:(UIViewController *)vc finish:(void(^)(XLEAssetModel *asset, BOOL isSuc))finish;
@end
