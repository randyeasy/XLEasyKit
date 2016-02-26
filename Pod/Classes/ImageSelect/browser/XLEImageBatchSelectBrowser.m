//
//  XLEImageBatchSelectBrowser.m
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import "XLEImageBatchSelectBrowser.h"
#import "XLEAssetModel.h"
#import "XLEBatchBrowserToolView.h"
#import "XLEBatchBrowserNaviView.h"
#import "XLEBrowserCell.h"
#import <PureLayout/PureLayout.h>

static CGFloat XLE_TOOL_HEIGHT = 44;
static CGFloat XLE_NAVI_HEIGHT = 64;

@interface XLEImageBatchSelectBrowser ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (copy, nonatomic) NSArray<XLEAssetModel *> *assets;
@property (strong, nonatomic) NSMutableArray<XLEAssetModel *> *selectedAssets;
@property (assign, nonatomic) NSInteger curIndex;
@property (assign, getter=isFullImage, nonatomic) BOOL fullImage;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XLEBatchBrowserToolView *toolView;
@property (nonatomic, strong) XLEBatchBrowserNaviView *naviView;
@property (nonatomic, strong) NSLayoutConstraint *naviTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *toolBottomConstraint;
@property (nonatomic, assign) BOOL barHidden;

@property (nonatomic, assign) BOOL originalNaviBarHidden;
@property (nonatomic, assign) BOOL originalStatuBarHidden;

@end

@implementation XLEImageBatchSelectBrowser

- (void)dealloc
{
    
}

- (instancetype)initWithAssets:(NSArray<XLEAssetModel *> *)assets
                selectedAssets:(NSMutableArray<XLEAssetModel *> *)selectedAssets
                         index:(NSInteger)index
                     fullImage:(BOOL)isFullImage;
{
    self = [super init];
    if (self) {
        _fullImage = isFullImage;
        _assets = assets;
        _selectedAssets = selectedAssets;
        _curIndex = index;
        _finishTitle = @"完成";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.originalNaviBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.originalNaviBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    if (!self.originalStatuBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
    self.automaticallyAdjustsScrollViewInsets = NO;        
    }

    self.view.backgroundColor = [UIColor blackColor];
    self.originalNaviBarHidden = self.navigationController.navigationBarHidden;
    self.originalStatuBarHidden = [UIApplication sharedApplication].statusBarHidden;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.naviView];
    [self.view addSubview:self.toolView];

    self.naviTopConstraint = [self.naviView autoPinEdgeToSuperviewEdge:ALEdgeTop  withInset:0];
    [self.naviView autoPinEdgeToSuperviewEdge:ALEdgeLeading  withInset:0];
    [self.naviView autoPinEdgeToSuperviewEdge:ALEdgeTrailing  withInset:0];
    [self.naviView autoSetDimension:ALDimensionHeight toSize:XLE_NAVI_HEIGHT];
    
    self.toolBottomConstraint = [self.toolView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.toolView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.toolView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [self.toolView autoSetDimension:ALDimensionHeight toSize:XLE_TOOL_HEIGHT];
    
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.naviView.backBautton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView.fullButton addTarget:self action:@selector(fullAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView.numButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    
    XLEAssetModel *curAsset = self.assets[self.curIndex];
    self.naviView.selectButton.selected = [self.selectedAssets containsObject:curAsset];

    self.toolView.numButton.enabled = self.selectedAssets.count>0?YES:NO;
    
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width * self.curIndex,0)];
    
    [self updateSelestedNumber];
    [self updateBarViewContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return self.barHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateBarViewHidden
{
    self.barHidden = !self.barHidden;
    
    if (self.barHidden) {
        [UIView animateWithDuration:0.2 animations:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
            self.naviView.alpha = 0.5;
            self.toolView.alpha = 0.5;
            self.naviTopConstraint.constant = -XLE_NAVI_HEIGHT;
            self.toolBottomConstraint.constant = XLE_TOOL_HEIGHT;
            [self.view layoutIfNeeded];
        }];
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
            self.naviView.alpha = 1;
            self.toolView.alpha = 1;
            self.naviTopConstraint.constant = 0;
            self.toolBottomConstraint.constant = 0;
            [self.view layoutIfNeeded];
        }];
    }

    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)updateSelestedNumber
{
    NSUInteger selectedNumber = self.selectedAssets.count;
    [self.toolView updateBatchNumber:selectedNumber];
}

