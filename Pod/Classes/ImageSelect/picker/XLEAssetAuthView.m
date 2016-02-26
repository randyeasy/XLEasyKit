//
//  XLEAssetAuthView.m
//  Pods
//
//  Created by Randy on 16/2/3.
//
//

#import "XLEAssetAuthView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIAlertView+XLEBlock.h"
#import <PureLayout/PureLayout.h>

@interface XLEAssetAuthView ()
@property (strong, nonatomic) UILabel *tipLable;
@property (strong, nonatomic) UIButton *openButton;
@end

@implementation XLEAssetAuthView

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tipLable];
    [self.tipLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(40+64, 5, 0, 5) excludingEdge:ALEdgeBottom];
    [self.tipLable autoSetDimension:ALDimensionHeight toSize:40];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self addSubview:self.openButton];
        [self.openButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tipLable withOffset:25];
        [self.openButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.openButton autoSetDimensionsToSize:CGSizeMake(100, 34)];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
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

#pragma mark - action
- (void)openSettingsAction
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:appSettings]) {
            [[UIApplication sharedApplication] openURL:appSettings];
        }
    }
}

#pragma mark - set get
- (UILabel *)tipLable{
    if (_tipLable == nil) {
        _tipLable = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.numberOfLines = 2;
            label;
        });
        _tipLable.text = @"请在iPhone的“设置-隐私-照片”选项中，\n允许应用访问你的手机相册";
    }
    return _tipLable;
}

- (UIButton *)openButton
{
    if (_openButton == nil) {
        _openButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"点击设置" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(openSettingsAction) forControlEvents:UIControlEventTouchUpInside];
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.borderWidth = 0.5;
            button.layer.cornerRadius = 3;
            button;
        });
    }
    return _openButton;
}

@end
