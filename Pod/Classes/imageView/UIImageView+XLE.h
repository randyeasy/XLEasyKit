//
//  UIImageView+XLE.h
//  Pods
//
//  Created by Randy on 2/3/15.
//  Copyright (c) 2016 Randy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLEError;

@interface UIImageView (XLE)
/**
 *  加载原图
 *
 *  @param url 图片地址
 */
- (void)XLE_setImageWithURL:(NSURL *)url;

/**
 *  加载原图
 *
 *  @param url         图片地址
 *  @param placeholder 默认图片
 */
- (void)XLE_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder;
- (void)XLE_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                  completed:(void(^)(UIImage *image, XLEError *error, NSURL *imageURL))completed;
;

/**
 *  缩放图片 传CGSizeZero时为原图
 *
 *  @param url         图片地址
 *  @param placeholder 默认图片
 *  @param size        返回的图片大小
 */
- (void)XLE_setImageWithURL:(NSURL *)url
                  placeholderImage:(UIImage *)placeholder
                       size:(CGSize)size;
- (void)XLE_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                       size:(CGSize)size
                  completed:(void(^)(UIImage *image, XLEError *error, NSURL *imageURL))completed;

/**
 *  缩放并裁剪图片 传CGSizeZero时为原图
 *
 *  @param url         图片地址
 *  @param placeholder 默认图片
 *  @param size        返回的图片大小
 *  @param cut         是否裁剪
 */
-(void)XLE_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                      size:(CGSize)size
                       cut:(BOOL)cut;
-(void)XLE_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                      size:(CGSize)size
                       cut:(BOOL)cut
                 completed:(void(^)(UIImage *image, XLEError *error, NSURL *imageURL))completed;

@end
