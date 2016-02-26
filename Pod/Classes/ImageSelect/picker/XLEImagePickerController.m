//
//  XLEImagePickerController.m
//  Pods
//
//  Created by Randy on 16/1/21.
//
//

#import "XLEImagePickerController.h"
#import "XLEAlbumViewController.h"
#import "XLEAssetsViewController.h"
#import "UIImage+XLEUitls.h"
#import "XLEApperance.h"
#import "UIColor+XLEUtil.h"

@interface XLEImagePickerController ()

@end

@implementation XLEImagePickerController

- (void)dealloc
{
    
}

- (instancetype)initWithPickerDelegate:(id<XLEImagePickerDelegate>)pickerDelegate config:(XLEImagePickerConfig *)config;
{
    self = [super init];
    if (self) {
        _config = config;
        
        _pickerDelegate = pickerDelegate;
        CGSize size = [UIScreen mainScreen].bounds.size;
        size.height = 64;
        [self.navigationBar setTranslucent:YES];
        [self.navigationBar setBackgroundImage:[UIImage xle_imageWithColor:[UIColor xle_colorWithHexString:@"#2C272B"] size:size] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XLEAlbumViewController *albumVC = [[XLEAlbumViewController alloc] initWithConfig:self.config];
    XLEAssetsViewController *assetsVC = [[XLEAssetsViewController alloc] initWithAssetGroup:nil config:self.config];
    albumVC.pickerDelegate = self.pickerDelegate;
    assetsVC.pickerDelegate = self.pickerDelegate;
    self.viewControllers = @[albumVC, assetsVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
