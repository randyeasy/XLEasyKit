//
//  XLEConfig.h
//  Pods
//
//  Created by Randy on 16/2/29.
//
//

#import <Foundation/Foundation.h>

#define XLE_PAGE_SIZE [XLEKitConfig sharedInstance].pageSize
#define XLE_PAGE_MIN_INDEX [XLEKitConfig sharedInstance].pageMinIndex

@interface XLEKitConfig : NSObject

//list
@property (assign, nonatomic) NSInteger pageSize;//默认20
@property (assign, nonatomic) NSInteger pageMinIndex;//默认从1开始

+ (instancetype)sharedInstance;

@end
