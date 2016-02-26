//
//  XLEBatchToolView.m
//  Pods
//
//  Created by Randy on 16/1/25.
//
//

#import "XLEBatchToolView.h"
#import "UIColor+XLEUtil.h"
#import <PureLayout/PureLayout.h>
#import "UIView+XLEBorders.h"

@interface XLEBatchToolView ()
@property (strong, nonatomic) UIButton *browserButton;
@property (strong, nonatomic) XLEBatchNumButton *finishButton;
@end

@implementation XLEBatchToolView

- (instancetype)init
{
    self = [super init];
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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self updateBatchNumber:0];
    }
    return self;
}

- (void)updateBatchNumber:(NSInteger)num;
{
    if (num>0) {
        self.browserButton.enabled = YES;
        self.finishButton.enabled = YES;
    }
    else
    {
        self.browserButton.enabled = NO;
        self.finishButton.enabled = NO;
    }
    
    
    if (num > 0) {
        self.finishButton.numValueLabel.transform =CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.finishButton.numValueLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 self.finishButton.numValueLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             }];
                         }];
        
    } else {

    }
    self.finishButton.numValueLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
}

- (void)setupUI
{
    self.backgroundColor = [UIColor xle_colorWithHexString:@"#fafafa"];
    [self xle_addTopBorderWithHeight:0.5 andColor:[UIColor xle_colorWithHexString:@"#dddddd"]];
    
    [self addSubview:self.browserButton];
    [self.browserButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTrailing];
    [self.browserButton autoSetDimension:ALDimensionWidth toSize:55];
    
    [self addSubview:self.finishButton];
    [self.finishButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeading];
    [self.finishButton autoSetDimension:ALDimensionWidth toSize:80];
}

#pragma mark - set get
- (UIButton *)browserButton{
    if (_browserButton == nil) {
        _browserButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"预览" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            [button setTitleColor:[UIColor xle_colorWithHexString:@"#3d3c3c"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor xle_colorWithHexString:@"#dddddd"] forState:UIControlStateDisabled];
            button;
        });
        _browserButton.frame = CGRectMake(0, 0, 65, self.frame.size.height);
    }
    return _browserButton;
}

- (XLEBatchNumButton *)finishButton{
    if (_finishButton == nil) {
        _finishButton = ({
            XLEBatchNumButton *button = [[XLEBatchNumButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, 0, 80, self.frame.size.height)];
            button.sendLabel.text = @"完成";
            button;
        });
    }
    return _finishButton;
}

@end
