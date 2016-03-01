//
//  XLEListTestViewController.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEListTestViewController.h"
#import "XLEPullTestVC.h"
#import "XLEListVC.h"
#import "XLEListBlankTestVC.h"
#import "XLEListErrorTestVC.h"

@implementation XLEListTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"list测试";
}

- (void)doAddItemsOperation
{
    [super doAddItemsOperation];
    
    XLEWS(weakSelf);
    
    [self.items addObject:[XLEDemoItem itemWithName:@"列表展示" desc:@"都无" callback:^{
        XLEListVC *vc = [[XLEListVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"列表展示" desc:@"有下拉刷新、上拉加载、左滑删除" callback:^{
        XLEPullTestVC *vc = [[XLEPullTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"列表展示" desc:@"空白页" callback:^{
        XLEListBlankTestVC *vc = [[XLEListBlankTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"列表展示" desc:@"错误页" callback:^{
        XLEListErrorTestVC *vc = [[XLEListErrorTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
}

@end
