//
//  BJKeyBoardHelper.h
//  Pods
//
//  Created by Randy on 15/6/23.
//  Copyright (c) 2015年 Randy All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLEKeyBoardHelper : NSObject
- (void)addKeyBoardObserver;
- (void)removeKeyBoardObserver;
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
@end
