//
//  XLEAssetCell.m
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import "XLEAssetCell.h"
#import <PureLayout/PureLayout.h>
#import "UIImage+xle.h"
#import "UIImage+XLEUitls.h"
#import "XLEApperance.h"

@interface XLEAssetCell ()
@property (strong, nonatomic) UIButton *selectedButton;
@end

@implementation XLEAssetCell

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (self.showSelect) {
        self.selectedButton.selected = selected;
    }
}

- (void)selectedAction
{
    self.selected = !self.selected;
    if (self.selected) {
        self.selectedButton.transform =CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.selectedButton.transform = CGAffineTransformMakeScale(1.05, 1.05);
        }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:0.1 animations:^{
                                 self.selectedButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
                             }];
                         }];
    }
    if (self.assetSelectUpdate) {
        self.assetSelectUpdate(self);
    }
}

#pragma mark - set get
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        [_imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
    return _imageView;
}

- (UIButton *)selectedButton{
    if (_selectedButton == nil) {
        _selectedButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage xle_imageNamed:@"xle_common_crop_checkbox_unchecked"] forState:UIControlStateNormal];
            [button setImage:[UIImage xle_imageNamed:@"xle_duigou"] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage xle_imageWithColor:[XLEApperance sharedInstance].tintColor size:CGSizeMake(24, 24)] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectedAction) forControlEvents:UIControlEventTouchUpInside];

            button;
        });
        _selectedButton.layer.cornerRadius = 12;
        _selectedButton.layer.masksToBounds = YES;
        [self.contentView addSubview:_selectedButton];
        [_selectedButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:2];
        [_selectedButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:2];
        [_selectedButton autoSetDimensionsToSize:CGSizeMake(24, 24)];
    }
    return _selectedButton;
}

@end
