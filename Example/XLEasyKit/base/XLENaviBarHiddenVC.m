//
//  XLENaviBarHiddenVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/4.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLENaviBarHiddenVC.h"

@implementation XLENaviBarHiddenVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *theButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"显示有导航" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showNext) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    theButton.frame = CGRectMake(30, 100, 200, 44);
    [self.view addSubview:theButton];
    
    UIButton *backButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(XLE_onBack) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    backButton.frame = CGRectMake(30, 50, 200, 44);
    [self.view addSubview:backButton];
}

#pragma mark - set get
- (void)showNext
{
    XLEBaseViewController *vc = [[XLEBaseViewController alloc] init];
    vc.title = @"有导航";
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)hidesNavigationBarWhenPushed
{
    return YES;
}

@end
