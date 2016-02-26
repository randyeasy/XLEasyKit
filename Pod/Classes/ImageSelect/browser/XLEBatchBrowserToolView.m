//
//  XLEBatchBrowserToolView.m
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import "XLEBatchBrowserToolView.h"
#import "XLEBatchNumButton.h"
#import "UIColor+XLEUtil.h"
#import <PureLayout/PureLayout.h>

NSString *const XLE_BATCH_BROWSER_ACTION_FULL_IMAGE = @"fullImage";
NSString *const XLE_BATCH_BROWSER_ACTION_USED       = @"used";

@interface XLEBatchBrowserToolView ()
@property (strong, nonatomic) XLEFullImageButton *fullButton;
@property (strong, nonatomic) XLEBatchNumButton *numButton;

@property (strong, nonatomic) UIView *backgroundView;

@end

@implementation XLEBatchBrowserToolView

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
    [self addSubview:self.backgroundView];
    [self addSubview:self.numButton];
    [self addSubview:self.fullButton];

    [self.backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.numButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeading];
    [self.numButton autoSetDimension:ALDimensionWidth toSize:50];
    [self.fullButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTrailing];
    [self.fullButton autoSetDimension:ALDimensionWidth toSize:self.fullButton.frame.size.width];
    
    self.fullButton.hidden = !self.hasFullImage;
}

- (void)updateBatchNumber:(NSInteger)num;
{
    if (num>0) {
        self.numButton.enabled = YES;
    }
    else
    {
        self.numButton.enabled = NO;
    }
    
    
    if (num > 0) {
        self.numButton.numValueLabel.transform =CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.numButton.numValueLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 self.numButton.numValueLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             }];
                         }];
        
    } else {
        
    }
    self.numButton.numValueLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
}

#pragma mark - set get
- (void)setHasFullImage:(BOOL)hasFullImage{
    _hasFullImage = hasFullImage;
    self.fullButton.hidden = !self.hasFullImage;
}

- (XLEFullImageButton *)fullButton{
    if (_fullButton == nil) {
        _fullButton = ({
            CGRect frame = CGRectZero;
            frame.size.height = self.frame.size.height;
            frame.size.width = CGRectGetWidth([[UIScreen mainScreen] bounds])/2 -20;
            XLEFullImageButton *button = [[XLEFullImageButton alloc] initWithFrame:frame];
            button;
        });
    }
    return _fullButton;
}

- (XLEBatchNumButton *)numButton{
    if (_numButton == nil) {
        _numButton = [[XLEBatchNumButton alloc] init];
        _numButton.sendLabel.text = @"发送";
        _numButton.numValueLabel.text = @"0";
    }
    return _numButton;
}

- (UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor xle_colorWithHexString:@"#2C272B" alpha:0.9];
    }
    return _backgroundView;
}

@end
