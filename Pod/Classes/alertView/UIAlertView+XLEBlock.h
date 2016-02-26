//
//  UIAlertView+Block.h
//  webrtcjingle
//
//  Created by archer on 4/14/14.
//
//

#import <UIKit/UIKit.h>
typedef void(^XLECompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (XLEBlock)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)xle_showAlertViewWithCompleteBlock:(XLECompleteBlock) block;


@end
