//
//  UIImage+bjp.m
//  Pods
//
//  Created by Randy on 15/11/11.
//
//

#import "UIImage+XLE.h"
@implementation UIImage (XLE)
+ (UIImage *)xle_imageNamed:(NSString *)imageName;
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"XLEasyKit.bundle/%@",imageName]];
}

@end
