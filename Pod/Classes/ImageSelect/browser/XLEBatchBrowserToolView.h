//
//  XLEBatchBrowserToolView.h
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import <UIKit/UIKit.h>

#import "XLEBatchNumButton.h"
#import "XLEFullImageButton.h"

@interface XLEBatchBrowserToolView : UIView
@property (assign, nonatomic) BOOL hasFullImage;
@property (strong, readonly, nonatomic) XLEFullImageButton *fullButton;
@property (strong, readonly, nonatomic) XLEBatchNumButton *numButton;

- (void)updateBatchNumber:(NSInteger)num;

@end
