//
//  XLEImageEditToolView.h
//  Pods
//
//  Created by Randy on 16/1/26.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const XLE_IMAGE_EDIT_ACTION_USED;
extern NSString *const XLE_IMAGE_EDIT_ACTION_RESELECT;
extern NSString *const XLE_IMAGE_EDIT_ACTION_ROTATE;

@interface XLEImageEditToolView : UIView
@property (copy, nonatomic) void (^editAction)(XLEImageEditToolView *toolView, NSString *actionName);

@end

NS_ASSUME_NONNULL_END
  
