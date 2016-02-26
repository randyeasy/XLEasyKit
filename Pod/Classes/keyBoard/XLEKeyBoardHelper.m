//
//  BJKeyBoardHelper.m
//  Pods
//
//  Created by Randy on 15/6/23.
//  Copyright (c) 2015年 Randy All rights reserved.
//

#import "XLEKeyBoardHelper.h"

@interface XLEKeyBoardHelper ()
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation XLEKeyBoardHelper

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        _scrollView = scrollView;
    }
    return self;
}

- (void)addKeyBoardObserver
{
    [self removeKeyBoardObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyBoardObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView*)findFirstResponderBeneathView:(UIView*)view {
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) return result;
    }
    return nil;
}

#pragma mark - 处理键盘事件
- (void)keyboardShow:(NSNotification *)noti
{
    NSDictionary* info = [noti userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets insets = self.scrollView.contentInset;
    
    CGRect keyRect = [[UIApplication sharedApplication].delegate window].bounds;
    CGRect scrollRect = [self.scrollView convertRect:self.scrollView.frame toView:[[UIApplication sharedApplication].delegate window]];
    CGFloat height = keyRect.size.height - scrollRect.size.height - scrollRect.origin.y - self.scrollView.contentOffset.y;
    if (height<=0) {
        height = 0;
    }
    insets.bottom = kbSize.height - height;
    
    self.scrollView.contentInset = insets;
    self.scrollView.scrollIndicatorInsets = insets;
    
    UIView *firstView = [self findFirstResponderBeneathView:self.scrollView];
    if (firstView) {
        UIView *superView = firstView;
        while (superView.superview != self.scrollView) {
            superView = superView.superview;
        }
        if (firstView != superView) {
            CGRect rec = [firstView.superview convertRect:firstView.frame toView:self.scrollView];
            CGPoint point = CGPointMake(0, CGRectGetMaxY(rec) - (self.scrollView.frame.size.height - insets.top - insets.bottom));
            if (point.y <= 0) {
                point.y = 0;
            }
            [self.scrollView setContentOffset:point animated:YES];
        }
        else
        {
            CGRect rec = firstView.frame;
            CGPoint point = CGPointMake(0, CGRectGetMaxY(rec) - (self.scrollView.frame.size.height - insets.top - insets.bottom));
            if (point.y <= 0) {
                point.y = 0;
            }
            [self.scrollView setContentOffset:point animated:YES];
        }
    }
}

- (void)keyboardHidden:(NSNotification *)noti
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
