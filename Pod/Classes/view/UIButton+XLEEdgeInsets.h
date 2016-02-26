//
//  UIButton+XLEEdgeInsets.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

//TODO 测试

#import <UIKit/UIKit.h>
#import "XLEViewType.h"

@interface UIButton (XLEEdgeInsets)

- (void)xle_setImagePoint:(CGPoint)point;
- (void)xle_setTitlePoint:(CGPoint)point;

- (void)xle_setImageEdgeWithOffset:(CGFloat)offset
                         direction:(XLEViewDirectionType)direction;
- (void)xle_setTitleEdgeWithOffset:(CGFloat)offset
                         direction:(XLEViewDirectionType)direction;
- (void)xle_setContentEdgeWithOffset:(CGFloat)offset
                         direction:(XLEViewDirectionType)direction;

@end
