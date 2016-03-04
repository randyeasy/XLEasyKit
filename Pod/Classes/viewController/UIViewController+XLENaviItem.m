//
//  UIViewController+XLENaviItem.m
//  Pods
//
//  Created by Randy on 16/2/24.
//
//

#import "UIViewController+XLENaviItem.h"
#import "XLEViewKit.h"
#import "XLENavigationController.h"

const CGFloat XLE_NAVI_BUTTON_ITEM_MIN_WIDTH = 35;

@interface XLENaviButtonItem ()
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *imageUrl;
@property (copy, nonatomic) XLENaviBlock selBlock;
@property (strong, nonatomic) UIView *customView;
@end

@implementation XLENaviButtonItem

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

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

#pragma mark - internal
- (void)setTitleAttributes:(NSDictionary<NSString *,id> *)titleAttributes{
    _titleAttributes = titleAttributes;
    if (_titlePressAttributes == nil) {
        _titlePressAttributes = titleAttributes;
    }
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self xle_naviButtonWithNaviItem:item right:YES]];
}

- (void)xle_setNaviLeftWithNaviItems:(NSArray<XLENaviButtonItem *>*)items;
{
    NSMutableArray *mutList = [[NSMutableArray alloc] initWithCapacity:items.count];
    for (XLENaviButtonItem *oneItem in items) {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:[self xle_naviButtonWithNaviItem:oneItem right:NO]];
        [mutList addObject:barItem];
    }
    self.navigationItem.leftBarButtonItems = mutList;
}

- (void)xle_setNaviRightWithNaviItems:(NSArray<XLENaviButtonItem *>*)items;
{
    NSMutableArray *mutList = [[NSMutableArray alloc] initWithCapacity:items.count];
    for (XLENaviButtonItem *oneItem in items) {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:[self xle_naviButtonWithNaviItem:oneItem right:YES]];
        [mutList addObject:barItem];
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
    
    NSDictionary *attDic = item.titleAttributes;
    NSDictionary *pressAttDic = item.titlePressAttributes;
    if (!attDic) {
        if (isRight)
            attDic = XLEApperanceInstance.naviRightTitleAttributes;
        else
            attDic = XLEApperanceInstance.naviLeftTitleAttributes;
    }
    
    if (!pressAttDic) {
        if (isRight)
            pressAttDic = XLEApperanceInstance.naviRightTitlePressAttributes;
        else
            pressAttDic = XLEApperanceInstance.naviLeftTitlePressAttributes;
    }
    
    if (item.title) {
        NSAttributedString *att = [[NSAttributedString alloc] initWithString:item.title attributes:attDic];
        NSAttributedString *pressAtt = [[NSAttributedString alloc] initWithString:item.title attributes:pressAttDic];
        [button setAttributedTitle:att forState:UIControlStateNormal];
        [button setAttributedTitle:pressAtt forState:UIControlStateHighlighted];
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
        CGFloat offset = XLE_NAVI_BUTTON_ITEM_MIN_WIDTH / 2.0f - originalWidth / 2.0f;
        if (isRight) {
            [button xle_setImageEdgeWithOffset:offset direction:XLE_VIEW_DIRECTION_RIGHT];
            [button xle_setTitleEdgeWithOffset:offset direction:XLE_VIEW_DIRECTION_RIGHT];
        }
        else{
            [button xle_setImageEdgeWithOffset:offset direction:XLE_VIEW_DIRECTION_LEFT];
            [button xle_setTitleEdgeWithOffset:offset direction:XLE_VIEW_DIRECTION_LEFT];
        }
    }
    
    if (item.selBlock) {
        button.xle_key = item;
        [button addTarget:self action:@selector(xle_naviButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}


@end
