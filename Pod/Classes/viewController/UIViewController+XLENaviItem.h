//
//  UIViewController+XLENaviItem.h
//  Pods
//
//  Created by Randy on 16/2/24.
//
//

#import <UIKit/UIKit.h>

@class XLENaviButtonItem;
typedef void(^XLENaviBlock)(XLENaviButtonItem *naviItem);

@interface XLENaviButtonItem : NSObject
@property (copy, nonatomic) NSDictionary<NSString *,id> *titleAttributes;
@property (copy, nonatomic) NSDictionary<NSString *,id> *titlePressAttributes;//高亮


+ (instancetype)naviItemWithView:(UIView *)view;

+ (instancetype)naviItemWithTitle:(NSString *)title block:(XLENaviBlock )block;

+ (instancetype)naviItemWithImage:(UIImage *)image block:(XLENaviBlock )block;

+ (instancetype)naviItemWithImageUrl:(NSURL *)imageUrl block:(XLENaviBlock )block;

@end

@interface UIViewController (XLENaviItem)

- (void)XLE_setNaviTitle:(NSString *)title;
- (void)XLE_setNaviAttributedTitle:(NSAttributedString *)attTitle;

- (void)XLE_setNaviBackArrow;
- (void)XLE_setNaviDismissWithTitle:(NSString *)title;
/**
 *  overide method
 */
- (void)XLE_onBack;
/**
 *  overide method
 */
- (void)XLE_onDismiss;

/**
 *  按钮的最小宽度为35
 *
 *  @param item 
 */
- (void)XLE_setNaviLeftWithNaviItem:(XLENaviButtonItem *)item;
- (void)XLE_setNaviRightWithNaviItem:(XLENaviButtonItem *)item;
/**
 *  从左到右排序
 *
 *  @param items 左侧多个按钮
 */
- (void)XLE_setNaviLeftWithNaviItems:(NSArray<XLENaviButtonItem *>*)items;
/**
 *  从右到左排序
 *
 *  @param items 右侧多个按钮
 */
- (void)XLE_setNaviRightWithNaviItems:(NSArray<XLENaviButtonItem *>*)items;

@end
