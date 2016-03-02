//
//  XLEApperance.m
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
        _bgColor = [UIColor whiteColor];
        _lightTintColor = [UIColor xle_colorWithHexString:@"#00ccff"];
        _heavyLineColor = [UIColor xle_colorWithHexString:@"#00ccff"];
        _darkTextColor = [UIColor xle_colorWithHexString:@"#00ccff"];
        
        _darkTextColor = [UIColor blackColor];
        _heavyTextColor = [UIColor darkGrayColor];
        _lightTextColor = [UIColor lightGrayColor];
        
        _heavyLineColor = [UIColor darkGrayColor];
        _lightLineColor = [UIColor lightGrayColor];
        
        _veryLargeBoldFont = XLE_FONT_BOLD(18);
        _largeBoldFont = XLE_FONT_BOLD(16);
        _middleBoldFont = XLE_FONT_BOLD(14);
        _smallBoldFont = XLE_FONT_BOLD(12);
        _verySmallBoldFont = XLE_FONT_BOLD(10);
        
        _veryLargeFont = XLE_FONT(18);
        _largeFont = XLE_FONT(16);
        _middleFont = XLE_FONT(14);
        _smallFont = XLE_FONT(12);
        _verySmallFont = XLE_FONT(10);
        
        _naviBarBackImage = [UIImage xle_imageNamed:@"xle_back"];
        _naviBarBGColor = _tintColor;
        _naviTitleAttributes = [NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], XLE_FONT_BOLD(18)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
        _naviRightTitleAttributes = [NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], XLE_FONT(15)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
        _naviRightTitlePressAttributes = [NSDictionary dictionaryWithObjects:@[[[UIColor whiteColor] colorWithAlphaComponent:0.5], XLE_FONT(15)] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
        
        _buttonTextFont = XLE_FONT_BOLD(15);

        _tipMinTime = 2.0f;
        _tipFont = _largeFont;
        _loadingFont = _largeFont;
        _tipColor = [UIColor whiteColor];
        _loadingColor = [UIColor whiteColor];
        _tipBGColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _loadingBGColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        _lrPadding = 15;
        _tbPadding = 10;
        
        _separateColor = _lightLineColor;
        _separatorLeftMargin = _lrPadding;
        _separateLineHeight = 1.0f / [UIScreen mainScreen].scale;
        _rowHeight = 44;
        
        _borderWidth = 1.0f / [UIScreen mainScreen].scale;
        _editBoxBorderWidth = 1.0f / [UIScreen mainScreen].scale;
        _buttonBorderWidth = 1.0f / [UIScreen mainScreen].scale;
        
        _cornerRadius = 4;
        _editBoxCornerRadius = 5;
        _buttonCornerRadius = 4;
        
        _lineHeight = 1.0f / [UIScreen mainScreen].scale;
        _tableViewLineHeight = 1.0f / [UIScreen mainScreen].scale;
        
        _statusStyle = UIStatusBarStyleLightContent;
    }
    
    return self;
}

#pragma mark - set get


@end
