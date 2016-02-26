//
//  XLEImageCropConfig.m
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import "XLEImageCropConfig.h"

@implementation XLEImageCropConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cropAspectRatio = 1;
        _keepingCropAspectRatio = YES;
    }
    return self;
}

@end
