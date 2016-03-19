//
//  UIImageView+XLE.h
//  Pods
//
//  Created by Randy on 2/3/15.
//  Copyright (c) 2016 Randy. All rights reserved.
//

#import "UIImageView+XLE.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XLEImageManager.h"

@implementation UIImageView (XLE)

- (void)XLE_setImageWithURL:(NSURL *)url;
{
    [self XLE_setImageWithURL:url placeholderImage:nil];
}

- (void)XLE_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder;
{
    [self XLE_setImageWithURL:url placeholderImage:placeholder completed:nil];
}

- (void)XLE_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                  completed:(void(^)(UIImage *image, XLEError *error, NSURL *imageURL))completed;
{
    [self XLE_setImageWithURL:url placeholderImage:placeholder size:CGSizeZero completed:completed];
}

- (void)XLE_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                       size:(CGSize)size;
{
    [self XLE_setImageWithURL:url placeholderImage:placeholder size:size completed:nil];
}

- (void)XLE_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                       size:(CGSize)size
                  completed:(void(^)(UIImage *image, XLEError *error, NSURL *imageURL))completed;
{
    [self XLE_setImageWithURL:url placeholderImage:placeholder size:size cut:NO completed:completed];
}

-(void)XLE_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                      size:(CGSize)size
                       cut:(BOOL)cut;
{
    [self XLE_setImageWithURL:url placeholderImage:placeholder size:size cut:cut completed:nil];
}

- (NSString *)XLE_imageLoadParam:(BOOL)needCut size:(CGSize)size
{
    
    return [[XLEImageManager sharedInstance].loadEngine imageLoadParamWithCut:needCut size:size];
}

-(void)XLE_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                      size:(CGSize)size
                       cut:(BOOL)cut
                 completed:(void(^)(UIImage *image, XLEError *error, NSURL *imageURL))completed;
{
    if (url && ![url isFileURL]){
        if (!CGSizeEqualToSize(size, CGSizeZero)) {
            NSString *param = [self XLE_imageLoadParam:cut size:size];
            
            NSString *pathExtension = @"";
            if (url.absoluteString.pathExtension.length>0) {
                pathExtension = [NSString stringWithFormat:@".%@",url.absoluteString.pathExtension];
            }
            NSRange r = [url.absoluteString rangeOfString:@"?"];
            if (r.location == NSNotFound){
                url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", url.absoluteString, param,pathExtension]];
            } else {
                NSString *urlStr = @"";
                if (pathExtension.length>0) {
                    urlStr = [NSString stringWithFormat:@"%@%@%@", [url.absoluteString substringToIndex:r.location], param, pathExtension];
                }
                else
                {
                    urlStr = [NSString stringWithFormat:@"%@%@%@", [url.absoluteString substringToIndex:r.location], param, [url.absoluteString substringFromIndex:r.location]];
                }
                url = [NSURL URLWithString:urlStr];
            }
        }
        [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    else if ([url isFileURL])
    {
        [self setImage:[UIImage imageWithContentsOfFile:[url relativePath]]];
    }
    else{
        [self setImage:placeholder];
    }
}

@end
