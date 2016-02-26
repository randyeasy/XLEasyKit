//
//  XLEAliyunImageEngine.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLEAliyunImageEngine.h"

@implementation XLEAliyunImageEngine

- (NSString *)imageLoadParamWithCut:(BOOL)needCut size:(CGSize)size;
{
    NSInteger w = (NSInteger)size.width;
    NSInteger h = (NSInteger)size.height;
    NSString *param = [NSString stringWithFormat:@"@%ldw_%ldh_1o", (long)w, (long)h];
    
    NSInteger scale = (NSInteger)[UIScreen mainScreen].scale;
    if (scale > 1){
        param = [param stringByAppendingFormat:@"_%ldx", (long)scale];
    }
    if (needCut){
        //改为短边优先进行裁剪
        param = [param stringByAppendingFormat:@"_1e_1c"];
    }
    return param;
}

@end
