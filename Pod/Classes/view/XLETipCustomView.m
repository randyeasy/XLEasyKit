//
//  XLETipCustomView.m
//  Pods
//
//  Created by Randy on 16/3/2.
//
//

#import "XLETipCustomView.h"
#import "UIView+XLEBasic.h"

@interface XLETipCustomView ()
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation XLETipCustomView

- (void)dealloc
{
    [_messageLabel removeObserver:self forKeyPath:@"text"];
    [_imageView removeObserver:self forKeyPath:@"image"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGFloat maxWidth = self.maxWidth;
    
    CGFloat tbPadding = 0;
    CGFloat leftY = tbPadding;
    [_imageView sizeToFit];
    if (_imageView.image) {
        leftY += (_imageView.image.size.height + 5);
    }
    
    CGSize messageSize = [_messageLabel sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    _messageLabel.frame = CGRectMake(0, leftY, messageSize.width, messageSize.height);
    
    CGFloat actualWidth = MAX(_imageView.xle_current_w, _messageLabel.xle_current_w);
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(_messageLabel.frame) + tbPadding;
    frame.size.width = actualWidth;
    self.frame = frame;
    
    frame = _messageLabel.frame;
    frame.origin.x = 0;
    frame.size.width = actualWidth;
    _messageLabel.frame = frame;
    
    frame = _imageView.frame;
    frame.origin.x = (actualWidth - _imageView.xle_current_w) / 2.0f;
    _imageView.frame = frame;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    }

    return _imageView;
}

- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = XLEApperanceInstance.tipFont;
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.adjustsFontSizeToFitWidth = NO;
            label.textColor = XLEApperanceInstance.tipColor;
            label;
        });
        [_messageLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

@end
