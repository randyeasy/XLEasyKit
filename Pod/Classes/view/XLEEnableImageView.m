//
//  BJPEnableImageView.m
//  Pods
//
//  Created by Randy on 15/11/16.
//
//

#import "XLEEnableImageView.h"

@interface XLEEnableImageView ()
@property (strong, nonatomic) UIImage *originalImage;
@end

@implementation XLEEnableImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setUnable:(BOOL)unable
{
    if (self.originalImage == nil) {
        self.originalImage = self.image;
    }
    
    if (unable) {
        //TODO gray
        self.image = self.originalImage;//[self.originalImage bjp_grayImage];
    }
    else
    {
        self.image = self.originalImage;
    }
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    self.originalImage = image;
}

@end
