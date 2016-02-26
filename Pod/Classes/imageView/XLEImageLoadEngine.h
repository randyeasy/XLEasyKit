//
//  XLEImageLoadEngine.h
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import <Foundation/Foundation.h>

@protocol XLEImageLoadEngine <NSObject>
@required
- (NSString *)imageLoadParamWithCut:(BOOL)needCut size:(CGSize)size;

@end
