//
//  XLEAssetCell.h
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import <UIKit/UIKit.h>

@interface XLEAssetCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) BOOL showSelect;
@property (copy, nonatomic) void(^assetSelectUpdate)(XLEAssetCell *cell);

@end
