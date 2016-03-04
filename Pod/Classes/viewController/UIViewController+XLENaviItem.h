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

- (void)xle_setNaviTitle:(NSString *)title;
- (void)xle_setNaviAttributedTitle:(NSAttributedString *)attTitle;

- (void)xle_setNaviBackArrow;
- (void)xle_setNaviDismissWithTitle:(NSString *)title;
/**
 *  overide method
 */
- (void)xle_onBack;
/**
 *  overide method
 */
- (void)xle_onDismiss;

/**
 *  按钮的最小宽度为35
 *
 *  @param item 
 */
- (void)xle_setNaviLeftWithNaviItem:(XLENaviButtonItem *)item;
- (void)xle_setNaviRightWithNaviItem:(XLENaviButtonItem *)item;
/**
 *  从左到右排序
 *
 *  @param items 左侧多个按钮
 */
- (void)xle_setNaviLeftWithNaviItems:(NSArray<XLENaviButtonItem *>*)items;
/**
 *  从右到左排序
 *
 *  @param items 右侧多个按钮
 */
- (void)xle_setNaviRightWithNaviItems:(NSArray<XLENaviButtonItem *>*)items;

@end
