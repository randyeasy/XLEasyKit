//
//  XLEConfig.m
//  Pods
//
//  Created by Randy on 16/2/29.
//
//

#import "XLEKitConfig.h"

@implementation XLEKitConfig

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageSize = 20;
        _pageMinIndex = 1;
    }
    return self;
}

@end
