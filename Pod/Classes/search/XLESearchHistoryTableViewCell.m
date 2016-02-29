//
//  XLECSearchHistoryTableViewCell.m
//  Pods
//
//  Created by binluo on 15/12/16.
//
//

#import "XLESearchHistoryTableViewCell.h"
#import "XLEView.h"

@interface XLESearchHistoryTableViewCell()

@property (nonatomic, strong) UIButton *titleBtn;

@end

@implementation XLESearchHistoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        {
            self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.titleBtn.frame = CGRectMake(5, 5, 100, 25);
            [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.titleBtn.titleLabel.font = XLE_MIDDLE_FONT;
            [self.titleBtn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
            self.titleBtn.backgroundColor = XLE_TINT_COLOR;
            self.titleBtn.layer.cornerRadius = (self.titleBtn.frame.size.height/2);
            [self.contentView addSubview:self.titleBtn];
        }
        [self xle_addBottomBorderWithHeight:XLEApperanceInstance.lineHeight color:XLE_LINE_LIGHT_COLOR leftOffset:CGRectGetMinX(self.nameLabel.frame) + XLE_LR_RADDING rightOffset:0 andBottomOffset:0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.titleBtn) {
        CGRect rect = [self.titleBtn.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, NSUIntegerMax) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleBtn.titleLabel.font} context:nil];
        
        CGFloat width = MAX(rect.size.width + 20, 30);
        self.titleBtn.frame = CGRectMake(5, 5, width, 25);
    }
}

- (void)updateWithTitle:(NSString *)title {
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
}

- (void)clickBtnAction {
    if (self.clickBubbleBlock) {
        self.clickBubbleBlock([self.titleBtn titleForState:UIControlStateNormal]);
    }
}

@end
