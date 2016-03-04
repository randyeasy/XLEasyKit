//
//	XLEPageModel.h
//
//	Create by Randy on 5/12/2015

#import "XLEPageModel.h"
#import "XLEKitConfig.h"

@implementation XLEPageModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hasMore = YES;
        _pageSize = XLE_PAGE_SIZE;
        _pageNum = XLE_PAGE_MIN_INDEX;
    }
    return self;
}

@end