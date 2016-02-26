//
//  XLEBatchToolView.h
//  Pods
//
//  Created by Randy on 16/1/25.
//
//

#import <UIKit/UIKit.h>

#import "XLEBatchNumButton.h"

@interface XLEBatchToolView : UIView
@property (strong, readonly, nonatomic) UIButton *browserButton;
@property (strong, readonly, nonatomic) XLEBatchNumButton *finishButton;

- (void)updateBatchNumber:(NSInteger)num;
@end
