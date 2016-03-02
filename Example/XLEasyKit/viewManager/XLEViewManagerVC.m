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
}

@end
