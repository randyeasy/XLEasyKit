//
//  XLEBrowserCell.m
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import "XLEBrowserCell.h"
#import <PureLayout/PureLayout.h>

@interface XLEBrowserCell ()
@property (strong, nonatomic) XLEBrowserView *browserView;
@end

@implementation XLEBrowserCell

- (XLEBrowserView *)browserView{
    if (_browserView == nil) {
        _browserView = [[XLEBrowserView alloc] initWithFrame:self.bounds];
        _browserView.clipsToBounds = NO;
        [self.contentView addSubview:_browserView];
        [_browserView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
    return _browserView;
}

@end
