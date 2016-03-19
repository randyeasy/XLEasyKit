//
//  XLEAliyunShowVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/3.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEAliyunShowVC.h"

@implementation XLEAliyunShowVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"阿里云图片裁剪测试";
    
    // Do any additional setup after loading the view from its nib.
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(50, 30, 100, 100);
    imageView.clipsToBounds = NO;
    imageView.contentMode = UIViewContentModeCenter;
    imageView.layer.borderColor = [UIColor blackColor].CGColor;
    imageView.layer.borderWidth = 2;
    switch (self.type) {
        case XLE_ALIYUN_ORIGINAL: {
            [imageView XLE_setImageWithURL:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg"]];
            break;
        }
        case XLE_ALIYUN_SCALE: {
            [imageView XLE_setImageWithURL:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg"] placeholderImage:nil size:CGSizeMake(100, 100)];
            break;
        }
        case XLE_ALIYUN_SCALE_CUT: {
            [imageView XLE_setImageWithURL:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg"] placeholderImage:nil size:CGSizeMake(100, 100) cut:YES];
            break;
        }
    }
    [self.view addSubview:imageView];
}

@end
