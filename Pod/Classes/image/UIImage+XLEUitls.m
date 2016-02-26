//
//  UIImage+xleUitls.m
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import "UIImage+XLEUitls.h"

@implementation UIImage (XLEUitls)

- (UIImage *)xle_imageToSize:(CGSize) size

{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (UIImage*)xle_grayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context) scale:self.scale orientation:self.imageOrientation];
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage *)xle_imageWithRenderingOriginal
{
    if ([self respondsToSelector:@selector(imageWithRenderingMode:)]) {
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (UIImage *)xle_imageWithRenderingTemplate
{
    if ([self respondsToSelector:@selector(imageWithRenderingMode:)]) {
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return self;
}

- (UIImage *)xle_imageWithTintColor:(UIColor *)tintColor
{
    return [self xle_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)xle_imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self xle_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)xle_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage *)xle_imageWithColor:(UIColor *)color size:(CGSize)imgSize
{
    CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);
    UIImage *_img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return _img;
}

+ (UIImage *)xle_imageFromView:(UIView *)orgView{
    UIGraphicsBeginImageContext(orgView.bounds.size);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)xle_imageFromAttributtedText:(NSAttributedString *)aAtt size:(CGSize)size
{
    NSAssert(size.width>0&&size.height>0, @"imageFromAttributtedText 申请的图片size为0");
    size = CGSizeMake(size.width*2, size.height*2);
    UIGraphicsBeginImageContext(size);
    [aAtt drawInRect:CGRectMake((size.width-aAtt.size.width)/2.0f, (size.height-aAtt.size.height)/2.0f, aAtt.size.width, aAtt.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:image.imageOrientation];
    
    return [image xle_imageWithRenderingOriginal];
}

@end
