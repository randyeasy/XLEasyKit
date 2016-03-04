//
//  XLEViewController.m
//  XLEasyKit
//
//  Created by 闫晓亮 on 01/19/2016.
//  Copyright (c) 2016 闫晓亮. All rights reserved.
//

#import "XLEViewController.h"
#import "XLEButtonTestViewController.h"
#import "XLEAliyunTestVC.h"
#import "XLEBaseVC.h"
#import "XLEViewManagerVC.h"
#import "XLESearchTestViewController.h"
#import "XLEListTestViewController.h"
#import "XLEApperenceTestVC.h"

@interface XLEViewController ()

@end

@implementation XLEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"demo";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doAddItemsOperation{
    XLEWS(weakSelf);
    [self.items addObject:[XLEDemoItem itemWithName:@"UIButton相关测试" desc:@"" callback:^{
        XLEButtonTestViewController *vc = [[XLEButtonTestViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"list相关测试" desc:@"" callback:^{
        XLEListTestViewController *vc = [[XLEListTestViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"search相关测试" desc:@"" callback:^{
        XLESearchTestViewController *vc = [[XLESearchTestViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"tip、loading、dailog等相关测试" desc:@"" callback:^{
        XLEViewManagerVC *vc = [[XLEViewManagerVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"阿里云图片相关测试" desc:@"" callback:^{
        XLEAliyunTestVC *vc = [[XLEAliyunTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"Base等相关测试" desc:@"NaviItem、图片模糊、baseViewController" callback:^{
        XLEBaseVC *vc = [[XLEBaseVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"全局外观相关测试" desc:@"" callback:^{
        XLEApperenceTestVC *vc = [[XLEApperenceTestVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
    
    [super doAddItemsOperation];
}

@end
