//
//  BJPEnableLabel.h
//  Pods
//
//  Created by Randy on 15/11/16.
//
//

#import <UIKit/UIKit.h>
#import "XLELabel.h"
@interface XLEEnableLabel : XLELabel
@property (assign, nonatomic) BOOL unable;
@property (strong, nonatomic) UIColor *unableColor;

@end
