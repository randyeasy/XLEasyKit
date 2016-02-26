//
//  XLEAssetsViewController.m
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import "XLEAssetsViewController.h"
#import "XLEAssetCell.h"
#import "XLEImagePickerController.h"
#import "XLEImagePickerConfig.h"
#import "XLEBatchToolView.h"
#import "UIAlertView+XLEBlock.h"
#import "XLEAssetModel.h"
#import "XLEApperance.h"
#import "UIImage+xle.h"
#import "UIImage+XLEUitls.h"
#import "XLEAssetMananger.h"

#import "XLEAssetAuthView.h"

#import <PureLayout/PureLayout.h>

static const CGFloat XLE_BATCH_FOOTER_VIEW_HEIGHT = 42;

@interface XLEAssetsViewController ()<
    UICollectionViewDataSource,
    UICollectionViewDelegate
>
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong) NSMutableArray<XLEAssetModel *> *assetsArray;
@property (strong, nonatomic) NSMutableArray<XLEAssetModel *> *selectedAssetsArray;

@property (strong, nonatomic) ALAssetsGroup *assetsGroup;

@property (strong, nonatomic) XLEImagePickerConfig *config;

@property (strong, nonatomic) XLEBatchToolView *batchFooterView;
@property (strong, nonatomic) XLEAssetAuthView *authView;

@end

@implementation XLEAssetsViewController

- (void)dealloc
{
    
}

- (instancetype)initWithAssetGroup:(ALAssetsGroup *)group
                            config:(XLEImagePickerConfig *)config
{
    self = [super init];
    if (self) {
        _assetsGroup = group;
        _config = config;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
    [self updateBatchView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }


    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage xle_imageNamed:@"xle_back"] xle_imageWithRenderingOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    // Do any additional setup after loading the view.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    cancelButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:cancelButton animated:NO];
    
    self.batchFooterView.finishButton.sendLabel.text = self.config.batchFinishTitle;
    [self.batchFooterView.browserButton addTarget:self action:@selector(browserBatchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.batchFooterView.finishButton addTarget:self action:@selector(didFinishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.batchFooterView updateBatchNumber:self.selectedAssetsArray.count];

    [self.view addSubview:self.collectionView];
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.collectionView registerClass:[XLEAssetCell class] forCellWithReuseIdentifier:@"XLEAssetCell"];
    if (self.config.isBatch) {
        self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, XLE_BATCH_FOOTER_VIEW_HEIGHT, 0);
        self.collectionView.contentInset = self.collectionView.scrollIndicatorInsets;
        [self.view addSubview:self.batchFooterView];
        [self.batchFooterView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
        [self.batchFooterView autoSetDimension:ALDimensionHeight toSize:XLE_BATCH_FOOTER_VIEW_HEIGHT];
        
    }
    
    BOOL denied = NO;
    switch ([ALAssetsLibrary authorizationStatus])
    {
        case ALAuthorizationStatusAuthorized:
        {
            break;
        }
        case ALAuthorizationStatusDenied:
        case ALAuthorizationStatusRestricted:
        {
            denied = YES;
            break;
        }
        case ALAuthorizationStatusNotDetermined:
        {
            break;
        }
    }
    
    if (!denied) {
        [self.authView removeFromSuperview];
        
        if (self.assetsGroup == nil) {
            [[XLEAssetMananger sharedInstance].assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                if (!(*stop)) {
                    if (group) {
                        switch(self.config.assetType) {
                            case XLE_IMAGEPICKER_ASSET_ANY:
                                [group setAssetsFilter:[ALAssetsFilter allAssets]];
                                break;
                            case XLE_IMAGEPICKER_ASSET_PHOTO:
                                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                break;
                            case XLE_IMAGEPICKER_ASSET_VIDEO:
                                [group setAssetsFilter:[ALAssetsFilter allVideos]];
                                break;
                        }
                        
                        if(group.numberOfAssets > 0) {
                            self.assetsGroup = group;
                            self.title =[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
                            [self loadData];
                            *stop = YES;
                        }
                    }
                    else
                    {
                        *stop = YES;
                    }
                }
                
            } failureBlock:^(NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedFailureReason?:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert xle_showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    
                }];
            }];
        }
        else
        {
            [self loadData];
            self.title =[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
        }
        
    }
    else
    {
        [self.view addSubview:self.authView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
    
}

- (void)loadData
{
    switch(self.config.assetType) {
        case XLE_IMAGEPICKER_ASSET_ANY:
            [self.assetsGroup setAssetsFilter:[ALAssetsFilter allAssets]];
            break;
        case XLE_IMAGEPICKER_ASSET_PHOTO:
            [self.assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
            break;
        case XLE_IMAGEPICKER_ASSET_VIDEO:
            [self.assetsGroup setAssetsFilter:[ALAssetsFilter allVideos]];
            break;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *mutList = [[NSMutableArray alloc] init];
        [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                [mutList insertObject:[[XLEAssetModel alloc] initWithAsset:result] atIndex:0];
            }
            else
            {
                *stop = YES;
                self.assetsArray = mutList;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                    [self scrollerToBottom:NO];
                });
            }
        }];
    });
}

