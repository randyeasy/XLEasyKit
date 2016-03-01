//
//  XLEListTestManager.m
//  XLEasyKit
//
//  Created by Randy on 16/3/1.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import "XLEListTestManager.h"

@implementation XLEListTestManager

+ (NSArray<XLEDemoItem *> *)testItems
{
    NSMutableArray *mutList = [NSMutableArray new];
    for (int i=0; i<XLE_PAGE_SIZE; i++) {
        [mutList xle_addObjectNonNil:[XLEDemoItem itemWithName:[NSString stringWithFormat:@"测试数据 下标为：%d",i] desc:nil callback:^{
            
        }]];
    }
    return [mutList copy];
}

@end
