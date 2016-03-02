//
//  XLETipCustomView.h
//  Pods
//
//  Created by Randy on 16/3/2.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLETipCustomView : UIView
@property (strong, readonly, nonatomic) UILabel *messageLabel;
@property (strong, readonly, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) CGFloat maxWidth;
@end

NS_ASSUME_NONNULL_END
