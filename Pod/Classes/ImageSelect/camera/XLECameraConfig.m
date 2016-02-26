//
//  XLECameraConfig.m
//  Pods
//
//  Created by Randy on 16/2/2.
//
//

#import "XLECameraConfig.h"
#import <AVFoundation/AVFoundation.h>

@implementation XLECameraConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _quality = AVCaptureSessionPresetHigh;
    }
    return self;
}

@end
