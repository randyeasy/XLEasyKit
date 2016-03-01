//
//  UIView+Basic.m
//  Picnote
//
//  Created by Mac_ZL on 14-8-26.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import "UIView+XLEBasic.h"

@implementation UIView(Basic)

- (CGFloat)xle_current_x
{
    return self.frame.origin.x;
}

- (void)setXle_current_x:(CGFloat)current_x {
    CGRect frame = self.frame;
    frame.origin.x = current_x;
    self.frame = frame;
}


- (CGFloat)xle_current_y
{
    return self.frame.origin.y;
}

- (void)setXle_current_y:(CGFloat)current_y {
    CGRect frame = self.frame;
    frame.origin.y = current_y;
    self.frame = frame;
}

- (CGFloat)xle_current_w
{
    return self.frame.size.width;
}

- (void)setXle_current_w:(CGFloat)current_w {
    CGRect frame = self.frame;
    frame.size.width = current_w;
    self.frame = frame;
}

- (CGFloat)xle_current_h
{
    return self.frame.size.height;
}

- (void)setXle_current_h:(CGFloat)current_h {
    CGRect frame = self.frame;
    frame.size.height = current_h;
    self.frame = frame;

}

- (CGFloat)xle_current_y_h
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setXle_current_y_h:(CGFloat)current_y_h {
    CGRect frame = self.frame;
    frame.origin.y = current_y_h - frame.size.height;
    self.frame = frame;

}

- (CGFloat)xle_current_x_w
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setXle_current_x_w:(CGFloat)current_x_w {
    CGRect frame = self.frame;
    frame.origin.x = current_x_w - frame.size.width;
    self.frame = frame;
}

- (CGPoint)xle_current_innerCenter
{
    return CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += [view xle_current_x];
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += [view xle_current_y];
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += [view xle_current_x];
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += [view xle_current_y];
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)xle_screenFrame {
    return CGRectMake([self xle_screenViewX], [self xle_screenViewY], [self xle_current_w], [self xle_current_h]);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)xle_origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setXle_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)xle_size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setXle_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setXle_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setXle_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGPoint)xle_orientationCenter {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? CGPointMake(self.center.y, self.center.x) : self.center;
}

- (void)setXle_orientationCenter:(CGPoint)orientationCenter {
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        self.center = CGPointMake(orientationCenter.y, orientationCenter.x);
    } else {
        self.center = orientationCenter;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.xle_current_h : self.xle_current_w;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xle_orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.xle_current_w : self.xle_current_h;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)xle_descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child xle_descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)xle_ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview xle_ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}

- (BOOL)xle_subViewsContaionWithClass:(Class)cls
{
    BOOL contain = NO;
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:cls]) {
            contain = YES;
            break;
        }
    }
    return contain;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)xle_removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)xle_offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += [view xle_current_x];
        y += [view xle_current_y];
    }
    return CGPointMake(x, y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)xle_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark -
+(UIImage*)xle_captureView:(UIView *)theView
{
    CGRect rect = theView.bounds;
    //支持retina高分的关键
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
