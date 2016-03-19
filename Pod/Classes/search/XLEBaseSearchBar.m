//
//  XLEBaseSearchBar.m
//  Pods
//
//  Created by Randy on 16/1/13.
//
//

#import "XLEBaseSearchBar.h"

@implementation XLEBaseSearchBar

- (void)commitUI
{
    self.placeholder = @"搜索";
    
    self.showsCancelButton = YES;
    self.backgroundImage = [UIImage XLE_imageWithColor:XLE_TINT_COLOR size:self.frame.size];
    [self setBarTintColor:[UIColor whiteColor]];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commitUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitUI];
    }
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commitUI];
    }
    return self;
}

@end
