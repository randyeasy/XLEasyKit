//
//  XLECSearchHistoryTableViewCell.h
//  Pods
//
//  Created by binluo on 15/12/16.
//
//

#import <UIKit/UIKit.h>
#import "XLETableViewCell.h"

@interface XLESearchHistoryTableViewCell : XLETableViewCell

@property (nonatomic, copy) void (^clickBubbleBlock)(NSString *title) ;

- (void)updateWithTitle:(NSString *)title;

@end
