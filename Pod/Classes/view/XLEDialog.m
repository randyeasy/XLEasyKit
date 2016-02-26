//
//  XLEDialog.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLEDialog.h"
#import "UIAlertView+XLEBlock.h"

@implementation XLEDialog

+ (void)show:(NSString *)message {
    [self show:message tapBlock:nil];
}

+ (void)show:(NSString *)message tapBlock:(XLEDialogCompletionBlock)tapBlock {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView xle_showAlertViewWithCompleteBlock:tapBlock];
}

+ (void)show:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(XLEDialogCompletionBlock)tapBlock {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    for (NSString *otherButtonTitle in otherButtonTitles) {
        [alertView addButtonWithTitle:otherButtonTitle];
    }
    [alertView xle_showAlertViewWithCompleteBlock:tapBlock];
}

@end
