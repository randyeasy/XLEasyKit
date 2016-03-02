//
//  XLEListErrorTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEListErrorTestVC.h"

@interface XLEListErrorTestVC ()<XLEListRequestOpeProtocol>

@end

@implementation XLEListErrorTestVC


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
    self.title = @"错误页";
    self.requestDelegate = self;
}

- (void)requestOpeRefresh:(XLEListRequestCallback)callback;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(nil,nil,[XLEError errorWithSubsystem:16 code:1001 reason:@"测试错误信息"]);
        }
    });
}

@end
