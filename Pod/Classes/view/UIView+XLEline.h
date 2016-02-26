//
//  UIView+line.h
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-9-18.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XLEline)

+ (UIView *)xle_lineWithColor:(UIColor *)color frame:(CGRect)frame;

+ (UIView *)xle_lineWithColor:(UIColor *)color size:(CGSize)size;

+ (UIView *)xle_graylineWithFrame:(CGRect)frame;

+ (UIView *)xle_graylineWithSize:(CGSize)size;

+ (UIView *)xle_graylineWithWidth:(CGFloat)width;


@end
