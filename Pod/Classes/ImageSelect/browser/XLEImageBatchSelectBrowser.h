//
//  XLEImageBatchSelectBrowser.h
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import <UIKit/UIKit.h>
@class XLEAssetModel;

#import "XLEImageBrowserDelegate.h"

@interface XLEImageBatchSelectBrowser : UIViewController
@property (assign, nonatomic) BOOL hasFullImage;
@property (weak, nonatomic) id<XLEImageBrowserDelegate> delegate;

@property (copy, nonatomic) NSString *finishTitle; //默认 “完成”

/**
 *  唯一初始化方法 请保证assets和selectedAssets列表中的对象是一样的
 *
 *  @param assets         浏览的列表
 *  @param selectedAssets 已选择的列表
 *  @param index          默认展示的index
 *
 *  @return
 */
- (instancetype)initWithAssets:(NSArray<XLEAssetModel *> *)assets
                selectedAssets:(NSMutableArray<XLEAssetModel *> *)selectedAssets
                         index:(NSInteger)index
                     fullImage:(BOOL)isFullImage;
@end
