//
//  XLEImageSingleSelectBrowser.m
//  Pods
//
//  Created by Randy on 16/1/22.
//
//

#import "XLEImageSingleSelectBrowser.h"
#import "XLEBrowserView.h"
#import "XLEImageEditToolView.h"
#import "XLEAssetModel.h"

static CGFloat XLE_IMAGE_EDIT_TOOL_HEIGHT = 64;

@interface XLEImageSingleSelectBrowser ()
@property (strong, nonatomic) XLEBrowserView *browserView;
@property (strong, nonatomic) XLEImageEditToolView *toolView;

@property (assign, nonatomic) BOOL originalNaviBarHidden;

@property (strong, nonatomic) XLEAssetModel *originAsset;
@property (strong, nonatomic) XLEAssetModel *editAsset;

@end

@implementation XLEImageSingleSelectBrowser

- (void)dealloc
{
    
}

- (instancetype)initWithAsset:(XLEAssetModel *)asset;
{
    self = [super init];
    if (self) {
        _originAsset = asset;
        _editAsset = [asset copy];
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.originalNaviBarHidden = self.navigationController.navigationBarHidden;
    
    //当图片被捏合放大时，返回上一级会显示图片的左边区域
    self.view.clipsToBounds = YES;
    
    [self.view addSubview:self.browserView];
    [self.browserView updateBrowserImage:self.originAsset.cropImage?:self.originAsset.originalImage];
    
    [self.view addSubview:self.toolView];
    __weak XLEImageSingleSelectBrowser *weakSelf = self;
    self.toolView.editAction = ^(XLEImageEditToolView *toolView, NSString *action){
        if ([action isEqualToString:XLE_IMAGE_EDIT_ACTION_USED]) {
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
            //TODO 旋转
//            weakSelf.cropView.rotationAngle += M_PI_2;
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - set get
- (XLEBrowserView *)browserView{
    if (_browserView == nil) {
        _browserView = [[XLEBrowserView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - XLE_IMAGE_EDIT_TOOL_HEIGHT)];
        _browserView.srollView.clipsToBounds = NO;
    }
    return _browserView;
}

- (XLEImageEditToolView *)toolView{
    if (_toolView == nil) {
        _toolView = [[XLEImageEditToolView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - XLE_IMAGE_EDIT_TOOL_HEIGHT, [UIScreen mainScreen].bounds.size.width, XLE_IMAGE_EDIT_TOOL_HEIGHT)];
    }
    return _toolView;
}

@end
