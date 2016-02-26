//
//  XLEAssetMananger.h
//  Pods
//
//  Created by Randy on 16/2/16.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface XLEAssetMananger : NSObject
@property (strong, readonly, nonatomic) ALAssetsLibrary *assetsLibrary;
+ (instancetype)sharedInstance;
@end
