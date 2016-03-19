//
//  XLENavigationController.h
//
//  Created by Randy on 16/1/20.
//  Copyright © 2016年 Randy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  不要设置XLENavigationController的delegate
 */

@interface XLENavigationController : UINavigationController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

/**
 *  override method
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated NS_REQUIRES_SUPER;

/**
 *  override method
 */
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate NS_REQUIRES_SUPER;

@end


@interface UIViewController(XLENavigationController)

- (XLENavigationController *)XLENavigationController;

@end
