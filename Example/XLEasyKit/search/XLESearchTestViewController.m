//
//  XLESearchTestViewController.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLESearchTestViewController.h"
#import "XLESearchDisplayTestVC.h"
#import "XLESearchQuickTestVC.h"

@implementation XLESearchTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"search";
}

- (void)doAddItemsOperation{
    [super doAddItemsOperation];
    XLEWS(weakSelf);
    [self.items addObject:[XLEDemoItem itemWithName:@"搜索展示" desc:@"按钮点击显示搜索 有数据显示" callback:^{
        XLESearchQuickTestVC *vc = [[XLESearchQuickTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"搜索展示" desc:@"按钮点击显示搜索 无数据显示" callback:^{
        XLESearchQuickTestVC *vc = [[XLESearchQuickTestVC alloc] init];
        vc.showNodata = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"搜索展示" desc:@"按钮点击显示搜索 错误数据显示" callback:^{
        XLESearchQuickTestVC *vc = [[XLESearchQuickTestVC alloc] init];
        vc.showError = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];

    [self.items addObject:[XLEDemoItem itemWithName:@"搜索展示" desc:@"展示XLEBaseSearchBar" callback:^{
        XLESearchDisplayTestVC *vc = [[XLESearchDisplayTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
}

@end
