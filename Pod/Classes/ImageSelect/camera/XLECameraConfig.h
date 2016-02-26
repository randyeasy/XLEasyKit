//
//  XLECameraConfig.h
//  Pods
//
//  Created by Randy on 16/2/2.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger ,XLECameraFlash){
    // The default state has to be off
    XLECameraFlashOff,
    XLECameraFlashOn,
    XLECameraFlashAuto
} ;

@interface XLECameraConfig : NSObject
@property (copy, nonatomic) NSString *quality;// 默认：AVCaptureSessionPresetHigh
@property (assign, nonatomic) XLECameraFlash flash; //默认：XLECameraFlashOff
@property (assign, getter=isFront, nonatomic) BOOL front;// 前置摄像头默认：NO
@end
