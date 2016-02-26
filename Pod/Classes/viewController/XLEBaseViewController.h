//
//  XLEBaseViewController.h
//
//  Created by Randy on 16/1/20.
//  Copyright © 2016年 Randy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+XLENaviItem.h"

@interface XLEBaseViewController : UIViewController
//把当前视图从导航队列中移除 在push结束的时候
@property (assign, nonatomic) BOOL shouldDestroy;

/**
 *  是否需要隐藏导航栏，视图控制器包含在XLENavigationController对象中才会起作用 默认显示
 *
 *  @return YES：隐藏
 */
- (BOOL)hidesNavigationBarWhenPushed;
/**
 *  是否需要隐藏下导航 默认如果是UINavigatonController的rootViewController则显示，其他不显示
 *
 *  @return YES：隐藏
 */
- (BOOL)hidesBottomBarWhenPushed;

- (void)viewDidAppearFisrtHandle NS_REQUIRES_SUPER;  //第一次显示调用的函数
- (void)viewWillAppearFisrtHandle NS_REQUIRES_SUPER;  //第一次显示调用的函数
- (void)viewDidAppearUnFisrtHandle NS_REQUIRES_SUPER;  //非第一次显示调用的函数
- (void)viewWillAppearUnFisrtHandle NS_REQUIRES_SUPER;  //非第一次显示调用的函数
@end

