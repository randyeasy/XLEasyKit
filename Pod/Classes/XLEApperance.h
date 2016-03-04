//
//  XLEApperance.h
//  Pods
//
//  Created by Randy on 16/2/3.
//
//

#import <Foundation/Foundation.h>

#define XLEApperanceInstance [XLEApperance sharedInstance]

//颜色
#define XLE_TINT_COLOR              [XLEApperance sharedInstance].tintColor
#define XLE_BG_COLOR                [XLEApperance sharedInstance].bgColor
#define XLE_TINT_LIGHT_COLOR        [XLEApperance sharedInstance].lightTintColor
#define XLE_TINT_HEAVY_COLOR        [XLEApperance sharedInstance].heavyTintColor
#define XLE_TINT_DARK_COLOR         [XLEApperance sharedInstance].darkTintColor
#define XLE_TEXT_DARK_COLOR         [XLEApperance sharedInstance].darkTextColor
#define XLE_TEXT_HEAVY_COLOR        [XLEApperance sharedInstance].heavyTextColor
#define XLE_TEXT_LIGHT_COLOR        [XLEApperance sharedInstance].lightTextColor

#define XLE_LINE_HEAVY_COLOR        [XLEApperance sharedInstance].heavyLineColor
#define XLE_LINE_LIGHT_COLOR        [XLEApperance sharedInstance].lightLineColor

#define XLE_FONT(fontSize)          [UIFont systemFontOfSize:fontSize]
#define XLE_FONT_BOLD(fontSize)     [UIFont boldSystemFontOfSize:fontSize]

//字体
#define XLE_VERY_LARGE_FONT         [XLEApperance sharedInstance].veryLargeFont
#define XLE_LARGE_FONT              [XLEApperance sharedInstance].largeFont
#define XLE_MIDDLE_FONT             [XLEApperance sharedInstance].middleFont
#define XLE_SMALL_FONT              [XLEApperance sharedInstance].smallFont
#define XLE_VERY_SMALL_FONT         [XLEApperance sharedInstance].verySmallFont

//粗字体
#define XLE_VERY_LARGE_BOLD_FONT    [XLEApperance sharedInstance].veryLargeBoldFont
#define XLE_LARGE_BOLD_FONT         [XLEApperance sharedInstance].largeBoldFont
#define XLE_MIDDLE_BOLD_FONT        [XLEApperance sharedInstance].middleBoldFont
#define XLE_SMALL_BOLD_FONT         [XLEApperance sharedInstance].smallBoldFont
#define XLE_VERY_SMALL_BOLD_FONT    [XLEApperance sharedInstance].verySmallBoldFont

//border
#define XLE_BORDER_WIDTH [XLEApperance sharedInstance].borderWidth
#define XLE_EDIT_BORDER_WIDTH [XLEApperance sharedInstance].editBoxBorderWidth
#define XLE_BUTTON_BORDER_WIDTH [XLEApperance sharedInstance].buttonBorderWidth

//line
#define XLE_LINE_HEIGHT [XLEApperance sharedInstance].lineHeight
#define XLE_TABLEVIEW_LINE_HEIGHT [XLEApperance sharedInstance].tableViewLineHeight

//corner radius
#define XLE_CORNER_RADIUS [XLEApperance sharedInstance].cornerRadius
#define XLE_EDIT_CORNER_RADIUS [XLEApperance sharedInstance].editBoxCornerRadius
#define XLE_BUTTON_CORNER_RADIUS [XLEApperance sharedInstance].buttonCornerRadius

//padding margin
#define XLE_LR_RADDING [XLEApperance sharedInstance].lrPadding
#define XLE_TB_RADDING [XLEApperance sharedInstance].tbPadding

NS_ASSUME_NONNULL_BEGIN

@interface XLEApperance : NSObject
@property (strong, nonatomic) UIColor *bgColor;

