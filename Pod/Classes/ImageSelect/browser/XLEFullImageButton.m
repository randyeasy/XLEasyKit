//
//  DNFullImageButton.m
//  ImagePicker
//
//  Created by DingXiao on 15/3/2.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "XLEFullImageButton.h"
#import <PureLayout/PureLayout.h>
#import "UIImage+xle.h"

@interface XLEFullImageButton ()
@property (nonatomic, strong) UILabel *fullTitleLabel;
@property (nonatomic, strong) UIImageView *fullImageView;
@property (nonatomic, strong) UILabel *imageSizeLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation XLEFullImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.fullImageView];
        [self addSubview:self.fullTitleLabel];
        [self addSubview:self.imageSizeLabel];
        [self addSubview:self.indicatorView];
        
        [self.fullImageView autoSetDimensionsToSize:self.fullImageView.frame.size];
        [self.fullImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [self.fullImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.fullTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.fullTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [self.fullTitleLabel autoSetDimension:ALDimensionWidth toSize:self.fullTitleLabel.frame.size.width];
        [self.fullTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.fullImageView withOffset:3];
        
        [self.imageSizeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeading];
        [self.imageSizeLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.fullTitleLabel withOffset:3];
        [self.indicatorView autoSetDimensionsToSize:CGSizeMake(26, 26)];
        [self.indicatorView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.indicatorView autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.fullTitleLabel withOffset:3];
        
        self.selected = NO;
    }
    return self;
}

- (UILabel *)imageSizeLabel
{
    if (nil == _imageSizeLabel) {
        _imageSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 4, CGRectGetWidth(self.frame)- 100, 20)];
        _imageSizeLabel.backgroundColor = [UIColor clearColor];
        _imageSizeLabel.font = [UIFont systemFontOfSize:14.0f];
        _imageSizeLabel.textAlignment = NSTextAlignmentLeft;
        _imageSizeLabel.textColor = [UIColor whiteColor];
    }
    return _imageSizeLabel;
}

- (UIImageView *)fullImageView
{
    if (_fullImageView == nil) {
        _fullImageView = [[UIImageView alloc] initWithImage:[UIImage xle_imageNamed:@"xle_full_image_unselected"] highlightedImage:[UIImage xle_imageNamed:@"xle_full_image_selected"]];
        [_fullImageView sizeToFit];
    }
    return _fullImageView;
}

- (UILabel *)fullTitleLabel{
    if (_fullTitleLabel == nil) {
        _fullTitleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label;
        });
        _fullTitleLabel.text = @"原图";
        [_fullTitleLabel sizeToFit];
    }
    return _fullTitleLabel;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (nil == _indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(60, 2, 26, 26)];
        _indicatorView.hidesWhenStopped = YES;
        [_indicatorView stopAnimating];
    }
    return _indicatorView;
}

- (void)setSelected:(BOOL)selected
{
    if (self.selected != selected) {
        [super setSelected:selected];
        self.fullImageView.highlighted = self.selected;
        if (self.selected) {
            self.fullTitleLabel.textColor = [UIColor whiteColor];
        }
        else
            self.fullTitleLabel.textColor = [UIColor lightGrayColor];
        self.imageSizeLabel.hidden = !self.selected;
    }
}

- (void)setText:(NSString *)text
{
    self.imageSizeLabel.text = text;
}

- (void)shouldAnimating:(BOOL)animate
{
    if (self.selected) {
        self.imageSizeLabel.hidden = animate;
        if (animate) {
            [self.indicatorView startAnimating];
        } else {
            [self.indicatorView stopAnimating];
        }
    }
}
@end
