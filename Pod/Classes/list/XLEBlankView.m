//
//  XLEBlankView.m
//  Pods
//
//  Created by Randy on 16/02/29.
//

#import "XLEBlankView.h"

@interface XLEBlankView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *button;
@end

@implementation XLEBlankView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self label];
        _label.text = @"无数据";
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self label];
        _label.text = @"无数据";
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self label];
        _label.text = @"无数据";
    }
    return self;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView =[[UIImageView alloc] initWithImage:nil];
        [self addSubview: _imageView];
        [_imageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
        [_imageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:-50];
    }
    return _imageView;
}

- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 30, 60)];
        [_label setTextColor:XLE_TEXT_DARK_COLOR];
        _label.font = XLE_MIDDLE_FONT;
        _label.text = @"无数据";
        _label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 30;
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_label];
        [_label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:8];
        [_label autoAlignAxis:ALAxisVertical toSameAxisOfView:self.imageView];
    }
    return _label;
}

- (UIButton *)button{
    if (_button == nil) {
        _button = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"添加" forState:UIControlStateNormal];
            [button setTitleColor:XLE_TEXT_DARK_COLOR forState:UIControlStateNormal];
            button;
        });
    }
    return _button;
}

@end
