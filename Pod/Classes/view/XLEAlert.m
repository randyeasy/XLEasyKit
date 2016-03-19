//
//  XLEDialog.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLEAlert.h"
#import "UIAlertView+XLEBlock.h"

@implementation XLEAlert

- (void)showWithMessage:(NSString *)message
{
    [self showWithMessage:message
              cancelButtonItem:[XLEBlockItem itemWithTitle:@"确定" object:nil callback:nil]];
}

- (void)showWithTitle:(NSString *)title
              message:(NSString *)message
{
    [self showWithTitle:title
                message:message
            cancelButtonItem:[XLEBlockItem itemWithTitle:@"确定" object:nil callback:nil]];
}

- (void)showWithMessage:(NSString *)message
            cancelButtonItem:(XLEBlockItem *)cancelItem
{
    return [self showWithTitle:nil
                           message:message
                       cancelButtonItem:cancelItem];
}

- (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelButtonItem:(XLEBlockItem *)cancelItem {
    [self showWithTitle:title
                message:message
              cancelButtonItem:cancelItem
            doneButtonItem:nil];
}

- (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          cancelButtonItem:(XLEBlockItem *)cancelItem
            doneButtonItem:(XLEBlockItem *)doneItem{
    NSArray *list = nil;
    if (doneItem) {
        list = @[doneItem];
    }
    [self showWithTitle:title message:message cancelButtonItem:cancelItem otherButtonItems:list];
}

- (void)showWithTitle:(NSString *)title
              message:(NSString *)message
     cancelButtonItem:(XLEBlockItem *)cancelItem
    otherButtonItems:(NSArray *)otherItems
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelItem.title otherButtonTitles: nil];
    for (XLEBlockItem *oneItem in otherItems) {
        [alertView addButtonWithTitle:oneItem.title];
    }
    [alertView XLE_showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            if (cancelItem.handleBlock) {
                cancelItem.handleBlock(cancelItem.object);
            }
        }
        else
        {
            XLEBlockItem *blockItem = otherItems[buttonIndex - 1];
            if (blockItem.handleBlock) {
                blockItem.handleBlock(blockItem.object);
            }
        }
    }];
}

@end
