//
//  XLEErrorView.m
//  Pods
//
//  Created by heyingj on 12/9/15.
//
//

#import "XLEErrorView.h"

@interface XLEErrorView ()
@end

@implementation XLEErrorView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.label.text = @"请求失败";
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label.text = @"请求失败";
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.label.text = @"请求失败";
    }
    return self;
}

@end
