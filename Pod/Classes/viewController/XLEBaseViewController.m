//
//  XLEBaseViewController.h
//
//  Created by Randy on 16/1/20.
//  Copyright © 2016年 Randy. All rights reserved.
//

#import "XLEBaseViewController.h"

@interface XLEBaseViewController ()
{
    BOOL _isAppearFirst;
    BOOL _isWillAppearFirst;
}

@end

@implementation XLEBaseViewController


- (void)dealloc
{
    NSLog(@"内存释放 dealloc:%@", self);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    if ([self respondsToSelector:@selector(hidesNavigationBarWhenPushed)]) {
        BOOL hide = !![self hidesNavigationBarWhenPushed];
        if (self.navigationController.navigationBarHidden != hide) {
            [self.navigationController setNavigationBarHidden:hide animated:animated];
        }
    }
    
    if (!_isWillAppearFirst) {
        _isWillAppearFirst = YES;
        [self viewWillAppearFisrtHandle];
    }
    else
        [self viewWillAppearUnFisrtHandle];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_isAppearFirst) {
        _isAppearFirst = YES;
        [self viewDidAppearFisrtHandle];
    }
    else
    {
        [self viewDidAppearUnFisrtHandle];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:XLE_BG_COLOR];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
    if(self.navigationController && self != [self.navigationController.viewControllers firstObject])
    {
        // Put Back button in navigation bar
        [self XLE_setNaviBackArrow];
    } else {
    }
    NSLog(@"内存释放 viewDidLoad:%@", self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hidesNavigationBarWhenPushed
{
    return NO;
}

- (BOOL)hidesBottomBarWhenPushed
{
    if(self.navigationController && self != [self.navigationController.viewControllers firstObject])
    {
        return YES;
    }
    else
        return NO;
}

- (void)viewDidAppearFisrtHandle
{
    NSLog(@"%@ viewDidFistAppealed",NSStringFromClass([self class]));
}

- (void)viewWillAppearFisrtHandle
{
    NSLog(@"%@ viewWillFistAppealed",NSStringFromClass([self class]));
}

- (void)viewDidAppearUnFisrtHandle  //非第一次显示调用的函数
{
    NSLog(@"%@ viewDidAppearUnFisrtHandle",NSStringFromClass([self class]));
}

- (void)viewWillAppearUnFisrtHandle  //非第一次显示调用的函数
{
    NSLog(@"%@ viewWillAppearUnFisrtHandle",NSStringFromClass([self class]));
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return XLEApperanceInstance.statusStyle;

}

#pragma mark - set get
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self XLE_setNaviTitle:title];
}

@end


