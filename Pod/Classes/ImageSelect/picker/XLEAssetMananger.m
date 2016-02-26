//
//  XLEAssetMananger.m
//  Pods
//
//  Created by Randy on 16/2/16.
//
//

#import "XLEAssetMananger.h"

@interface XLEAssetMananger ()
@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;

@end

@implementation XLEAssetMananger

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (ALAssetsLibrary *)assetsLibrary{
    if (_assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

@end
