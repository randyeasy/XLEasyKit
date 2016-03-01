//
//  XLEListConfigModel.m
//  Pods
//
//  Created by Randy on 15/12/7.
//
//

#import "XLETableConfigModel.h"
#import "XLETableViewCell.h"
#import "XLEBlankView.h"
#import "XLEErrorView.h"

@implementation XLETableConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hasPull = YES;
        _blankClass = [XLEBlankView class];
        _errorClass = [XLEErrorView class];
    }
    return self;
}

@end
