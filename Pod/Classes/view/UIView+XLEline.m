//
//  UIView+line.m
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 14-9-18.
//  Copyright (c) 2014年 Baijiahulian. All rights reserved.
//

#import "UIView+XLEline.h"

#define UICOLOR_FROM_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation UIView (XLEline)

+ (UIView *)xle_lineWithColor:(UIColor *)color frame:(CGRect)frame
{
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    [lineView setBackgroundColor:color];
    return lineView;
}

+ (UIView *)xle_lineWithColor:(UIColor *)color size:(CGSize)size
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [lineView setBackgroundColor:color];
    return lineView;
}

+ (UIView *)xle_graylineWithFrame:(CGRect)frame
{
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    [lineView setBackgroundColor:UICOLOR_FROM_RGB(229,229,229,1)];
    return lineView;
}

+ (UIView *)xle_graylineWithSize:(CGSize)size
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [lineView setBackgroundColor:UICOLOR_FROM_RGB(229,229,229,1)];
    return lineView;
}

+ (UIView *)xle_graylineWithWidth:(CGFloat)width
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 0.5)];
    [lineView setBackgroundColor:UICOLOR_FROM_RGB(229,229,229,1)];
    return lineView;
}

@end
