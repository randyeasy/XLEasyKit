//
//  XLEKeyBoardCollectionView.m
//  Pods
//
//  Created by Randy on 15/6/23.
//  Copyright (c) 2015年 Randy All rights reserved.
//

#import "XLEKeyBoardCollectionView.h"
#import "XLEKeyBoardHelper.h"
@interface XLEKeyBoardCollectionView ()
@property (strong, nonatomic) XLEKeyBoardHelper *keyBoard;
@end

@implementation XLEKeyBoardCollectionView

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (XLEKeyBoardHelper *)keyBoard
{
    if (!_keyBoard) {
        _keyBoard = [[XLEKeyBoardHelper alloc] initWithScrollView:self];
    }
    return _keyBoard;
}

@end
