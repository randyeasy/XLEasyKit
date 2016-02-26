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

@interface XLELoading ()

@property (nonatomic, strong) MBProgressHUD *loading;
@property (nonatomic, strong) UIView *customView;

@end

@implementation XLELoading

+ (XLELoading *)shareLoading
{
    static XLELoading *shareLoadingInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareLoadingInstance = [[self alloc] init];
    });
    return shareLoadingInstance;
}

+ (void)show:(NSString *)message
{
    [self show:message toView:[UIApplication sharedApplication].keyWindow];
}

+ (void)show:(NSString *)message toView:(UIView *)view
{
    NSAssert1(view, @"%s: View is nil", __FUNCTION__);
    
    if ([self shareLoading].loading) {
        [[self shareLoading].loading hide:NO];
        [self shareLoading].loading = nil;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode =  MBProgressHUDModeIndeterminate;
    hud.opacity = 0.8;
    hud.labelText = message;
    [view addSubview:hud];
    [self shareLoading].loading = hud;
    [[self shareLoading].loading show:YES];
}

+ (void)showAnimation
{
    [self showAnimation:@"拼命加载中..."];
}

+ (void)showAnimation:(NSString *)messgae
{
    [self showAnimation:messgae toView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showAnimation:(NSString *)message toView:(UIView *)view
{
    if (![self shareLoading].customView) {
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
        if (XLEApperanceInstance.loadingImagePath) {
            YLImageView *animateImg = [YLImageView newAutoLayoutView];
            YLGIFImage *gifImg = (YLGIFImage *)[YLGIFImage imageWithContentsOfFile:XLEApperanceInstance.loadingImagePath];
            animateImg.image = gifImg;
            [customView addSubview:animateImg];
            [animateImg autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
            [animateImg autoAlignAxisToSuperviewAxis:ALAxisVertical];
            [animateImg autoSetDimensionsToSize:CGSizeMake(100, 100)];
        }

        [self shareLoading].customView = customView;
    }
    
    if ([self shareLoading].loading) {
        [[self shareLoading].loading hide:NO];
        [self shareLoading].loading = nil;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode =  MBProgressHUDModeCustomView;
    hud.opacity = 0;
    hud.customView = [self shareLoading].customView;
    hud.labelText = message;
    hud.labelColor = XLEApperanceInstance.loadingColor;
    hud.labelFont = XLEApperanceInstance.loadingFont;
    [view addSubview:hud];
    [self shareLoading].loading = hud;
    [[self shareLoading].loading show:YES];
}

+ (void)hide
{
    [self hide:YES];
}

+ (void)hide:(BOOL)animated
{
    if ([self shareLoading].loading) {
        [[self shareLoading].loading hide:animated];
    }
}

@end
