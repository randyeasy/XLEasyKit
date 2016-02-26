//
//  XLECameraToolView.m
//  Pods
//
//  Created by Randy on 16/2/2.
//
//

#import "XLECameraToolView.h"
#import "UIImage+xle.h"
#import <PureLayout/PureLayout.h>
#import "UIColor+XLEUtil.h"

@interface XLECameraToolView ()
@property (strong, nonatomic) UIButton *takeButton;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIView *backgroundView;
@end

@implementation XLECameraToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor xle_colorWithHexString:@"#2C272B" alpha:0.9];
        [self addSubview:_backgroundView];
        [_backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIButton *)takeButton{
    if (_takeButton == nil) {
        _takeButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage xle_imageNamed:@"xle_camera_take"] forState:UIControlStateNormal];
            [button setImage:[UIImage xle_imageNamed:@"xle_camera_take_press"] forState:UIControlStateHighlighted];
            button;
        });
        [self addSubview:_takeButton];
        [_takeButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_takeButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_takeButton autoSetDimensionsToSize:CGSizeMake(55, 55)];
    }
    return _takeButton;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button;
        });
        [self addSubview:_cancelButton];
        [_cancelButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_cancelButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
        [_cancelButton autoSetDimensionsToSize:CGSizeMake(55, 55)];
    }
    return _cancelButton;
}

@end
