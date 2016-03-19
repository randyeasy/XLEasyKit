//
//  XLERemoveTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/4.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLERemoveTestVC.h"

@implementation XLERemoveTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    XLEWS(weakSelf);
    self.title = @"push到下一级的时候自动消失";
    
    self.shouldRomoveWhenViewDisappear = YES;
    [self XLE_setNaviRightWithNaviItem:[XLENaviButtonItem naviItemWithTitle:@"next" block:^(XLENaviButtonItem *naviItem) {
        XLEBaseViewController *vc = [[XLEBaseViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    XLELogTrace();
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    XLELogTrace();
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    XLELogTrace();
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    XLELogTrace();
}

@end
