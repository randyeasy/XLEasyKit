//
//  XLEBlankView.h
//  Pods
//
//  Created by Randy on 16/02/29.
//

#import <UIKit/UIKit.h>

/**
 *  列表无数据时的空白视图
 *  使用方法：如果上层需要定制具体的空白页面，请继承该View
 */
@interface XLEBlankView : UIView

@property (strong, readonly, nonatomic) UIImageView *imageView;
@property (strong, readonly, nonatomic) UILabel *label;
@property (strong, readonly, nonatomic) UIButton *button;

@end
