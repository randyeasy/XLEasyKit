//
//  XLEPullRefreshApperance.m
//  Pods
//
//  Created by Randy on 16/2/20.
//
//

#import "XLEPullRefreshApperance.h"
#import "XLEApperance.h"

@implementation XLEPullRefreshApperance

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _idleStateTitle = @"下拉可以刷新";
        _pullingStateTitle = @"松开立即刷新";
        _refreshingStateTitle = @"正在刷新...";
        
        _stateFont = XLE_MIDDLE_FONT;
        _stateTextColor = XLE_TEXT_HEAVY_COLOR;
        _lastUpdatedTimeFont = XLE_MIDDLE_FONT;
        _lastUpdatedTimeTextColor = XLE_TEXT_HEAVY_COLOR;
        
        _footerIdelTitle = @"上拉可以加载更多";
        _footerPullingTitle = @"松开立即加载更多";
        _footerRefreshingTitle = @"正在加载更多的数据...";
        _footerNoMoreTitle = @"数据已全部加载";
        _footerStateFont = XLE_MIDDLE_FONT;
        _footerStateTextColor = XLE_TEXT_HEAVY_COLOR;
        
        _animatedDuration = 0.4;
        _footerAnimatedDuration = 0.4;
        _headerHeight = 54.0f;
        _footerHeight = 44.0f;
    }
    return self;
}

@end
