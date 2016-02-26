//
//  XLECameraViewController.h
//  Pods
//
//  Created by Randy on 16/2/2.
//
//

#import <UIKit/UIKit.h>
@class XLEAssetModel;
@class XLECameraConfig;

NS_ASSUME_NONNULL_BEGIN

@interface XLECameraViewController : UIViewController
/**
 *  初始化方法
 *
 *  @param config 可为空，为空时为默认值
 *
 *  @return
 */
- (instancetype)initWithConfig:(nullable XLECameraConfig *)config;

/**
 *  使用UINavigationController显示当前视图
 *
 *  @param vc
 *  @param cameraFinish 回调
 */
- (void)showWithParentVC:(UIViewController *)vc cameraFinish:(void(^)(XLECameraViewController *cameraVC, BOOL isSuc, XLEAssetModel *_Nullable asset))cameraFinish;

/**
 *  remove 当前视图
 *
 *  @param animated   动画
 *  @param completion remove完成后的回调
 */
- (void)dismissWithAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
