//
//  UITabBarItem+XLECreate.m
//  Pods
//
//  Created by Randy on 14/12/18.
//

#import "UITabBarItem+XLECreate.h"

@implementation UITabBarItem (XLECreate)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    UIImage *newSelImage = selectedImage;
    if ([selectedImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
        newSelImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if ([tabBarItem respondsToSelector:@selector(initWithTitle:image:selectedImage:)]) {
        tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:newSelImage];
    }
    else if([tabBarItem respondsToSelector:@selector(setFinishedSelectedImage:withFinishedUnselectedImage:)])
    {
        tabBarItem.title = title;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        [tabBarItem setFinishedSelectedImage:newSelImage withFinishedUnselectedImage:image];
#pragma clang diagnostic pop
    }
    
    if (title.length<=0) {
        [tabBarItem setImageInsets:UIEdgeInsetsMake(4, 0, -5, 0)];
    }
    return tabBarItem;
}

@end
