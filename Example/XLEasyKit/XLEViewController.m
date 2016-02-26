//
//  XLEViewController.m
//  XLEasyKit
//
//  Created by 闫晓亮 on 01/19/2016.
//  Copyright (c) 2016 闫晓亮. All rights reserved.
//

#import "XLEViewController.h"
#import "XLEButtonTestViewController.h"

@interface XLEViewController ()

@end

@implementation XLEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doAddItemsOperation{
    WS(weakSelf);
    [self.items addObject:[XLEDemoItem itemWithName:@"UIButton相关测试" desc:@"" callback:^{
        XLEButtonTestViewController *vc = [[XLEButtonTestViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }]];
}

@end
