//
//  UIColor+Util.h
//  BJEducation_student
//
//  Created by Mrlu-bjhl on 15/6/2.
//  Copyright (c) 2015年 Baijiahulian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XLECOLOR_FROM_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface UIColor (Util)

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)xle_colorWithHexString:(NSString *)color;
+ (UIColor *)xle_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
