//
//  XLEListConfigModel.m
//  Pods
//
//  Created by Randy on 15/12/7.
//
//

#import "XLETableConfigModel.h"

@implementation XLETableConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hasPull = YES;
        _nodataTip = @"暂无数据";
        _cellClass = [XLETableViewCell class];
    }
    return self;
}

@end
