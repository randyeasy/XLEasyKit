//
//  TXCTableViewCell.m
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import "XLETableViewCell.h"

static const CGFloat TXC_CELL_SUB_MAX_WIDTH = 100;

@interface XLETableViewCell ()
{
    UIView *_contentBGView;
}
@property (strong, nonatomic) XLEEnableImageView *iconImageView;
@property (strong, nonatomic) XLEEnableLabel *nameLabel;
@property (strong, nonatomic) XLEEnableLabel *subLabel;
@property (strong, nonatomic) JSBadgeView *badgeView;
@property (strong, nonatomic) UIView *middleView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation XLETableViewCell
@synthesize contentBGView = _contentBGView;
- (void)dealloc
{
    [_iconImageView removeObserver:self forKeyPath:@"image"];
    
    [_nameLabel removeObserver:self forKeyPath:@"text"];
    [_nameLabel removeObserver:self forKeyPath:@"font"];
    [_nameLabel removeObserver:self forKeyPath:@"lineBreakMode"];
    
    [_subLabel removeObserver:self forKeyPath:@"text"];
    [_subLabel removeObserver:self forKeyPath:@"font"];
    [_subLabel removeObserver:self forKeyPath:@"lineBreakMode"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentInsets = UIEdgeInsetsMake(0, XLE_LR_RADDING, 0, XLE_LR_RADDING);
        self.contentView.backgroundColor = [UIColor clearColor];
        _txcStyle = style;
        _verticalSpace = 6;
        self.showSeparator = NO;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setUnabled:(BOOL)unabled
{
    _unabled = unabled;
    self.nameLabel.unable = unabled;
    self.iconImageView.unable = unabled;
    self.subLabel.unable = unabled;
}

- (void)updateMiddleSubviews
{
    if (! _middleView) {
        return;
    }
    CGFloat contentMaxWidth = _middleView.frame.size.width;
    CGFloat contentMaxHeight = _middleView.frame.size.height;

    switch (self.txcStyle) {
        case UITableViewCellStyleDefault: {
            _nameLabel.frame = _middleView.bounds;
            break;
        }
        case UITableViewCellStyleValue1:
        case UITableViewCellStyleValue2:
        {
            CGFloat nameMaxWidth = [_nameLabel.text xle_maxSizeWithConstrainedSize:CGSizeMake(contentMaxWidth, CGFLOAT_MAX) font:_nameLabel.font lineMode:NSLineBreakByWordWrapping].width;
            CGFloat subMaxWidth = [_subLabel.text xle_maxSizeWithConstrainedSize:CGSizeMake(contentMaxWidth, CGFLOAT_MAX) font:_subLabel.font lineMode:NSLineBreakByWordWrapping].width;//TODO不能超过ContentMaxWidth
            CGFloat spaceWidth = 0;
            if (_nameLabel && _subLabel) {
                spaceWidth = 10;
            }
            if (subMaxWidth + nameMaxWidth + spaceWidth > contentMaxWidth) {
                if (subMaxWidth > TXC_CELL_SUB_MAX_WIDTH) {
                    subMaxWidth = TXC_CELL_SUB_MAX_WIDTH;
                }
                nameMaxWidth = contentMaxWidth - spaceWidth - subMaxWidth;
            }
            
            CGFloat leftX = 0;
            if (_nameLabel) {
                _nameLabel.frame = CGRectMake(leftX, 0, nameMaxWidth, contentMaxHeight);
                leftX += nameMaxWidth;
                leftX += 10;
            }
            
            if (_subLabel) {
                if (self.txcStyle == UITableViewCellStyleValue2) {
                    _subLabel.frame = CGRectMake(leftX, 0, subMaxWidth, contentMaxHeight);
                }
                else
                {
                    _subLabel.frame = CGRectMake(contentMaxWidth - subMaxWidth, 0, subMaxWidth, contentMaxHeight);
                }
            }
            break;
        }
        case UITableViewCellStyleSubtitle: {
            CGFloat maxHeight = CGFLOAT_MAX;
            if (_nameLabel.numberOfLines == 1) {
                maxHeight = _nameLabel.font.pointSize;
            }
            CGFloat nameMaxHeight = [_nameLabel.text xle_maxSizeWithConstrainedSize:CGSizeMake(contentMaxWidth, maxHeight) font:_nameLabel.font lineMode:NSLineBreakByWordWrapping].height;
            CGFloat nameMaxWidth = [_nameLabel.text xle_maxSizeWithConstrainedSize:CGSizeMake(contentMaxWidth, maxHeight) font:_nameLabel.font lineMode:NSLineBreakByWordWrapping].width;

            maxHeight = CGFLOAT_MAX;
            if (_subLabel.numberOfLines == 1) {
                maxHeight = _subLabel.font.pointSize;
            }
            CGFloat subMaxHeight = [_subLabel.text xle_maxSizeWithConstrainedSize:CGSizeMake(contentMaxWidth, maxHeight) font:_subLabel.font lineMode:NSLineBreakByWordWrapping].height;
            nameMaxHeight += (self.nameInset.top + self.nameInset.bottom);

            CGFloat contentMaxHeight = 0;
            if (_nameLabel) {
                contentMaxHeight += nameMaxHeight;
            }
            
            if (_subLabel) {
                contentMaxHeight += subMaxHeight;
            }
            
            if (_nameLabel && _subLabel) {
                contentMaxHeight += self.verticalSpace;
            }
            CGFloat topY = (_middleView.frame.size.height - contentMaxHeight) / 2.0f;
            if (topY < 0) {
                topY = 0;
            }
            
            nameMaxWidth += (self.nameInset.left+self.nameInset.right);
            if (_nameLabel) {
                _nameLabel.frame = CGRectMake(0, topY, nameMaxWidth>contentMaxWidth?contentMaxWidth:nameMaxWidth, nameMaxHeight);
                topY += nameMaxHeight;
                topY += self.verticalSpace;
            }
            if (_subLabel) {
                _subLabel.frame = CGRectMake(0, topY, contentMaxWidth, subMaxHeight);
            }
            break;
        }
        default: {
            break;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_contentBGView) {
        _contentBGView.frame = CGRectMake(self.contentBGInsets.left, self.contentBGInsets.top, self.contentView.frame.size.width - self.contentBGInsets.left - self.contentBGInsets.right, self.contentView.frame.size.height - self.contentBGInsets.top - self.contentBGInsets.bottom);
    }
    
    CGFloat leftX = self.contentInsets.left;
    if (_leftView) {
        CGSize leftSize = _leftView.frame.size;

        _leftView.frame = CGRectMake(leftX, (self.contentView.frame.size.height - leftSize.height) / 2.0f, leftSize.width, leftSize.height);
        leftX += leftSize.width;
        leftX += 10;
    }
    
    if (_iconImageView) {
        CGSize leftSize;
        leftSize = self.imageSize;
        if (CGSizeEqualToSize(leftSize, CGSizeZero)) {
            leftSize = _iconImageView.image.size;
        }
        
        _iconImageView.frame = CGRectMake(leftX, (self.contentView.frame.size.height - leftSize.height) / 2.0f, leftSize.width, leftSize.height);
        leftX += leftSize.width;
        leftX += 10;
    }
    
    CGFloat rightX = self.contentInsets.right;
    if (_rightView) {
        CGSize rightSize = _rightView.frame.size;
        _rightView.frame = CGRectMake(self.contentView.frame.size.width - rightSize.width - self.contentInsets.right, (self.contentView.frame.size.height - rightSize.height) / 2.0f, rightSize.width, rightSize.height);
        rightX += _rightView.frame.size.width;
        rightX += 10;
    }
    
    _middleView.frame = CGRectMake(leftX, 0, self.contentView.frame.size.width - leftX - rightX, self.contentView.frame.size.height);
    [self updateMiddleSubviews];
    
    CGRect frame = [self convertRect:_nameLabel.frame fromView:_nameLabel.superview];
    CGFloat x = CGRectGetMinX(frame);
    _lineView.frame = CGRectMake(x, self.bounds.size.height - XLEApperanceInstance.tableViewLineHeight, self.bounds.size.width - x, XLEApperanceInstance.tableViewLineHeight);
}

#pragma mark - observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - get set
- (XLEEnableImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[XLEEnableImageView alloc] init];
        [_iconImageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        [self.contentView addSubview:_iconImageView];
        [self setNeedsLayout];
    }
    return _iconImageView;
}

- (void)setImageSize:(CGSize)imageSize
{
    _imageSize = imageSize;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setNameInset:(UIEdgeInsets)nameInset{
    _nameInset = nameInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (XLEEnableLabel *)subLabel
{
    if (_subLabel == nil) {
        _subLabel = ({
            XLEEnableLabel *label = [[XLEEnableLabel alloc] initWithFrame:CGRectZero];
            label.font = XLE_MIDDLE_FONT;
            label.textColor = XLE_TEXT_HEAVY_COLOR;
            label.textAlignment = NSTextAlignmentLeft;
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            label;
        });
        [_subLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [_subLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        [_subLabel addObserver:self forKeyPath:@"lineBreakMode" options:NSKeyValueObservingOptionNew context:nil];
        [self.middleView addSubview:_subLabel];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    return _subLabel;
}

- (XLEEnableLabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = ({
            XLEEnableLabel *label = [[XLEEnableLabel alloc] initWithFrame:CGRectZero];
            label.font = XLE_LARGE_FONT;
            label.textColor = XLE_TEXT_DARK_COLOR;
            label.textAlignment = NSTextAlignmentLeft;
            label.backgroundColor = [UIColor clearColor];
            label;
        });
        [_nameLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [_nameLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        [_nameLabel addObserver:self forKeyPath:@"lineBreakMode" options:NSKeyValueObservingOptionNew context:nil];
        [self.middleView addSubview:_nameLabel];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }

    return _nameLabel;
}

- (void)setRightView:(UIView *)rightView
{
    if (_rightView) {
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    [self.contentView addSubview:rightView];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setLeftView:(UIView *)leftView{
    if (leftView == _leftView) {
        return;
    }
    
    if (_leftView != nil) {
        [_leftView removeFromSuperview];
    }
    _leftView = leftView;
    if (_badgeView && _badgeView.superview == nil) {
        [_leftView addSubview:_badgeView];
    }
    [self.contentView addSubview:leftView];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (UIView *)middleView
{
    if (_middleView == nil) {
        _middleView = [UIView new];
        [self.contentView addSubview:_middleView];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    return _middleView;
}

- (JSBadgeView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[JSBadgeView alloc] initWithParentView:self.iconImageView alignment:JSBadgeViewAlignmentTopRight];
        _badgeView.badgePositionAdjustment = CGPointMake(-5, 5);
        _badgeView.badgeText = nil;
        [self.iconImageView addSubview:_badgeView];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    return _badgeView;
}

- (UIView *)contentBGView{
    if (_contentBGView == nil) {
        _contentBGView = [UIView new];
        _contentBGView.backgroundColor = XLE_BG_COLOR;
        [self.contentView insertSubview:_contentBGView atIndex:0];
    }
    return _contentBGView;
}

- (void)setContentBGView:(UIView *)contentBGView
{
    if (contentBGView == _contentBGView) {
        return;
    }
    
    if (_contentBGView) {
        [_contentBGView removeFromSuperview];
    }
    
    _contentBGView = contentBGView;
    [self addSubview:_contentBGView];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = XLE_LINE_LIGHT_COLOR;
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (void)setShowSeparator:(BOOL)showSeparator {
    if (_showSeparator != showSeparator) {
        _showSeparator = showSeparator;
        if (showSeparator) {
            [self lineView];
        }
        _lineView.hidden = !showSeparator;
        [self setNeedsLayout];
    }
}

@end
