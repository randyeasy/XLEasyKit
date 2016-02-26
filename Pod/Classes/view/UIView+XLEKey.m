//
//  UIView+xleKey.m
//  Pods
//
//  Created by Randy on 15/11/27.
//
//

#import "UIView+XLEKey.h"
#import <objc/runtime.h>

static char XLEViewObjectKey;

@implementation UIView (XLEKey)
@dynamic xle_key;

- (id)xle_key
{
    return objc_getAssociatedObject(self, &XLEViewObjectKey);
}

- (void)setBjck_key:(id)xle_key
{
    objc_setAssociatedObject(self, &XLEViewObjectKey,
                             xle_key,
                             OBJC_ASSOCIATION_RETAIN);
}

@end
