//
//  XLEBrowserView.h
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

/**
 *  部分代码取自开源库 DNImagePicker
 *
 */

#import <UIKit/UIKit.h>

@interface XLEBrowserView : UIView
@property (copy, nonatomic) void(^singleTap)(XLEBrowserView *view);
@property (strong, readonly, nonatomic) UIScrollView *srollView;

- (void)updateBrowserImage:(UIImage *)image;

@end
