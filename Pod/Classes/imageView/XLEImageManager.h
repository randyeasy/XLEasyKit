//
//  XLEImageManager.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>
#import "XLEImageLoadEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLEImageManager : NSObject
@property (strong, nonatomic) id<XLEImageLoadEngine> loadEngine;//默认是 aliyun
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
