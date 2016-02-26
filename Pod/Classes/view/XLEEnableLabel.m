//
//  BJPEnableLabel.m
//  Pods
//
//  Created by Randy on 15/11/16.
//
//

#import "XLEEnableLabel.h"

@interface XLEEnableLabel ()
@property (strong, nonatomic) UIColor *originalColor;
@end

@implementation XLEEnableLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setUnable:(BOOL)unable
{
    if (self.originalColor == nil) {
        self.originalColor = self.textColor;
    }
    
    if (unable) {
        self.textColor = self.unableColor?:[UIColor grayColor];
    }
    else
    {
        self.textColor = self.originalColor;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    [super setTextColor:textColor];
    self.originalColor = textColor;
}

@end
