//
//  UIButton+XLEEdgeInsets.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "UIButton+XLEEdgeInsets.h"

@implementation UIButton (XLEEdgeInsets)

- (void)xle_setImagePoint:(CGPoint)point;
{
    [self sizeToFit];
    self.imageEdgeInsets = UIEdgeInsetsZero;
    CGRect frame = self.imageView.frame;
    UIEdgeInsets edge = UIEdgeInsetsZero;
    if (!CGPointEqualToPoint(point, frame.origin)) {
        edge.left = point.x - frame.origin.x;
        edge.right = -edge.left;
        edge.top = point.y - frame.origin.y;
        edge.bottom = -edge.top;
        self.imageEdgeInsets = edge;
    }
}

- (void)xle_setTitlePoint:(CGPoint)point;
{
    [self sizeToFit];
    self.titleEdgeInsets = UIEdgeInsetsZero;
    CGRect frame = self.titleLabel.frame;
    UIEdgeInsets edge = UIEdgeInsetsZero;
    if (!CGPointEqualToPoint(point, frame.origin)) {
        edge.left = point.x - frame.origin.x;
        edge.right = -edge.left;
        edge.top = point.y - frame.origin.y;
        edge.bottom = -edge.top;
        self.titleEdgeInsets = edge;
    }
}

- (void)xle_setImageEdgeWithOffset:(CGFloat)offset
                         direction:(XLEViewDirectionType)direction;
{
    self.imageEdgeInsets = [self edgeInsetsWithOffset:offset directin:direction];
}

- (void)xle_setTitleEdgeWithOffset:(CGFloat)offset
                         direction:(XLEViewDirectionType)direction;
{
    self.titleEdgeInsets = [self edgeInsetsWithOffset:offset directin:direction];
}

- (void)xle_setContentEdgeWithOffset:(CGFloat)offset
                           direction:(XLEViewDirectionType)direction;
{
    self.contentEdgeInsets = [self edgeInsetsWithOffset:offset directin:direction];
}

#pragma mark - internal
- (UIEdgeInsets)edgeInsetsWithOffset:(CGFloat)offset directin:(XLEViewDirectionType)direction;
{
    UIEdgeInsets edge;
    switch (direction) {
        case XLE_VIEW_DIRECTION_TOP: {
            edge = UIEdgeInsetsMake(-offset, 0, offset, 0);
            break;
        }
        case XLE_VIEW_DIRECTION_BOTTOM: {
            edge = UIEdgeInsetsMake(offset, 0, -offset, 0);
            break;
        }
        case XLE_VIEW_DIRECTION_LEFT: {
            edge = UIEdgeInsetsMake(0, -offset, 0, offset);
            break;
        }
        case XLE_VIEW_DIRECTION_RIGHT: {
            edge = UIEdgeInsetsMake(0, offset, 0, -offset);
            break;
        }
    }
    return edge;
}

@end
