//
//  XLENaviItemTestVC.h
//  XLEasyKit
//
//  Created by Randy on 16/3/3.
//  Copyright © 2016年 闫晓亮. All rights reserved.
//

#import <XLEasyKit/XLEasyKit.h>

typedef NS_ENUM(NSInteger, XLENaviItemTestType) {
    XLE_NAVI_TEST_IMAGE,
    XLE_NAVI_TEST_TITLE,
    XLE_NAVI_TEST_IMAGEURL,
    XLE_NAVI_TEST_IMAGE_MORE,
    XLE_NAVI_TEST_TITLE_MORE,
    XLE_NAVI_TEST_IMAGEURL_MORE,
};

@interface XLENaviItemTestVC : XLEBaseViewController
@property (assign, nonatomic) XLENaviItemTestType type;
@end
