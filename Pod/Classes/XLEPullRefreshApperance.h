//
//  XLEPullRefreshApperance.h
//  Pods
//
//  Created by Randy on 16/2/20.
//
//

#import <Foundation/Foundation.h>

#define XLERefreshApperance [XLEPullRefreshApperance sharedInstance]

NS_ASSUME_NONNULL_BEGIN

@interface XLEPullRefreshApperance : NSObject
//下拉刷新
@property (copy, nullable, nonatomic) NSArray<UIImage *> *idleIamges;
@property (copy, nullable, nonatomic) NSArray<UIImage *> *pullingIamges;
@property (copy, nullable, nonatomic) NSArray<UIImage *> *refreshingIamges;
@property (assign, nonatomic) NSTimeInterval animatedDuration;

@property (copy, nonatomic) NSString *idleStateTitle;
@property (copy, nonatomic) NSString *pullingStateTitle;
@property (copy, nonatomic) NSString *refreshingStateTitle;

@property (strong, nonatomic) UIFont *stateFont;
@property (strong, nonatomic) UIFont *lastUpdatedTimeFont;

@property (strong, nonatomic) UIColor *stateTextColor;
@property (strong, nonatomic) UIColor *lastUpdatedTimeTextColor;

@property (assign, nonatomic) BOOL lastUpdatedTimeHidden;
@property (assign, nonatomic) BOOL stateHidden;

@property (assign, nonatomic) CGFloat headerHeight;

//上拉刷新
@property (copy, nullable, nonatomic) NSArray<UIImage *> *footerIdleIamges;
@property (copy, nullable, nonatomic) NSArray<UIImage *> *footerPullingIamges;
@property (copy, nullable, nonatomic) NSArray<UIImage *> *footerRefreshingIamges;
@property (assign, nonatomic) NSTimeInterval footerAnimatedDuration;

@property (assign, nonatomic) BOOL footerTitleHidden;
@property (copy, nonatomic) NSString *footerIdelTitle;
@property (copy, nonatomic) NSString *footerPullingTitle;
@property (copy, nonatomic) NSString *footerRefreshingTitle;
@property (copy, nonatomic) NSString *footerNoMoreTitle;

@property (strong, nonatomic) UIFont *footerStateFont;
@property (strong, nonatomic) UIColor *footerStateTextColor;

@property (assign, nonatomic) CGFloat footerHeight;

+ (instancetype)sharedInstance;

@end


NS_ASSUME_NONNULL_END
