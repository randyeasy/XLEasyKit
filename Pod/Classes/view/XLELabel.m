//
//  XLELabel.m
//  Pods
//
//  Created by binluo on 15/12/12.
//
//

#import "XLELabel.h"

@implementation XLELabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.verticalAlignment = XLELabelVerticalAlignmentCenter;
    }
    return self;
}

- (void)dealloc {
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:self.numberOfLines];
    switch (self.verticalAlignment) {
        case XLELabelVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case XLELabelVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        default:
            break;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
