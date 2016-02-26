//
//  XLEImageCropConfig.h
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import <Foundation/Foundation.h>

@interface XLEImageCropConfig : NSObject
@property (assign, nonatomic) CGRect cropRect;
@property (assign, nonatomic) CGFloat cropAspectRatio;
@property (assign, nonatomic) BOOL keepingCropAspectRatio;
@property (assign, nonatomic, getter = isRotationEnabled) BOOL rotationEnabled;
@end
