//
//  XLELoading.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLELoading.h"
#import <YLGIFImage/YLGIFImage.h>
#import <YLGIFImage/YLImageView.h>
#import "XLELoadingCustomView.h"

@interface XLELoading ()

@property (nonatomic, strong) MBProgressHUD *loading;
@property (nonatomic, strong) XLELoadingCustomView *customView;

@end

@implementation XLELoading

- (void)showWithMessage:(NSString *)message;
{
    [self showWithMessage:message toView:[UIApplication sharedApplication].keyWindow];
}

- (void)showWithMessage:(NSString *)message toView:(UIView *)view;
{
    [self showWithMessage:message toView:view animated:NO];
}

- (void)showWithMessage:(NSString *)message animated:(BOOL)animated;
{
    [self showWithMessage:message toView:[UIApplication sharedApplication].keyWindow animated:animated];
}

- (void)showWithMessage:(NSString *)message toView:(UIView *)view animated:(BOOL)animated;
{
    if (self.loading) {
        [self.loading removeFromSuperview];
        self.loading = nil;
    }
    if (!animated) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        hud.removeFromSuperViewOnHide = YES;
        hud.mode =  MBProgressHUDModeIndeterminate;
        hud.opacity = 0.8;
        hud.labelText = message;
        [view addSubview:hud];
        hud.labelColor = XLEApperanceInstance.loadingColor;
        hud.labelFont = XLEApperanceInstance.loadingFont;
        self.loading = hud;
        [hud show:YES];
    }
    else
    {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        hud.removeFromSuperViewOnHide = YES;
        hud.mode =  MBProgressHUDModeCustomView;
        hud.opacity = 0;
        hud.customView = self.customView;
        hud.labelText = message;
        hud.labelColor = XLEApperanceInstance.loadingColor;
        hud.labelFont = XLEApperanceInstance.loadingFont;
        [view addSubview:hud];
        self.loading = hud;
        [hud show:YES];
    }
}

- (void)hide;
{
    [self.loading hide:YES];
}

#pragma mark - set get
- (XLELoadingCustomView *)customView{
    if (_customView == nil) {
        _customView = [[XLELoadingCustomView alloc] init];
        [_customView setLoadingImagePath:XLEApperanceInstance.loadingImagePath];
    }
    return _customView;
}

@end
