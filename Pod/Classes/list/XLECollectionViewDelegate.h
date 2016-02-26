//
//  XLEBaseCollectionViewDelegate.h
//  Pods
//
//  Created by Randy on 16/1/11.
//
//

#import <UIKit/UIKit.h>

@class XLEBaseCollectionView;

@protocol XLEBaseCollectionViewDelegate <UICollectionViewDelegate>
@optional

//默认no
- (BOOL)hasMoreInCollectionView:(XLEBaseCollectionView *)collectionView;
//默认no
- (BOOL)hasRefreshInCollectionView:(XLEBaseCollectionView *)collectionView;
//默认不显示 目前只支持最后一个section。
- (UIView *)viewForBlankInCollectionView:(XLEBaseCollectionView *)collectionView;
//默认不显示 目前只支持最后一个section。
- (UIView *)viewForErrorInCollectionView:(XLEBaseCollectionView *)collectionView;

//默认no
- (void)collectionView:(XLEBaseCollectionView *)collectionView getMore:(void(^)())callback;
//默认no
- (void)collectionView:(XLEBaseCollectionView *)collectionView refresh:(void(^)(BOOL isSuc))callback;

@end