- (void)updateBatchView
{
    [self.batchFooterView updateBatchNumber:self.selectedAssetsArray.count];
}

#pragma mark - action
- (void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cancelAction
{
    if ([self.pickerDelegate respondsToSelector:@selector(imagePickerDidCancel:)]) {
        [self.pickerDelegate imagePickerDidCancel:self.navigationController];
    }
}

- (void)browserBatchAction
{
    if ([self.pickerDelegate respondsToSelector:@selector(imagePicker:didBrowserAssets:selectedAssets:assetIndex:)]) {
        [self.pickerDelegate imagePicker:self.navigationController didBrowserAssets:[self.selectedAssetsArray copy] selectedAssets:self.selectedAssetsArray assetIndex:0];
    }
}

- (void)didFinishAction
{
    if ([self.pickerDelegate respondsToSelector:@selector(imagePicker:didSelectAssets:)]) {
        [self.pickerDelegate imagePicker:self.navigationController didSelectAssets:self.selectedAssetsArray];
    }
}

#pragma mark - scroll
- (void)scrollerToBottom:(BOOL)animated
{
    NSInteger rows = [self.collectionView numberOfItemsInSection:0] - 1;
    if (rows>0) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:rows inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:animated];
    }
}

#pragma mark - UICollectionView delegate and Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLEAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLEAssetCell" forIndexPath:indexPath];
    XLEAssetModel *asset = self.assetsArray[indexPath.row];
    cell.imageView.image = [asset thumbnailImageWithSize:cell.imageView.frame.size];
    if (self.config.isBatch) {
        cell.showSelect = YES;
        cell.selected = [self assetIsSelected:asset];
        __weak XLEAssetsViewController *weakSelf = self;
        cell.assetSelectUpdate = ^(XLEAssetCell *cell){
            if (cell.selected) {
                if (![weakSelf.selectedAssetsArray containsObject:asset]) {
                    [weakSelf.selectedAssetsArray addObject:asset];
                }
            }
            else
            {
                [weakSelf.selectedAssetsArray removeObject:asset];
            }
            [weakSelf updateBatchView];
        };
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    XLEAssetModel *asset = self.assetsArray[indexPath.row];
    BOOL shouldSelect = YES;
    if ([self.pickerDelegate respondsToSelector:@selector(imagePicker:shouldSelectAsset:)]) {
        shouldSelect = [self.pickerDelegate imagePicker:self.navigationController shouldSelectAsset:asset];
    }
    if (!shouldSelect) {
        return NO;
    }
    if (self.config.isBatch) {
        if ([self.pickerDelegate respondsToSelector:@selector(imagePicker:didBrowserAssets:selectedAssets:assetIndex:)]) {
            [self.pickerDelegate imagePicker:self.navigationController didBrowserAssets:self.assetsArray selectedAssets:self.selectedAssetsArray assetIndex:indexPath.row];
        }
    }
    else
    {
        
        if ([self.pickerDelegate respondsToSelector:@selector(imagePicker:didSelectAssets:)]) {
            [self.pickerDelegate imagePicker:self.navigationController didSelectAssets:@[asset]];
        }
    }
    return NO;
}

#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - internal
- (BOOL)assetIsSelected:(XLEAssetModel *)targetAsset
{
    return [self.selectedAssetsArray containsObject:targetAsset];
}

#pragma mark - set get
- (UICollectionView *)collectionView
{
    if (nil == _collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2.0;
        layout.minimumInteritemSpacing = 2.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[XLEAssetCell class] forCellWithReuseIdentifier:@"XLEAssetCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = YES;
    }
    
    return _collectionView;
}

- (XLEAssetAuthView *)authView{
    if (_authView == nil) {
        _authView = [[XLEAssetAuthView alloc] initWithFrame:self.view.bounds];
    }
    return _authView;
}

- (XLEBatchToolView *)batchFooterView
{
    if (_batchFooterView == nil) {
        _batchFooterView = [[XLEBatchToolView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - XLE_BATCH_FOOTER_VIEW_HEIGHT, self.view.frame.size.width, XLE_BATCH_FOOTER_VIEW_HEIGHT)];
    }
    return _batchFooterView;
}

- (NSMutableArray *)selectedAssetsArray{
    if (_selectedAssetsArray == nil) {
        _selectedAssetsArray = [[NSMutableArray alloc] init];
    }
    return _selectedAssetsArray;
}

@end
