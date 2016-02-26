//
//  UIView+Basic.h
//  MotherBaby
//
//  Created by Mac_ZL on 14-08-26.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(XLEBasic)

@property (nonatomic) CGFloat xle_current_x;

@property (nonatomic) CGFloat xle_current_y;


@property (nonatomic) CGFloat xle_current_w;


@property (nonatomic) CGFloat xle_current_h;


@property (nonatomic) CGFloat xle_current_y_h;


@property (nonatomic) CGFloat xle_current_x_w;


@property (nonatomic, readonly) CGPoint xle_current_innerCenter;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat xle_screenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat xle_screenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat xle_screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat xle_screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect xle_screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint xle_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize xle_size;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat xle_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat xle_centerY;



@property (nonatomic) CGPoint xle_orientationCenter;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat xle_orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat xle_orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)xle_descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)xle_ancestorOrSelfWithClass:(Class)cls;

/**
 *  view subviews iscontain view of kind of cls
 */
- (BOOL)xle_subViewsContaionWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)xle_removeAllSubviews;

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)xle_viewController;


//截图
+(UIImage *)xle_captureView:(UIView *)theView;

@end
