//
//  XLECameraHeaderView.m
//  Pods
//
//  Created by Randy on 16/2/2.
//
//

#import "XLECameraHeaderView.h"
#import "UIImage+xle.h"
#import <PureLayout/PureLayout.h>
#import "UIColor+XLEUtil.h"

@interface XLECameraHeaderView ()
@property (strong, nonatomic) UIButton *flashButton;
@property (strong, nonatomic) UIButton *frontButton;

@property (strong, nonatomic) UIButton *autoFlashButton;
@property (strong, nonatomic) UIButton *openFlashButton;
@property (strong, nonatomic) UIButton *closeFlashButton;

@property (strong, nonatomic) UIView *backgroundView;

@property (assign, nonatomic) BOOL isShowFlash;
@property (assign, nonatomic) XLECameraFlash flash;

@end

@implementation XLECameraHeaderView

- (void)setupUI
{

    [self addSubview:self.backgroundView];
    [self.backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self addSubview:self.openFlashButton];
    [self addSubview:self.autoFlashButton];
    [self addSubview:self.closeFlashButton];
    [self.autoFlashButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.autoFlashButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.openFlashButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.openFlashButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.closeFlashButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.closeFlashButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    [self.autoFlashButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.flashButton withOffset:5];
    [self.autoFlashButton autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.openFlashButton];
    [self.openFlashButton autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.closeFlashButton];
    [self.closeFlashButton autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.frontButton withOffset:5];
    
    [self.autoFlashButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.closeFlashButton];
    [self.openFlashButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.closeFlashButton];

    
    [self updateFlashButtons];
    [self hiddenFlashView];
    [self.flashButton addTarget:self action:@selector(showFlashAction) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)initWithFlash:(XLECameraFlash)flash
{
    self = [super init];
    if (self) {
        _flash = flash;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame flash:(XLECameraFlash)flash
{
    self = [super initWithFrame:frame];
    if (self) {
        _flash = flash;
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)updateFlashButtons
{
    self.autoFlashButton.selected = NO;
    self.closeFlashButton.selected = NO;
    self.openFlashButton.selected = NO;
    NSString *imageName = @"xle_camera_flash_auto";
    switch (self.flash) {
        case XLECameraFlashOff: {
            imageName = @"xle_camera_flash_close";
            self.closeFlashButton.selected = YES;
            break;
        }
        case XLECameraFlashOn: {
            imageName = @"xle_camera_flash_open";
            self.openFlashButton.selected = YES;
            break;
        }
        case XLECameraFlashAuto: {
            self.autoFlashButton.selected = YES;
            break;
        }
    }
    //TODO 图片
    [self.flashButton setImage:[UIImage xle_imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)showFlashView
{
    self.autoFlashButton.hidden = NO;
    self.closeFlashButton.hidden = NO;
    self.openFlashButton.hidden = NO;
    self.frontButton.hidden = YES;
    self.isShowFlash = YES;
}

- (void)hiddenFlashView
{
    self.autoFlashButton.hidden = YES;
    self.closeFlashButton.hidden = YES;
    self.openFlashButton.hidden = YES;
    self.frontButton.hidden = NO;
    self.isShowFlash = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - action
- (void)showFlashAction
{
    self.isShowFlash = !self.isShowFlash;
    
    if (self.isShowFlash) {
        [self showFlashView];
    }
    else
    {
        [self hiddenFlashView];
    }
    
}

- (void)flashAction:(UIButton *)button
{
    if (button == self.autoFlashButton) {
        self.flash = XLECameraFlashAuto;
    }
    else if (button == self.openFlashButton)
    {
        self.flash = XLECameraFlashOn;
    }
    else
        self.flash = XLECameraFlashOff;
    
    [self updateFlashButtons];
    [self hiddenFlashView];
    if (self.flashCallback) {
        self.flashCallback(self.flash);
    }
}

#pragma mark - set get

- (UIButton *)autoFlashButton
{
    if (_autoFlashButton == nil) {
        _autoFlashButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"自动" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor xle_colorWithHexString:@"#F7C028"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(flashAction:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button;
        });
    }
    return _autoFlashButton;
}

- (UIButton *)openFlashButton
{
    if (_openFlashButton == nil) {
        _openFlashButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"打开" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor xle_colorWithHexString:@"#F7C028"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(flashAction:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button;
        });
    }
    return _openFlashButton;
}

- (UIButton *)closeFlashButton
{
    if (_closeFlashButton == nil) {
        _closeFlashButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"关闭" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor xle_colorWithHexString:@"#F7C028"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(flashAction:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button;
        });
    }
    return _closeFlashButton;
}

- (UIButton *)flashButton{
    if (_flashButton == nil) {
        _flashButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage xle_imageNamed:@"xle_camera_flash"] forState:UIControlStateNormal];
            button;
        });
        [self addSubview:_flashButton];
        [_flashButton autoSetDimension:ALDimensionWidth toSize:44];
        [_flashButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTrailing];
    }
    return _flashButton;
}

- (UIButton *)frontButton{
    if (_frontButton == nil) {
        _frontButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage xle_imageNamed:@"xle_camera_front"] forState:UIControlStateNormal];
            button;
        });
        [self addSubview:_frontButton];
        [_frontButton autoSetDimension:ALDimensionWidth toSize:44];
        [_frontButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeading];
    }
    return _frontButton;
}

- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor xle_colorWithHexString:@"#2C272B" alpha:0.9];
    }
    return _backgroundView;
}

@end
