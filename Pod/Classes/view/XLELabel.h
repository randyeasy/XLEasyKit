//
//  XLELabel.h
//  Pods
//
//  Created by binluo on 15/12/12.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XLELabelVerticalAlignment) {
    XLELabelVerticalAlignmentCenter = 0, // default
    XLELabelVerticalAlignmentTop,
    XLELabelVerticalAlignmentBottom
};

@interface XLELabel : UILabel

@property(nonatomic, readwrite) UIEdgeInsets insets;
@property(nonatomic, readwrite) XLELabelVerticalAlignment verticalAlignment;

@end
