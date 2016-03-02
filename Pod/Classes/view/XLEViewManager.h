//
//  XLEViewManager.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>
#import "XLETipProtocol.h"
#import "XLELoadingProtocol.h"
#import "XLEAlertProtocol.h"

@interface XLEViewManager : NSObject
@property (strong, nonatomic) id<XLETipProtocol> tipEngine;
@property (strong, nonatomic) id<XLELoadingProtocol> loadingEngine;
@property (strong, nonatomic) id<XLEAlertProtocol> alertEngine;
+ (instancetype)sharedInstance;

@end
