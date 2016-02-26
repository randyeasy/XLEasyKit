//
//  XLEImageManager.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLEImageManager.h"
#import "XLEAliyunImageEngine.h"

@implementation XLEImageManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id<XLEImageLoadEngine>)loadEngine{
    if (_loadEngine == nil) {
        _loadEngine = [[XLEAliyunImageEngine alloc] init];
    }
    return _loadEngine;
}

@end
