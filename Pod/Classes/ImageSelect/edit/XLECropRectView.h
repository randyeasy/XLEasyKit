//
//  XLECropRectView.h
//  PhotoCropEditor
//
//  Created by kishikawa katsumi on 2013/05/21.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLECropRectViewDelegate;

@interface XLECropRectView : UIView

@property (nonatomic, weak) id<XLECropRectViewDelegate> delegate;
@property (nonatomic) BOOL showsGridMajor;
@property (nonatomic) BOOL showsGridMinor;

@property (nonatomic) BOOL keepingAspectRatio;

@end

@protocol XLECropRectViewDelegate <NSObject>

- (void)cropRectViewDidBeginEditing:(XLECropRectView *)cropRectView;
- (void)cropRectViewEditingChanged:(XLECropRectView *)cropRectView;
- (void)cropRectViewDidEndEditing:(XLECropRectView *)cropRectView;

@end

