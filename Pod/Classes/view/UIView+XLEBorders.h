//
//  UIView+Borders.h
//  BJEducation
//
//  Created by archer on 9/14/14.
//  Copyright (c) 2014 Randy All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (XLEBorders)

/* Create your borders and assign them to a property on a view when you can via the create methods when possible. Otherwise you might end up with multiple borders being created.
 */

///------------
/// Top Border  给view增加top边框，边框粗细和颜色可设定
///------------
-(void)xle_addTopBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;


///------------
/// Top Border + Offsets
///------------
-(void)xle_addTopBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andTopOffset:(CGFloat)topOffset;

///------------
/// Right Border 给view增加right边框，边框粗细和颜色可设定
///------------
-(void)xle_addRightBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;

///------------
/// Right Border + Offsets
///------------
-(void)xle_addRightBorderWithWidth: (CGFloat)width color:(UIColor*)color rightOffset:(CGFloat)rightOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

///------------
/// Bottom Border 给view增加bottom边框，边框粗细和颜色可设定
///------------
-(void)xle_addBottomBorderWithHeight:(CGFloat)height andColor:(UIColor*)color;

///------------
/// Bottom Border + Offsets
///------------
-(void)xle_addBottomBorderWithHeight: (CGFloat)height color:(UIColor*)color leftOffset:(CGFloat)leftOffset rightOffset:(CGFloat)rightOffset andBottomOffset:(CGFloat)bottomOffset;

///------------
/// Left Border 给view增加left边框，边框粗细和颜色可设定
///------------

-(void)xle_addLeftBorderWithWidth: (CGFloat)width andColor:(UIColor*)color;

///------------
/// verMiddle Border 给view垂直方向中线加线，线框粗细和颜色可设定
///------------
-(void)xle_addVerMiddleLineWithWidth: (CGFloat)width andColor:(UIColor*)color;

///------------
/// Left Border + Offsets
///------------

-(void)xle_addLeftBorderWithWidth: (CGFloat)width color:(UIColor*)color leftOffset:(CGFloat)leftOffset topOffset:(CGFloat)topOffset andBottomOffset:(CGFloat)bottomOffset;

@end
