//
//  XLEListBlankTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEListBlankTestVC.h"

@implementation XLEListBlankTestVC

- (instancetype)init
{
    XLETableConfigModel *config = [[XLETableConfigModel alloc] init];
    config.hasMore = NO;
    config.hasPull = YES;
    config.hasRemove = NO;
    
    self = [super initWithConfig:config];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"空白页";
    self.requestDelegate = self;
}

- (void)requestOpeRefresh:(XLEListRequestCallback)callback;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(nil,[XLEPageModel new],nil);
        }
    });
}

@end
