//
//  XLEAlbumViewController.m
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import "XLEAlbumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "XLEAssetsViewController.h"
#import "XLEImagePickerConfig.h"
#import "UIColor+XLEUtil.h"
#import "XLEAssetAuthView.h"
#import <PureLayout/PureLayout.h>
#import "XLEAlbumTableViewCell.h"
#import "XLEAssetMananger.h"

static NSString* const albumTableViewCellReuseIdentifier = @"albumTableViewCellReuseIdentifier";


@interface XLEAlbumViewController ()<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *assetsGroups;
@property (strong, nonatomic) XLEImagePickerConfig *config;
@property (strong, nonatomic) XLEAssetAuthView *authView;

@end

@implementation XLEAlbumViewController

- (void)dealloc
{
    
}

- (instancetype)initWithConfig:(XLEImagePickerConfig *)config
{
    self = [super init];
    if (self) {
        _config = config;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片";

    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    self.view.backgroundColor = [UIColor xle_colorWithHexString:@"#fafafa"];
    self.tableView.backgroundColor = [UIColor xle_colorWithHexString:@"#fafafa"];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    cancelButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:cancelButton animated:NO];
    
    [self.tableView registerClass:[XLEAlbumTableViewCell class] forCellReuseIdentifier:albumTableViewCellReuseIdentifier];
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
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
        [[XLEAssetMananger sharedInstance].assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop) {
            if(assetsGroup) {
                switch(self.config.assetType) {
                    case XLE_IMAGEPICKER_ASSET_ANY:
                        [assetsGroup setAssetsFilter:[ALAssetsFilter allAssets]];
                        break;
                    case XLE_IMAGEPICKER_ASSET_PHOTO:
                        [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
                        break;
                    case XLE_IMAGEPICKER_ASSET_VIDEO:
                        [assetsGroup setAssetsFilter:[ALAssetsFilter allVideos]];
                        break;
                }
                
                if(assetsGroup.numberOfAssets > 0) {
                    [self.assetsGroups addObject:assetsGroup];
                }
            }
            else
            {
                *stop = YES;
                [self.tableView reloadData];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }];
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

#pragma mark - action
- (void)cancelAction
{
    if ([self.pickerDelegate respondsToSelector:@selector(imagePickerDidCancel:)]) {
        [self.pickerDelegate imagePickerDidCancel:self.navigationController];
    }
}

#pragma mark - UITableView delegate
- (NSAttributedString *)albumTitle:(ALAssetsGroup *)assetsGroup
{
    NSString *albumTitle = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    NSString *numberString = [NSString stringWithFormat:@"  (%@)",@(assetsGroup.numberOfAssets)];
    NSString *cellTitleString = [NSString stringWithFormat:@"%@%@",albumTitle,numberString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cellTitleString];
    [attributedString setAttributes: @{
                                       NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                                       NSForegroundColorAttributeName : [UIColor blackColor],
                                       }
                              range:NSMakeRange(0, albumTitle.length)];
    [attributedString setAttributes:@{
                                      NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                      NSForegroundColorAttributeName : [UIColor xle_colorWithHexString:@"#999999"],
                                      } range:NSMakeRange(albumTitle.length, numberString.length)];
    return attributedString;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetsGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLEAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:albumTableViewCellReuseIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ALAssetsGroup *group = self.assetsGroups[indexPath.row];
    cell.nameLabel.attributedText = [self albumTitle:group];
    
    //choose the latest pic as poster image
    __weak XLEAlbumTableViewCell *blockCell = cell;
    [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:group.numberOfAssets-1] options:NSEnumerationConcurrent usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            *stop = YES;
            blockCell.photoImageView.image = [UIImage imageWithCGImage:result.thumbnail];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALAssetsGroup *group = self.assetsGroups[indexPath.row];
    XLEAssetsViewController *vc = [[XLEAssetsViewController alloc] initWithAssetGroup:group config:self.config];
    vc.pickerDelegate = self.pickerDelegate;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - set get 
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 57.0f;
    }
    return _tableView;
}

- (XLEAssetAuthView *)authView{
    if (_authView == nil) {
        _authView = [[XLEAssetAuthView alloc] initWithFrame:self.view.bounds];
    }
    return _authView;
}

- (XLEImagePickerConfig *)config{
    if (_config == nil) {
        _config = [[XLEImagePickerConfig alloc] init];
    }
    return _config;
}

- (NSMutableArray *)assetsGroups{
    if (_assetsGroups == nil) {
        _assetsGroups = [[NSMutableArray alloc] init];
    }
    return _assetsGroups;
}

@end
