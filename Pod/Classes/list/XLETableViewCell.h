//
//  TXCTableViewCell.h
//  Pods
//
//  Created by Randy on 15/12/5.
//
//

#import <UIKit/UIKit.h>
#import "XLEEnableImageView.h"
#import "XLEEnableLabel.h"
#import <JSBadgeView/JSBadgeView.h>

/**
 *  列表Cell
 *  使用方法：定制Cell继承它，并重写XLETableViewCellDataDelegate的实现
 */
@interface XLETableViewCell : UITableViewCell
@property (strong, readonly, nonatomic) XLEEnableImageView *iconImageView;
@property (strong, readonly, nonatomic) XLEEnableLabel *nameLabel;
@property (strong, readonly, nonatomic) XLEEnableLabel *subLabel;
@property (strong, readonly, nonatomic) JSBadgeView *badgeView;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UIView *leftView;
@property (assign, nonatomic) CGSize imageSize;
@property (assign, nonatomic) UIEdgeInsets nameInset; //只支持UITableViewCellStyleSubtitle样式
@property (assign, nonatomic) UIEdgeInsets contentInsets;
@property (assign, nonatomic) CGFloat verticalSpace;
@property (assign, nonatomic) UIEdgeInsets contentBGInsets;
@property (strong, nonatomic) UIView *contentBGView;
@property (assign, nonatomic) UITableViewCellStyle txcStyle;
@property (assign, nonatomic) BOOL showSeparator;  //Default NO.

@property (assign, nonatomic) BOOL unabled;
@end
