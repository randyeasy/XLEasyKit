//
//  XLETipLoadingDialogVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEViewManagerVC.h"

@implementation XLEViewManagerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tip、Loading、alert、pop";
    XLEApperanceInstance.loadingImagePath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    XLEApperanceInstance.tipErrorImage = [UIImage imageNamed:@"alert_error_icon"];
    XLEApperanceInstance.tipSucImage = [UIImage imageNamed:@"alert_success_Icon"];
}

- (void)doAddItemsOperation{
    [super doAddItemsOperation];
    XLEViewManager *viewManager = [XLEViewManager sharedInstance];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"alert" desc:@"弹框提示测试 只有消息和确定按钮" callback:^{
        [viewManager.alertEngine showWithMessage:@"弹框提示测试 只有消息和确定按钮"];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"alert" desc:@"弹框提示测试 只有标题、消息和确定按钮" callback:^{
        [viewManager.alertEngine showWithTitle:@"测试标题" message:@"弹框提示测试 只有标题、消息和确定按钮"];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"alert" desc:@"弹框提示测试 只有标题、消息 自定义取消按钮" callback:^{
        XLEBlockItem *item = [XLEBlockItem itemWithTitle:@"测试取消按钮" object:@"弹框提示测试 只有标题、消息 自定义取消按钮" callback:^(id<NSObject>  _Nullable object) {
            
        }];
        [viewManager.alertEngine showWithTitle:@"测试标题" message:@"弹框提示测试 只有标题、消息 自定义取消按钮" cancelButtonItem:item];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"alert" desc:@"弹框提示测试 只有标题、消息 自定义取消和确定按钮" callback:^{
        XLEBlockItem *cancelItem = [XLEBlockItem itemWithTitle:@"取消按钮测试" object:nil callback:^(id<NSObject>  _Nullable object) {
            
        }];
        XLEBlockItem *doneItem = [XLEBlockItem itemWithTitle:@"done按钮测试" object:nil callback:^(id<NSObject>  _Nullable object) {
            
        }];
        [[XLEViewManager sharedInstance].alertEngine showWithTitle:@"alert" message:@"弹框提示测试 只有标题、消息 自定义取消和确定按钮" cancelButtonItem:cancelItem doneButtonItem:doneItem];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"alert" desc:@"弹框提示测试 只有标题、消息 自定义取消和 多个其他按钮" callback:^{
        XLEBlockItem *cancelItem = [XLEBlockItem itemWithTitle:@"取消按钮测试" object:nil callback:^(id<NSObject>  _Nullable object) {
            
        }];
        XLEBlockItem *doneItem = [XLEBlockItem itemWithTitle:@"done1按钮测试" object:@"done1" callback:^(id<NSObject>  _Nullable object) {
            
        }];
        
        XLEBlockItem *doneItem2 = [XLEBlockItem itemWithTitle:@"done2按钮测试" object:@"done2" callback:^(id<NSObject>  _Nullable object) {
            
        }];
        [[XLEViewManager sharedInstance].alertEngine showWithTitle:@"alert" message:@"弹框提示测试 只有标题、消息 自定义取消和 多个其他按钮" cancelButtonItem:cancelItem otherButtonItems:@[doneItem, doneItem2]];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"loading" desc:@"普通的loading" callback:^{
        [[XLEViewManager sharedInstance].loadingEngine showWithMessage:@"正在加载"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[XLEViewManager sharedInstance].loadingEngine hide];
        });
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"loading" desc:@"普通的loading" callback:^{
        [[XLEViewManager sharedInstance].loadingEngine showWithMessage:@"正在加载"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[XLEViewManager sharedInstance].loadingEngine hide];
        });
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"loading" desc:@"动画的loading包含消息" callback:^{
        [[XLEViewManager sharedInstance].loadingEngine showWithMessage:@"努力加载中" animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[XLEViewManager sharedInstance].loadingEngine hide];
        });
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"loading" desc:@"只有动画的loading" callback:^{
        [[XLEViewManager sharedInstance].loadingEngine showWithMessage:@"" animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[XLEViewManager sharedInstance].loadingEngine hide];
        });
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"tip" desc:@"普通消息提示" callback:^{
        [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"普通消息提示"];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"tip" desc:@"成功消息提示" callback:^{
        [[XLEViewManager sharedInstance].tipEngine showWithSuccessMessage:@"成功消息提示" completion:nil];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"tip" desc:@"失败消息提示" callback:^{
        [[XLEViewManager sharedInstance].tipEngine showWithErrorMessage:@"失败消息提示" completion:nil];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"tip" desc:@"多行普通消息提示" callback:^{
        [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"多行普通消息提示多行普通消息提示多行普通消息提示多行普通消息提示多行普通消息提示"];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"tip" desc:@"多行成功消息提示" callback:^{
        [[XLEViewManager sharedInstance].tipEngine showWithSuccessMessage:@"多行成功消息提示多行成功消息提示多行成功消息提示多行成功消息提示多行成功消息提示多行成功消息提示" completion:nil];
    }]];
    
    [self.items addObject:[XLEDemoItem itemWithName:@"tip" desc:@"多行失败消息提示" callback:^{
        [[XLEViewManager sharedInstance].tipEngine showWithErrorMessage:@"多行失败消息提示多行失败消息提示多行失败消息提示多行失败消息提示多行失败消息提示失败消息提示" completion:nil];
    }]];
}

@end