@property (strong, nonatomic) UIColor *tintColor;
@property (strong, nonatomic) UIColor *lightTintColor;
@property (strong, nonatomic) UIColor *heavyTintColor;
@property (strong, nonatomic) UIColor *darkTintColor;

@property (strong, nonatomic) UIColor *darkTextColor;
@property (strong, nonatomic) UIColor *heavyTextColor;
@property (strong, nonatomic) UIColor *lightTextColor;

@property (strong, nonatomic) UIColor *heavyLineColor;
@property (strong, nonatomic) UIColor *lightLineColor;

@property (strong, nonatomic) UIFont *veryLargeFont;
@property (strong, nonatomic) UIFont *largeFont;
@property (strong, nonatomic) UIFont *middleFont;
@property (strong, nonatomic) UIFont *smallFont;
@property (strong, nonatomic) UIFont *verySmallFont;

@property (strong, nonatomic) UIFont *veryLargeBoldFont;
@property (strong, nonatomic) UIFont *largeBoldFont;
@property (strong, nonatomic) UIFont *middleBoldFont;
@property (strong, nonatomic) UIFont *smallBoldFont;
@property (strong, nonatomic) UIFont *verySmallBoldFont;

//naviBar
@property (strong, nonatomic) UIImage *naviBarBackImage;//导航栏的返回按钮
@property (strong, nonatomic) UIColor *naviBarBGColor;
@property (copy, nonatomic) NSDictionary<NSString *,id> *naviTitleAttributes;//默认粗体18 白色
@property (copy, nonatomic) NSDictionary<NSString *,id> *naviRightTitleAttributes;
@property (copy, nonatomic) NSDictionary<NSString *,id> *naviRightTitlePressAttributes;//高亮
@property (copy, nonatomic) NSDictionary<NSString *,id> *naviLeftTitleAttributes;
@property (copy, nonatomic) NSDictionary<NSString *,id> *naviLeftTitlePressAttributes;//高亮

@property (strong, nonatomic) UIFont *buttonTextFont; //默认15 粗体

//tip loading error
@property (assign, nonatomic) CGFloat tipMinTime; //默认2秒
@property (strong, nonatomic) UIColor *tipBGColor;
@property (strong, nonatomic) UIFont *tipFont;
@property (strong, nonatomic) UIColor *tipColor;
@property (strong, nullable, nonatomic) UIImage *tipSucImage;
@property (strong, nullable, nonatomic) UIImage *tipErrorImage;

@property (strong, nonatomic) UIColor *loadingBGColor;
@property (strong, nonatomic) UIFont *loadingFont;
@property (strong, nonatomic) UIColor *loadingColor;
@property (copy, nullable, nonatomic) NSString *loadingImagePath;

//TableView
@property (strong, nonatomic) UIColor *separateColor;//
@property (assign, nonatomic) CGFloat separatorLeftMargin;//15
@property (assign, nonatomic) CGFloat separateLineHeight;//0.5 暂不生效
@property (assign, nonatomic) CGFloat rowHeight; // 44

//border
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) CGFloat editBoxBorderWidth;
@property (assign, nonatomic) CGFloat buttonBorderWidth;

//corner radius
@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat editBoxCornerRadius;
@property (assign, nonatomic) CGFloat buttonCornerRadius;

//padding margin
@property (assign, nonatomic) CGFloat lrPadding;//左右间距
@property (assign, nonatomic) CGFloat tbPadding;//上下间距
@property (assign, nonatomic) CGFloat leftAndRightMargin;

//line
@property (assign, nonatomic) CGFloat lineHeight;
@property (assign, nonatomic) CGFloat tableViewLineHeight;

//statusbar
@property (assign, nonatomic) UIStatusBarStyle statusStyle;

//list
@property (strong, nullable, nonatomic) UIImage *listNodateImage;//无数据的图片
@property (strong, nullable, nonatomic) UIImage *listErrorImage;//错误的图片

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
