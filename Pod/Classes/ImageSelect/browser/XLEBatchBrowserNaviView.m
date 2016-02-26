//
//  XLEBatchBrowserNaviView.m
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import "XLEBatchBrowserNaviView.h"
#import "UIImage+xle.h"
#import "UIImage+XLEUitls.h"
#import "XLEApperance.h"
#import "UIColor+XLEUtil.h"
#import <PureLayout/PureLayout.h>

@interface XLEBatchBrowserNaviView ()
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIButton *backBautton;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation XLEBatchBrowserNaviView

- (void)dealloc
{
    [_selectButton removeObserver:self forKeyPath:@"selected" context:nil];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selected"]) {
        if (self.selectButton.selected) {
            self.selectButton.transform =CGAffineTransformMakeScale(0, 0);
            [UIView animateWithDuration:0.2 animations:^{
                self.selectButton.transform = CGAffineTransformMakeScale(1.05, 1.05);
            }
                             completion:^(BOOL finished){
                                 [UIView animateWithDuration:0.1 animations:^{
                                     self.selectButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                 }];
                             }];
        }
    }
}

- (void)setupUI
{    
    [self addSubview:self.backgroundView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.backBautton];
    [self addSubview:self.selectButton];
    [self.selectButton addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.backBautton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 0, 0, 0) excludingEdge:ALEdgeTrailing];
    [self.backBautton autoSetDimension:ALDimensionWidth toSize:44];
    
    [self.selectButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.selectButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:10];
    [self.selectButton autoSetDimensionsToSize:CGSizeMake(24, 24)];
    
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.backBautton withOffset:5];
    [self.titleLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.selectButton withOffset:5];
}

#pragma mark - set get

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, self.frame.size.height)];
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label;
        });
    }
    return _titleLabel;
}

- (UIButton *)backBautton{
    if (_backBautton == nil) {
        _backBautton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setImage:[UIImage xle_imageNamed:@"xle_back"] forState:UIControlStateNormal];
            button;
        });;
        
    }
    return _backBautton;
}

- (UIButton *)selectButton{
    if (_selectButton == nil) {
        _selectButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage xle_imageNamed:@"xle_common_crop_checkbox_unchecked"] forState:UIControlStateNormal];
            [button setImage:[UIImage xle_imageNamed:@"xle_duigou"] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage xle_imageWithColor:[XLEApperance sharedInstance].tintColor size:CGSizeMake(24, 24)] forState:UIControlStateSelected];
            button;
        });
        _selectButton.layer.cornerRadius = 12;
        _selectButton.layer.masksToBounds = YES;
    }
    return _selectButton;
}

- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor xle_colorWithHexString:@"#2C272B" alpha:0.9];
    }
    return _backgroundView;
}

@end
