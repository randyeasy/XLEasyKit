//
//  XLETip.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLETip.h"
#import "XLETipCustomView.h"
#define XLE_TIP_TAG           718191

@implementation XLETip

- (void)showWithMessage:(NSString *)message;
{
    [self showWithMessage:message completion:nil];
}

- (void)showWithMessage:(NSString *)message
             completion:(XLETipCompletionBlock)completion;
{
    [self showWithMessage:message
                   toView:[UIApplication sharedApplication].keyWindow
               completion:completion];
}

- (void)showWithMessage:(NSString *)message
                 toView:(UIView *)view
             completion:(XLETipCompletionBlock)completion;
{
    [self showWithMessage:message
                    image:nil
                   toView:view
               completion:completion];
}

- (void)showWithSuccessMessage:(NSString *)message
                    completion:(XLETipCompletionBlock)completion;
{
    [self showWithSuccessMessage:message
                          toView:[UIApplication sharedApplication].keyWindow
                      completion:completion];
}

- (void)showWithSuccessMessage:(NSString *)message
                        toView:(UIView *)view
                    completion:(XLETipCompletionBlock)completion;
{
    [self showWithMessage:message
                    image:XLEApperanceInstance.tipSucImage
                   toView:view
               completion:completion];
}

- (void)showWithErrorMessage:(NSString *)message
                  completion:(XLETipCompletionBlock)completion;
{
    [self showWithErrorMessage:message
                        toView:[UIApplication sharedApplication].keyWindow
                    completion:completion];
}

- (void)showWithErrorMessage:(NSString *)message
                      toView:(UIView *)view
                  completion:(XLETipCompletionBlock)completion;
{
    [self showWithMessage:message
                    image:XLEApperanceInstance.tipErrorImage
                   toView:view
               completion:completion];
}

- (void)showInStatusBarWithMessage:(NSString *)message
                        completion:(XLETipCompletionBlock)completion;
{
    //TODO
}

- (void)showWithMessage:(NSString *)message
                  image:(UIImage *)image
                 toView:(UIView *)view
             completion:(XLETipCompletionBlock)completion
{
    MBProgressHUD *lastHud = (MBProgressHUD *)[view viewWithTag:XLE_TIP_TAG];
    if (lastHud) {
        [lastHud hide:NO];
        [lastHud removeFromSuperview];
        lastHud = nil;
    }
    
    __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    
    XLETipCustomView *customView = (XLETipCustomView *)hud.customView;
    if (![customView isKindOfClass:[XLETipCustomView class]]) {
        customView = [[XLETipCustomView alloc] init];
    }
    else
        hud.customView = nil;
    hud.margin = 15;
    customView.maxWidth = [UIScreen mainScreen].bounds.size.width - hud.margin*4;
    customView.messageLabel.text = message;
    customView.imageView.image = image;
    hud.customView = customView;
    hud.color = XLEApperanceInstance.tipBGColor;
    hud.tag = XLE_TIP_TAG;
    hud.minShowTime = XLEApperanceInstance.tipMinTime;
    
    [hud showAnimated:YES whileExecutingBlock:^{

    } completionBlock:^{
        [hud removeFromSuperview];
        hud = nil;
        if (completion) {
            completion();
        }
    }];
}

@end
