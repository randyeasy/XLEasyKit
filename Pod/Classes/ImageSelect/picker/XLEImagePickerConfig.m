//
//  XLEImageSelectConfig.m
//  Pods
//
//  Created by Randy on 16/1/25.
//
//

#import "XLEImagePickerConfig.h"

@implementation XLEImagePickerConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxNumberOfSelection = 2;
        _minNumberOfSelection = 1;
        _batchFinishTitle = @"完成";
    }
    return self;
}

@end
