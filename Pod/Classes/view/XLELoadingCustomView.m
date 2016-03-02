//
//  XLELoadingCustomView.m
//  Pods
//
//  Created by Randy on 16/3/2.
//
//

#import "XLELoadingCustomView.h"
#import <YLGIFImage/YLImageView.h>
#import <YLGIFImage/YLGIFImage.h>

@interface XLELoadingCustomView ()
@property (strong, nonatomic) YLImageView *imageView;
@end

@implementation XLELoadingCustomView

- (void)setLoadingImagePath:(NSString *)imagePath;
{
    YLGIFImage *gifImg = (YLGIFImage *)[YLGIFImage imageWithContentsOfFile:imagePath];
    self.imageView.image = gifImg;
    CGRect frame = self.frame;
    frame.size = gifImg.size;
    self.frame = frame;
    self.imageView.frame = self.bounds;
}

- (YLImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [YLImageView new];
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end
