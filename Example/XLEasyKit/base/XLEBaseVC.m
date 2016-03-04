//
//  XLEBaseVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEBaseVC.h"
#import "XLEImageTestVC.h"
#import "XLENaviItemTestVC.h"
#import "XLENaviBarHiddenVC.h"
#import "XLERemoveTestVC.h"

@implementation XLEBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"基础测试";
}

- (void)doAddItemsOperation{
    [super doAddItemsOperation];
    
    XLEWS(weakSelf);
    
    [self.items addObject:[XLEDemoItem itemWithName:@"naviItem" desc:@"设置左右按钮 图片" callback:^{
        XLENaviItemTestVC *vc = [[XLENaviItemTestVC alloc] init];
        vc.type = XLE_NAVI_TEST_IMAGE;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"naviItem" desc:@"设置左右按钮 文字" callback:^{
        XLENaviItemTestVC *vc = [[XLENaviItemTestVC alloc] init];
        vc.type = XLE_NAVI_TEST_TITLE;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"naviItem" desc:@"设置左右按钮 图片URL" callback:^{
        XLENaviItemTestVC *vc = [[XLENaviItemTestVC alloc] init];
        vc.type = XLE_NAVI_TEST_IMAGEURL;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"naviItem" desc:@"设置多个左右按钮 图片" callback:^{
        XLENaviItemTestVC *vc = [[XLENaviItemTestVC alloc] init];
        vc.type = XLE_NAVI_TEST_IMAGE_MORE;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"naviItem" desc:@"设置多个左右按钮 文字" callback:^{
        XLENaviItemTestVC *vc = [[XLENaviItemTestVC alloc] init];
        vc.type = XLE_NAVI_TEST_TITLE_MORE;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"naviItem" desc:@"设置多个左右按钮 图片URL" callback:^{
        XLENaviItemTestVC *vc = [[XLENaviItemTestVC alloc] init];
        vc.type = XLE_NAVI_TEST_IMAGEURL_MORE;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"Image" desc:@"高斯模糊" callback:^{
        XLEImageTestVC *vc = [[XLEImageTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"XLEBaseViewController" desc:@"导航栏隐藏" callback:^{
        XLENaviBarHiddenVC *vc = [[XLENaviBarHiddenVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"XLEBaseViewController" desc:@"自动移除NavigationController中不用的视图控制器" callback:^{
        XLERemoveTestVC *vc = [[XLERemoveTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
}

@end
