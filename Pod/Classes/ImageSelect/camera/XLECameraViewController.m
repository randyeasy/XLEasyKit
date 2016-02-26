//
//  XLECameraViewController.m
//  Pods
//
//  Created by Randy on 16/2/2.
//
//

#import "XLECameraViewController.h"
#import <LLSimpleCamera/LLSimpleCamera.h>
#import <AVFoundation/AVFoundation.h>

#import "UIAlertView+XLEBlock.h"
#import "XLEAssetModel.h"
#import "XLEImagePickerConfig.h"
#import "XLECameraHeaderView.h"
#import "XLECameraToolView.h"

#import "XLECameraConfig.h"

static CGFloat XLE_TOOL_HEIGHT = 64;
static CGFloat XLE_NAVI_HEIGHT = 44;

@interface XLECameraViewController ()
@property (strong, nonatomic) LLSimpleCamera *camera;
@property (strong, nonatomic) XLECameraHeaderView *headerView;
@property (strong, nonatomic) XLECameraToolView *toolView;
@property (strong, nonatomic) XLECameraConfig *config;

@property (copy, nonatomic) void(^cameraFinish)(XLECameraViewController *cameraVC, BOOL isSuc, XLEAssetModel *_Nullable asset);

@end

@implementation XLECameraViewController

- (void)dealloc
{
    [_camera stop];
}

/**
 *  初始化方法
 *
 *  @param config 可为空，为空时为默认值
 *
 *  @return
 */
- (instancetype)initWithConfig:(nullable XLECameraConfig *)config;
{
    self = [super init];
    if (self) {
        _config = config;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.camera start];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.camera stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    __weak XLECameraViewController *weakSelf = self;

    // Do any additional setup after loading the view.
    //是否有权限 是否支持摄像头
    self.camera.onError = ^(LLSimpleCamera *camera, NSError *error){
        if (error.code == LLSimpleCameraErrorCodeCameraPermission) {
            UIAlertView *show = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请去隐私设置打开应用的\"相机\"访问权限" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [show xle_showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
                        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication] canOpenURL:appSettings]) {
                            [[UIApplication sharedApplication] openURL:appSettings];
                        }
                    }
                }
                else
                {
                    [weakSelf dismissWithAnimated:YES completion:nil];
                }
            }];
        }
    };
    
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, XLE_NAVI_HEIGHT);
    self.toolView.frame = CGRectMake(0, self.view.frame.size.height - XLE_TOOL_HEIGHT, self.view.frame.size.width, XLE_TOOL_HEIGHT);
    [self.camera attachToViewController:self withFrame:CGRectMake(0, XLE_NAVI_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - XLE_TOOL_HEIGHT - XLE_NAVI_HEIGHT)];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.toolView];
    
    [self.toolView.takeButton addTarget:self action:@selector(takeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView.frontButton addTarget:self action:@selector(frontAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.headerView.flashCallback = ^(XLECameraFlash flash){
        weakSelf.config.flash = flash;
        [weakSelf.camera updateFlashMode:(LLCameraFlash)weakSelf.config.flash];
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

#pragma mark - public
/**
 *  使用UINavigationController显示当前视图
 *
 *  @param vc
 *  @param cameraFinish 回调
 */
- (void)showWithParentVC:(UIViewController *)vc cameraFinish:(void(^)(XLECameraViewController *cameraVC, BOOL isSuc, XLEAssetModel *_Nullable asset))cameraFinish;
{
    self.cameraFinish = cameraFinish;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self];
    [navi setNavigationBarHidden:YES animated:NO];
    [vc presentViewController:navi animated:YES completion:nil];
}

/**
 *  remove 当前视图
 *
 *  @param animated   动画
 *  @param completion remove完成后的回调
 */
- (void)dismissWithAnimated:(BOOL)animated completion:(void (^)(void))completion;
{
    [self.navigationController dismissViewControllerAnimated:animated completion:completion];
}

#pragma mark - action

- (void)frontAction
{
    [self.camera togglePosition];
    self.config.front = (self.camera.position == LLCameraPositionFront);
}

- (void)takeAction
{
    __weak XLECameraViewController *weakSelf = self;
    [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        if (!error) {
            if (weakSelf.cameraFinish) {
                XLEAssetModel *assetModel = [[XLEAssetModel alloc] initWithCameraInfo:metadata image:image assetType:XLE_IMAGEPICKER_ASSET_PHOTO];
                weakSelf.cameraFinish(weakSelf, YES, assetModel);
            }
        }
    } exactSeenImage:YES];
}

- (void)cancelAction
{
    if (self.cameraFinish) {
        self.cameraFinish(self, NO, nil);
    }
}

#pragma mark - set get
- (LLSimpleCamera *)camera{
    if (_camera == nil) {
        _camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh position:self.config.isFront?LLCameraPositionFront:LLCameraPositionRear videoEnabled:NO];
        [self.camera updateFlashMode:(LLCameraFlash)self.config.flash];
    }
    return _camera;
}

- (XLECameraToolView *)toolView{
    if (_toolView == nil) {
        _toolView = [[XLECameraToolView alloc] init];
    }
    return _toolView;
}

- (XLECameraConfig *)config{
    if (_config == nil) {
        _config = [[XLECameraConfig alloc] init];
    }
    return _config;
}

- (XLECameraHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[XLECameraHeaderView alloc] initWithFlash:self.config.flash];
    }
    return _headerView;
}

@end
