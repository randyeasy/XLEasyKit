//
//  XLEBaseCollectionView.h
//  Pods
//
//  Created by Randy on 16/1/11.
//
//

#import <UIKit/UIKit.h>
#import "XLECollectionViewDelegate.h"
#import "XLEKeyBoardCollectionView.h"

/*
 *  添加下拉刷新，上拉加载更多，空白页，错误页
 */

@interface XLEBaseCollectionView : XLEKeyBoardCollectionView

- (void)startRefresh;
- (void)setDelegate:(id<XLEBaseCollectionViewDelegate>)delegate;

@end
