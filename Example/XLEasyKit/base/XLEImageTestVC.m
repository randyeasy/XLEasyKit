//
//  XLEImageTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/3.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEImageTestVC.h"

@interface XLEImageTestVC ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation XLEImageTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.imageView];
    self.title = @"高斯模糊";
    UIImage *image = [UIImage imageNamed:@"image.jpg"];
    self.imageView.image = [XLEImageEffects imageByApplyingBlurToImage:image withRadius:6 tintColor:[UIColor colorWithWhite:1.0 alpha:0.6] saturationDeltaFactor:1 maskImage:nil];
}

#pragma mark - set get
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _imageView;
}

@end
