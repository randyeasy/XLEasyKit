//
//  NSBundle+bjp.m
//  Pods
//
//  Created by Randy on 15/11/11.
//
//

#import "NSBundle+XLE.h"

@implementation NSBundle (XLE)

+ (NSBundle *)XLE_MainBundle
{
    NSString *path = [NSBundle pathForResource:@"XLEasyKit" ofType:@"bundle" inDirectory:[[NSBundle mainBundle] resourcePath]];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    return bundle;
}

@end
