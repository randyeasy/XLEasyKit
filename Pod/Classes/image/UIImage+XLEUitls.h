//
//  UIImage+xleUitls.h
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (XLEUitls)

- (UIImage *)xle_imageToSize:(CGSize) size;
- (UIImage *)xle_grayImage;
- (UIImage *)xle_imageWithRenderingOriginal;
- (UIImage *)xle_imageWithRenderingTemplate;
+ (UIImage *)xle_imageWithColor:(UIColor *)color size:(CGSize)imgSize;
- (UIImage *)xle_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)xle_imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)xle_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

+ (UIImage *)xle_imageFromView:(UIView *)orgView;

+ (UIImage *)xle_imageFromAttributtedText:(NSAttributedString *)aAtt size:(CGSize)size;

@end
