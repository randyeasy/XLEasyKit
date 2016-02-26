//
//  DNFullImageButton.h
//  ImagePicker
//
//  Created by DingXiao on 15/3/2.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLEFullImageButton : UIControl

@property (nonatomic, copy) NSString *text;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)shouldAnimating:(BOOL)animate;
@end