- (void)updateBarViewContent
{
    if (self.hasFullImage) {
        self.toolView.fullButton.selected = self.isFullImage;
        if (self.isFullImage) {
            XLEAssetModel *asset = self.assets[self.curIndex];
            NSInteger size = (asset.originalImageSize/1024);
            CGFloat imageSize = (CGFloat)size;
            NSString *imageSizeString;
            if (size > 1024) {
                imageSize = imageSize/1024.0f;
                imageSizeString = [NSString stringWithFormat:@"(%.1fM)",imageSize];
            } else {
                imageSizeString = [NSString stringWithFormat:@"(%@K)",@(size)];
            }
            self.toolView.fullButton.text = imageSizeString;
        }
    }
    self.naviView.titleLabel.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.curIndex+1,(unsigned long)self.assets.count];

    XLEAssetModel *asset = self.assets[self.curIndex];
    self.naviView.selectButton.selected = [self.selectedAssets containsObject:asset];
}

#pragma mark - action
- (void)backAction
{
    if ([self.delegate respondsToSelector:@selector(imageBrowserDidCancel:)]) {
        [self.delegate imageBrowserDidCancel:self];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)selectAction:(UIButton *)sender
{
    XLEAssetModel *asset = self.assets[self.curIndex];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.selectedAssets addObject:asset];
    }
    else
    {
        [self.selectedAssets removeObject:asset];
    }
    [self updateSelestedNumber];
    [self updateBarViewContent];
}

- (void)fullAction
{
    self.toolView.fullButton.selected = !self.toolView.fullButton.selected;
    self.fullImage = self.toolView.fullButton.selected;
    if (self.fullImage) {
//        XLEAssetModel *asset = self.assets[self.curIndex];
//        BOOL shouldSelect = YES;
//        if ([self.delegate respondsToSelector:@selector(imageBrowser:shouldSelectAsset:)]) {
//            shouldSelect = [self.delegate imageBrowser:self shouldSelectAsset:asset];
//        }
//        if (shouldSelect) {
//            if (![self.selectedAssets containsObject:asset]) {
//                [self.selectedAssets addObject:asset];
//                [self updateSelestedNumber];
//            }
//        }
        [self updateBarViewContent];
    }
    if ([self.delegate respondsToSelector:@selector(imageBrowser:fullImage:)]) {
        [self.delegate imageBrowser:self fullImage:self.fullImage];
    }
}

- (void)sendAction
{
    if ([self.delegate respondsToSelector:@selector(imageBrowser:didSelectAssets:)]) {
        [self.delegate imageBrowser:self didSelectAssets:self.selectedAssets];
    }
}

#pragma mark - UICollectionView delegate and Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLEBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLEBrowserCell" forIndexPath:indexPath];
    XLEAssetModel *asset = self.assets[indexPath.row];
    cell.selected = [self assetIsSelected:asset];
    __weak XLEImageBatchSelectBrowser *weakSelf = self;
    cell.browserView.singleTap = ^(XLEBrowserView *view){
        [weakSelf updateBarViewHidden];
    };
    UIImage *img = [asset originalImage];
    [cell.browserView updateBrowserImage:img];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size;
}

#pragma mark - scrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat itemWidth = CGRectGetWidth(self.collectionView.frame);
    CGFloat currentPageOffset = itemWidth * self.curIndex;
    CGFloat deltaOffset = offsetX - currentPageOffset;
    if (fabs(deltaOffset) >= itemWidth/2 ) {
        [self.toolView.fullButton shouldAnimating:YES];
    } else {
        [self.toolView.fullButton shouldAnimating:NO];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat itemWidth = CGRectGetWidth(self.collectionView.frame);
    if (offsetX >= 0){
        NSInteger page = offsetX / itemWidth;
        [self didScrollToPage:page];
    }
    
    [self.toolView.fullButton shouldAnimating:NO];
}

- (void)didScrollToPage:(NSInteger)page
{
    self.curIndex = page;
    [self updateBarViewContent];
}

#pragma mark - internal
- (BOOL)assetIsSelected:(XLEAssetModel *)targetAsset
{
    return [self.selectedAssets containsObject:targetAsset];
}

#pragma mark - set get
- (void)setFinishTitle:(NSString *)finishTitle{
    _finishTitle = finishTitle;
    self.toolView.numButton.sendLabel.text = finishTitle;
}

- (void)setHasFullImage:(BOOL)hasFullImage{
    _hasFullImage = hasFullImage;
    if (!hasFullImage) {
        self.fullImage = NO;
    }
    self.toolView.hasFullImage = hasFullImage;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[XLEBrowserCell class] forCellWithReuseIdentifier:@"XLEBrowserCell"];
        
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (XLEBatchBrowserNaviView *)naviView{
    if (_naviView == nil) {
        _naviView = [[XLEBatchBrowserNaviView alloc] init];
    }
    return _naviView;
}

- (XLEBatchBrowserToolView *)toolView{
    if (_toolView == nil) {
        _toolView = [[XLEBatchBrowserToolView alloc] init];
    }
    return _toolView;
}

@end
