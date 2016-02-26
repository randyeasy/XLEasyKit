//
//  BJKeyboardScrollView.m
//  BJEducation
//
//  Created by Randy on 14-10-8.
//  Copyright (c) 2014年 Randy All rights reserved.
//

#import "XLEKeyboardScrollView.h"
#import "XLEKeyBoardHelper.h"

@interface XLEKeyboardScrollView ()
@property (strong, nonatomic) XLEKeyBoardHelper *keyBoard;

@end

@implementation XLEKeyboardScrollView

- (void)dealloc
{
    [self.keyBoard removeKeyBoardObserver];
}

- (void)awakeFromNib
{
    [self.keyBoard addKeyBoardObserver];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview) {
        [self.keyBoard addKeyBoardObserver];
    }
    else
        [self.keyBoard removeKeyBoardObserver];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}

- (XLEKeyBoardHelper *)keyBoard
{
    if (!_keyBoard) {
        _keyBoard = [[XLEKeyBoardHelper alloc] initWithScrollView:self];

    }
    return _keyBoard;
}

@end
