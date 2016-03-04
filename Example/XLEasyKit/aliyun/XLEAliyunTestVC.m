//
//  XLEAliyunTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEAliyunTestVC.h"
#import "XLEAliyunShowVC.h"

@implementation XLEAliyunTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"阿里云图片测试";
}

- (void)doAddItemsOperation
{
    XLEWS(weakSelf);
    [super doAddItemsOperation];
    [self.items addObject:[XLEDemoItem itemWithName:@"阿里云图片" desc:@"原图" callback:^{
        XLEAliyunShowVC *vc = [[XLEAliyunShowVC alloc] init];
        vc.type = XLE_ALIYUN_ORIGINAL;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"阿里云图片" desc:@"缩放图片" callback:^{
        XLEAliyunShowVC *vc = [[XLEAliyunShowVC alloc] init];
        vc.type = XLE_ALIYUN_SCALE;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"阿里云图片" desc:@"缩放图片并裁剪" callback:^{
        XLEAliyunShowVC *vc = [[XLEAliyunShowVC alloc] init];
        vc.type = XLE_ALIYUN_SCALE_CUT;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
}

@end
