//
//  XLEImageEditToolView.m
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import "XLEImageEditToolView.h"
#import <PureLayout/PureLayout.h>
#import "UIColor+XLEUtil.h"
#import "UIView+XLEBorders.h"

NSString *const XLE_IMAGE_EDIT_ACTION_USED     = @"used";
NSString *const XLE_IMAGE_EDIT_ACTION_RESELECT = @"reselect";
NSString *const XLE_IMAGE_EDIT_ACTION_ROTATE   = @"rotate";

@interface XLEImageEditToolView ()
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *usedButton;
@property (strong, nonatomic) UIButton *rotateButton;
@end

@implementation XLEImageEditToolView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
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

- (void)setupUI
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.usedButton];
//    [self addSubview:self.rotateButton];
    [self.backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.cancelButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 5, 0, 0) excludingEdge:ALEdgeTrailing];
    [self.cancelButton autoSetDimension:ALDimensionWidth toSize:50];
    
    [self.usedButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 5) excludingEdge:ALEdgeLeading];
    [self.usedButton autoSetDimension:ALDimensionWidth toSize:50];
    
//    [self.rotateButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [self.rotateButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//    [self.rotateButton autoSetDimension:ALDimensionWidth toSize:50];
//    [self.rotateButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
}

- (void)cancelAction
{
    if (self.editAction) {
        self.editAction(self, XLE_IMAGE_EDIT_ACTION_RESELECT);
    }
}

- (void)usedAction
{
    if (self.editAction) {
        self.editAction(self, XLE_IMAGE_EDIT_ACTION_USED);
    }
}

- (void)rotateAction
{
    if (self.editAction) {
        self.editAction(self, XLE_IMAGE_EDIT_ACTION_ROTATE);
    }
}

#pragma mark - set get 
- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cancelButton;
}

- (UIButton *)usedButton{
    if (_usedButton == nil) {
        _usedButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"使用" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(usedAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _usedButton;
}

- (UIButton *)rotateButton{
    if (_rotateButton == nil) {
        _rotateButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"旋转" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(rotateAction) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _rotateButton;
}

- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor xle_colorWithHexString:@"#2C272B" alpha:0.9];
    }
    return _backgroundView;
}

@end
