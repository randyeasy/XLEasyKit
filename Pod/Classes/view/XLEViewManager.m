//
//  XLEViewManager.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLEViewManager.h"
#import "XLEDialog.h"
#import "XLETip.h"
#import "XLELoading.h"

@implementation XLEViewManager

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
        _dialogEngine = [[XLEDialog alloc] init];
        _tipEngine = [[XLETip alloc] init];
        _loadingEngine = [[XLELoading alloc] init];
    }
    return self;
}

@end
