//
//  XLEMJRefreshFactory.m
//  Pods
//
//  Created by Randy on 16/2/20.
//
//

#import "XLEMJRefreshFactory.h"
#import "XLEPullRefreshApperance.h"

@implementation XLEMJRefreshFactory

+ (MJRefreshFooter *)createFooterWithBlock:(MJRefreshComponentRefreshingBlock)block
{
    MJRefreshBackStateFooter *footer = nil;
    if (XLERefreshApperance.footerIdleIamges.count>0 || XLERefreshApperance.footerPullingIamges.count > 0 || XLERefreshApperance.footerRefreshingIamges.count>0) {
        MJRefreshBackGifFooter *gitFooter = [MJRefreshBackGifFooter footerWithRefreshingBlock:block];
        footer = gitFooter;
        [gitFooter setImages:XLERefreshApperance.footerIdleIamges duration:XLERefreshApperance.footerAnimatedDuration forState:MJRefreshStateIdle];
        [gitFooter setImages:XLERefreshApperance.footerPullingIamges duration:XLERefreshApperance.footerAnimatedDuration forState:MJRefreshStatePulling];
        [gitFooter setImages:XLERefreshApperance.footerRefreshingIamges duration:XLERefreshApperance.footerAnimatedDuration forState:MJRefreshStateRefreshing];
    }
    else
    {
        footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:block];
    }
    footer.mj_h = XLERefreshApperance.footerHeight;
    [footer setTitle:XLERefreshApperance.footerIdelTitle forState:MJRefreshStateIdle];
    [footer setTitle:XLERefreshApperance.footerPullingTitle forState:MJRefreshStatePulling];
    [footer setTitle:XLERefreshApperance.footerRefreshingTitle forState:MJRefreshStateRefreshing];
    [footer setTitle:XLERefreshApperance.footerNoMoreTitle forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = XLERefreshApperance.footerStateFont;
    footer.stateLabel.textColor = XLERefreshApperance.footerStateTextColor;
    footer.stateLabel.hidden = XLERefreshApperance.footerTitleHidden;
    return footer;
}

+ (MJRefreshHeader *)createHeaderWithBlock:(MJRefreshComponentRefreshingBlock)block
{
    MJRefreshStateHeader *header = nil;
    if (XLERefreshApperance.idleIamges.count > 0 || XLERefreshApperance.pullingIamges.count > 0 || XLERefreshApperance.refreshingIamges.count > 0) {
        MJRefreshGifHeader *gitHeader = [MJRefreshGifHeader headerWithRefreshingBlock:block];
        [gitHeader setImages:XLERefreshApperance.idleIamges duration:XLERefreshApperance.animatedDuration forState:MJRefreshStateIdle];
        [gitHeader setImages:XLERefreshApperance.pullingIamges duration:XLERefreshApperance.animatedDuration forState:MJRefreshStatePulling];
        [gitHeader setImages:XLERefreshApperance.refreshingIamges duration:XLERefreshApperance.animatedDuration forState:MJRefreshStateRefreshing];
        header = gitHeader;
    }
    else
        header = [MJRefreshStateHeader headerWithRefreshingBlock:block];
    header.mj_h = XLERefreshApperance.headerHeight;
    [header setTitle:XLERefreshApperance.idleStateTitle forState:MJRefreshStateIdle];
    [header setTitle:XLERefreshApperance.pullingStateTitle forState:MJRefreshStatePulling];
    [header setTitle:XLERefreshApperance.refreshingStateTitle forState:MJRefreshStateRefreshing];
    
    header.stateLabel.font = XLERefreshApperance.stateFont;
    header.stateLabel.textColor = XLERefreshApperance.stateTextColor;
    header.stateLabel.hidden = XLERefreshApperance.stateHidden;
    header.lastUpdatedTimeLabel.font = XLERefreshApperance.lastUpdatedTimeFont;
    header.lastUpdatedTimeLabel.textColor = XLERefreshApperance.lastUpdatedTimeTextColor;
    header.lastUpdatedTimeLabel.hidden = XLERefreshApperance.lastUpdatedTimeHidden;
    
    return header;
}

@end
