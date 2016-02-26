//
//  XLEAlbumTableViewCell.m
//  Pods
//
//  Created by Randy on 16/2/3.
//
//

#import "XLEAlbumTableViewCell.h"
#import "UIColor+XLEUtil.h"
#import <PureLayout/PureLayout.h>

@interface XLEAlbumTableViewCell ()
@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@end

@implementation XLEAlbumTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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

#pragma mark - set get
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            label.font = [UIFont systemFontOfSize:18];
            label.textAlignment = NSTextAlignmentLeft;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor xle_colorWithHexString:@"#3c3c3c"];
            label;
        });
        [self.contentView addSubview:_nameLabel];
        [_nameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.photoImageView withOffset:8];
        [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    }
    return _nameLabel;
}

- (UIImageView *)photoImageView{
    if (_photoImageView == nil) {
        _photoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_photoImageView];
        [_photoImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTrailing];
        [_photoImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:_photoImageView];
    }
    return _photoImageView;
}

@end
