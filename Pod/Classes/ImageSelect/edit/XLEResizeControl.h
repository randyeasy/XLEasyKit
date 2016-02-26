//
//  PEResizeControl.h
//  PhotoCropEditor
//
//  Created by kishikawa katsumi on 2013/05/19.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol XLEResizeControlViewDelegate;

@interface XLEResizeControl : UIView

@property (nonatomic, weak) id<XLEResizeControlViewDelegate> delegate;
@property (nonatomic, readonly) CGPoint translation;

@end

@protocol XLEResizeControlViewDelegate <NSObject>

- (void)resizeControlViewDidBeginResizing:(XLEResizeControl *)resizeControlView;
- (void)resizeControlViewDidResize:(XLEResizeControl *)resizeControlView;
- (void)resizeControlViewDidEndResizing:(XLEResizeControl *)resizeControlView;

@end
