//
//  XLEAliyunShowVC.h
//  XLEasyKit
//
//  Created by Randy on 16/3/3.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import <XLEasyKit/XLEasyKit.h>


typedef NS_ENUM(NSInteger, XLEAliyunType) {
    XLE_ALIYUN_ORIGINAL,
    XLE_ALIYUN_SCALE_CUT,
    XLE_ALIYUN_SCALE,
};


@interface XLEAliyunShowVC : XLEBaseViewController
@property (assign, nonatomic) XLEAliyunType type;

@end
