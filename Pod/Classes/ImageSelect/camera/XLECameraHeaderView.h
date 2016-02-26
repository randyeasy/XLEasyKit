//
//  XLECameraHeaderView.h
//  Pods
//
//  Created by Randy on 16/2/2.
//
//

#import <UIKit/UIKit.h>
#import "XLECameraConfig.h"

@interface XLECameraHeaderView : UIView
@property (copy, nonatomic) void(^flashCallback)(XLECameraFlash flash);
@property (strong, readonly, nonatomic) UIButton *frontButton;

- (instancetype)initWithFlash:(XLECameraFlash)flash;
- (instancetype)initWithFrame:(CGRect)frame flash:(XLECameraFlash)flash;
@end
