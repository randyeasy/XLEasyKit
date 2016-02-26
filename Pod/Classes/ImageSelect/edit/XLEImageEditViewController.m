//
//  XLEImageEditViewController.m
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import "XLEImageEditViewController.h"
#import "XLECropView.h"
#import "XLEImageEditToolView.h"
#import "XLEImageCropConfig.h"
#import <PureLayout/PureLayout.h>
#import "XLEAssetModel.h"

static CGFloat XLE_IMAGE_EDIT_TOOL_HEIGHT = 64;

@interface XLEImageEditViewController ()
@property (strong, nonatomic) XLEImageEditToolView *toolView;
@property (strong, nonatomic) XLECropView *cropView;

@property (assign, nonatomic) BOOL originalNaviBarHidden;

@property (strong, nonatomic) XLEAssetModel *originAsset;
@property (strong, nonatomic) XLEAssetModel *editAsset;

@property (strong, nonatomic) XLEImageCropConfig *config;

@end

@implementation XLEImageEditViewController

- (void)dealloc
{
    
}

- (instancetype)initWithAsset:(XLEAssetModel *)asset
                       config:(XLEImageCropConfig *)config;
{
    self = [super init];
    if (self) {
        _originAsset = asset;
        _editAsset = [asset copy];
        _config = config;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.originalNaviBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    if (self.config.cropAspectRatio != 0) {
        _cropView.cropAspectRatio = self.config.cropAspectRatio;
    }
    if (!CGRectEqualToRect(self.config.cropRect, CGRectZero)) {
        _cropView.cropRect = self.config.cropRect;
    }
    _cropView.keepingCropAspectRatio = self.config.keepingCropAspectRatio;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.originalNaviBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.originalNaviBarHidden = self.navigationController.navigationBarHidden;
    self.view.clipsToBounds = YES;

    [self.view addSubview:self.cropView];
    
    [self.view addSubview:self.toolView];
    __weak XLEImageEditViewController *weakSelf = self;
    self.toolView.editAction = ^(XLEImageEditToolView *toolView, NSString *action){
        if ([action isEqualToString:XLE_IMAGE_EDIT_ACTION_USED]) {
            if (weakSelf.config) {
                [weakSelf.editAsset updateCropImage:weakSelf.cropView.croppedImage cropRect:weakSelf.cropView.zoomedCropRect];
            }
            if (weakSelf.finishCallback) {
                weakSelf.finishCallback(weakSelf, weakSelf.editAsset, YES);
            }
        }
        else if ([action isEqualToString:XLE_IMAGE_EDIT_ACTION_RESELECT])
        {
            if (weakSelf.finishCallback) {
                weakSelf.finishCallback(weakSelf, weakSelf.editAsset, NO);
            }
        }
        else if ([action isEqualToString:XLE_IMAGE_EDIT_ACTION_ROTATE])
        {
            weakSelf.cropView.rotationAngle += M_PI_2;
        }
    };
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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - set get

- (XLEImageEditToolView *)toolView{
    if (_toolView == nil) {
        _toolView = [[XLEImageEditToolView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - XLE_IMAGE_EDIT_TOOL_HEIGHT, [UIScreen mainScreen].bounds.size.width, XLE_IMAGE_EDIT_TOOL_HEIGHT)];
    }
    return _toolView;
}

- (XLECropView *)cropView
{
    if (_cropView == nil) {
        _cropView = [[XLECropView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - XLE_IMAGE_EDIT_TOOL_HEIGHT) image:self.editAsset.originalImage];
        _cropView.backgroundColor = [UIColor blackColor];
        _cropView.rotationGestureRecognizer.enabled = self.config.rotationEnabled;

    }
    return _cropView;
}

@end
