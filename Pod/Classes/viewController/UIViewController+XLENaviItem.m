//
//  UIViewController+XLENaviItem.m
//  Pods
//
//  Created by Randy on 16/2/24.
//
//

#import "UIViewController+XLENaviItem.h"
#import "XLEView.h"
#import "XLENavigationController.h"

const CGFloat XLE_NAVI_BUTTON_ITEM_MIN_WIDTH = 44;

@interface XLENaviButtonItem ()
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *imageUrl;
@property (copy, nonatomic) XLENaviBlock selBlock;
@property (strong, nonatomic) UIView *customView;
@end

@implementation XLENaviButtonItem

+ (instancetype)naviItemWithView:(UIView *)view;
{
    XLENaviButtonItem *item = [[XLENaviButtonItem alloc] init];
    item.customView = view;
    return item;
}

+ (instancetype)naviItemWithTitle:(NSString *)title block:(XLENaviBlock )block
{
    XLENaviButtonItem *item = [[XLENaviButtonItem alloc] init];
    item.title = title;
    item.selBlock = block;
    return item;
}

+ (instancetype)naviItemWithImage:(UIImage *)image block:(XLENaviBlock )block
{
    XLENaviButtonItem *item = [[XLENaviButtonItem alloc] init];
    item.image = image;
    item.selBlock = block;
    return item;
}

+ (instancetype)naviItemWithImageUrl:(NSURL *)imageUrl block:(XLENaviBlock )block
{
    XLENaviButtonItem *item = [[XLENaviButtonItem alloc] init];
    item.imageUrl = imageUrl;
    item.selBlock = block;
    return item;
}

+ (instancetype)naviItemWithTitle:(NSString *)title
                            image:(UIImage *)image
                            block:(XLENaviBlock )block;
{
    XLENaviButtonItem *item = [[XLENaviButtonItem alloc] init];
    item.image = image;
    item.title = title;
    item.selBlock = block;
    return item;
}

@end

@implementation UIViewController (XLENaviItem)

- (void)xle_setNaviTitle:(NSString *)title;
{
    [self xle_setNaviAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:XLEApperanceInstance.naviTitleAttributes]];
}

- (void)xle_setNaviAttributedTitle:(NSAttributedString *)attTitle;
{
    UILabel *theLabel = (UILabel *)self.navigationItem.titleView;
    if (!theLabel || ![theLabel isKindOfClass:[UILabel class]]) {
        theLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            label;
        });
        self.navigationItem.titleView = theLabel;
    }
    theLabel.attributedText = attTitle;
    [theLabel sizeToFit];
}

- (void)xle_setNaviBackArrow;
{
    XLEWS(weakSelf);
    XLENaviButtonItem *naviItem = [XLENaviButtonItem naviItemWithImage:XLEApperanceInstance.naviBarBackImage block:^(XLENaviButtonItem *naviItem) {
        [weakSelf xle_onBack];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self xle_naviButtonWithNaviItem:naviItem right:NO]];
}

- (void)xle_setNaviDismissWithTitle:(NSString *)title;
{
    XLEWS(weakSelf);
    XLENaviButtonItem *naviItem = [XLENaviButtonItem naviItemWithTitle:title block:^(XLENaviButtonItem *naviItem) {
        [weakSelf xle_onDismiss];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self xle_naviButtonWithNaviItem:naviItem right:NO]];
}
/**
 *  overide method
 */
- (void)xle_onBack;
{
    [self.xleNavigationController popViewControllerAnimated:YES];
}

/**
 *  overide method
 */
- (void)xle_onDismiss;
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)xle_setNaviLeftWithNaviItem:(XLENaviButtonItem *)item;
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self xle_naviButtonWithNaviItem:item right:NO]];
}

- (void)xle_setNaviRightWithNaviItem:(XLENaviButtonItem *)item;
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self xle_naviButtonWithNaviItem:item right:YES]];
}

- (void)xle_setNaviLeftButtonItems:(NSArray<XLENaviButtonItem *>*)items;
{
    NSMutableArray *mutList = [[NSMutableArray alloc] initWithCapacity:items.count];
    for (XLENaviButtonItem *oneItem in items) {
        [mutList addObject:[self xle_naviButtonWithNaviItem:oneItem right:NO]];
    }
    self.navigationItem.leftBarButtonItems = mutList;
}

- (void)xle_setNaviRightButtonItems:(NSArray<XLENaviButtonItem *>*)items;
{
    NSMutableArray *mutList = [[NSMutableArray alloc] initWithCapacity:items.count];
    for (XLENaviButtonItem *oneItem in items) {
        [mutList addObject:[self xle_naviButtonWithNaviItem:oneItem right:YES]];
    }
    self.navigationItem.rightBarButtonItems = mutList;
}

#pragma mark - internal
- (void)xle_naviButtonItemAction:(UIButton *)sender
{
    XLENaviButtonItem *item = sender.xle_key;
    if (item.selBlock) {
        item.selBlock(item);
    }
}

- (UIButton *)xle_naviButtonWithNaviItem:(XLENaviButtonItem *)item right:(BOOL)isRight
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    if (item.title) {
        NSAttributedString *att = [[NSAttributedString alloc] initWithString:item.title attributes:XLEApperanceInstance.naviRightTitleAttributes];
        NSAttributedString *pressAtt = [[NSAttributedString alloc] initWithString:item.title attributes:XLEApperanceInstance.naviRightTitlePressAttributes];
        [button setAttributedTitle:att forState:UIControlStateNormal];
        [button setAttributedTitle:pressAtt forState:UIControlStateNormal];
    }
    if (item.image)
    {
        [button setImage:item.image forState:UIControlStateNormal];
    }
    else if (item.imageUrl) {
        [button sd_setImageWithURL:item.imageUrl forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [button sizeToFit];
        }];
    }

    [button sizeToFit];
    CGFloat originalWidth = button.frame.size.width;
    if (originalWidth < XLE_NAVI_BUTTON_ITEM_MIN_WIDTH) {
        button.xle_current_w = XLE_NAVI_BUTTON_ITEM_MIN_WIDTH;
        [button xle_setImageEdgeWithOffset:XLE_NAVI_BUTTON_ITEM_MIN_WIDTH - originalWidth direction:XLE_VIEW_DIRECTION_LEFT];
        [button xle_setTitleEdgeWithOffset:XLE_NAVI_BUTTON_ITEM_MIN_WIDTH - originalWidth direction:XLE_VIEW_DIRECTION_LEFT];
    }
    
    if (item.selBlock) {
        button.xle_key = item;
        [button addTarget:self action:@selector(xle_naviButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}


@end