//
//  BJCKUIApperance.m
//  Pods
//
//  Created by Randy on 16/2/3.
//
//

#import "XLEApperance.h"
#import "UIColor+XLEUtil.h"
#import "UIImage+XLE.h"

@implementation XLEApperance

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _tintColor = [UIColor xle_colorWithHexString:@"#00ccff"];
        _lightTintColor = [UIColor xle_colorWithHexString:@"#00ccff"];
        
        _naviBarBackImage = [UIImage xle_imageNamed:@"xle_back"];
        
        _naviTitleAttributes = [NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], XLE_FONT_BOLD(16)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
        _naviRightTitleAttributes = [NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], XLE_FONT(15)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
        _naviRightTitlePressAttributes = [NSDictionary dictionaryWithObjects:@[[[UIColor whiteColor] colorWithAlphaComponent:0.5], XLE_FONT(15)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];

        
        _statusStyle = UIStatusBarStyleLightContent;
        
        _lineHeight = 1.0 / [UIScreen mainScreen].scale;
        _tableViewLineHeight = 1.0 / [UIScreen mainScreen].scale;

        //TODO 默认值
    }
    
    return self;
}

#pragma mark - set get


@end
