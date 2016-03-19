//
//  XLENaviItemTestVC.m
//  XLEasyKit
//
//  Created by Randy on 16/3/3.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLENaviItemTestVC.h"

@implementation XLENaviItemTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    XLEWS(weakSelf);
    
    switch (self.type) {
        case XLE_NAVI_TEST_IMAGE: {
            [self XLE_setNaviLeftWithNaviItem:[XLENaviButtonItem naviItemWithImage:[UIImage imageNamed:@"XLE_back"] block:^(XLENaviButtonItem *naviItem) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }]];
            
            [self XLE_setNaviRightWithNaviItem:[XLENaviButtonItem naviItemWithImage:[UIImage imageNamed:@"XLE_right"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧成功" toView:weakSelf.view completion:nil];
            }]];
            break;
        }
        case XLE_NAVI_TEST_TITLE: {
            [self XLE_setNaviLeftWithNaviItem:[XLENaviButtonItem naviItemWithTitle:@"左侧" block:^(XLENaviButtonItem *naviItem) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }]];
            
            [self XLE_setNaviRightWithNaviItem:[XLENaviButtonItem naviItemWithTitle:@"右侧" block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧成功" toView:weakSelf.view completion:nil];
            }]];
            break;
        }
        case XLE_NAVI_TEST_IMAGEURL: {
            [self XLE_setNaviLeftWithNaviItem:[XLENaviButtonItem naviItemWithImageUrl:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg@40w_30h_1o_2x_1e_1c.jpg"] block:^(XLENaviButtonItem *naviItem) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }]];
            
            [self XLE_setNaviRightWithNaviItem:[XLENaviButtonItem naviItemWithImageUrl:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg@40w_30h_1o_2x_1e_1c.jpg"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧成功" toView:weakSelf.view completion:nil];
            }]];
            break;
        }
        case XLE_NAVI_TEST_IMAGE_MORE: {
            XLENaviButtonItem *item1 = [XLENaviButtonItem naviItemWithImage:[UIImage imageNamed:@"XLE_back"] block:^(XLENaviButtonItem *naviItem) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            
            XLENaviButtonItem *item2 = [XLENaviButtonItem naviItemWithImage:[UIImage imageNamed:@"XLE_back"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击左侧2成功" toView:weakSelf.view completion:nil];

            }];
            [self XLE_setNaviLeftWithNaviItems:@[item1, item2]];
            
            XLENaviButtonItem *rightItem1 = [XLENaviButtonItem naviItemWithImage:[UIImage imageNamed:@"XLE_right"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧1成功" toView:weakSelf.view completion:nil];
            }];
            
            XLENaviButtonItem *rightItem2 = [XLENaviButtonItem naviItemWithImage:[UIImage imageNamed:@"XLE_right"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧2成功" toView:weakSelf.view completion:nil];
            }];
            
            [self XLE_setNaviRightWithNaviItems:@[rightItem1, rightItem2]];
            break;
        }
        case XLE_NAVI_TEST_TITLE_MORE: {
            XLENaviButtonItem *item = [XLENaviButtonItem naviItemWithTitle:@"左侧" block:^(XLENaviButtonItem *naviItem) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            XLENaviButtonItem *item2 = [XLENaviButtonItem naviItemWithTitle:@"左侧" block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击左侧2成功" toView:weakSelf.view completion:nil];
            }];
            item2.titleAttributes = [NSDictionary dictionaryWithObjects:@[[UIColor grayColor], XLE_FONT_BOLD(15)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];

            [self XLE_setNaviLeftWithNaviItems:@[item,item2]];
            
            XLENaviButtonItem *rightItem1 = [XLENaviButtonItem naviItemWithTitle:@"右侧1比较长" block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧1成功" toView:weakSelf.view completion:nil];
            }];
            
            XLENaviButtonItem *rightItem2 = [XLENaviButtonItem naviItemWithTitle:@"右侧" block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧2成功" toView:weakSelf.view completion:nil];
            }];
            rightItem1.titleAttributes = [NSDictionary dictionaryWithObjects:@[[UIColor grayColor], XLE_FONT_BOLD(15)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
            rightItem2.titleAttributes = [NSDictionary dictionaryWithObjects:@[[UIColor grayColor], XLE_FONT_BOLD(15)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];

            [self XLE_setNaviRightWithNaviItems:@[rightItem1,rightItem2]];
            break;
        }
        case XLE_NAVI_TEST_IMAGEURL_MORE: {
            XLENaviButtonItem *item1 = [XLENaviButtonItem naviItemWithImageUrl:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg@40w_30h_1o_2x_1e_1c.jpg"] block:^(XLENaviButtonItem *naviItem) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            
            XLENaviButtonItem *item2 = [XLENaviButtonItem naviItemWithImageUrl:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg@40w_30h_1o_2x_1e_1c.jpg"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击左侧2成功" toView:weakSelf.view completion:nil];
            }];
            
            [self XLE_setNaviLeftWithNaviItems:@[item1,item2]];
            
            XLENaviButtonItem *rightItem1 = [XLENaviButtonItem naviItemWithImageUrl:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg@40w_30h_1o_2x_1e_1c.jpg"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧1成功" toView:weakSelf.view completion:nil];
            }];
            
            XLENaviButtonItem *rightItem2 = [XLENaviButtonItem naviItemWithImageUrl:[NSURL URLWithString:@"http://image-demo.img-cn-hangzhou.aliyuncs.com/example.jpg@40w_30h_1o_2x_1e_1c.jpg"] block:^(XLENaviButtonItem *naviItem) {
                [[XLEViewManager sharedInstance].tipEngine showWithMessage:@"点击右侧2成功" toView:weakSelf.view completion:nil];
            }];
            
            [self XLE_setNaviRightWithNaviItems:@[rightItem1, rightItem2]];
            break;
        }
    }
}

@end
