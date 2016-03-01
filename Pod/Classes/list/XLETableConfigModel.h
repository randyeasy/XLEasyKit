//
//  XLEListConfigModel.h
//  Pods
//
//  Created by Randy on 15/12/7.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface XLETableConfigModel : NSObject
@property (assign, nonatomic) BOOL hasMore; //默认：NO
@property (assign, nonatomic) BOOL hasPull; //默认：YES
@property (assign, nonatomic) BOOL hasRemove; //默认：NO

@property (strong, nonatomic) Class blankClass; //默认：XLEBlankView
@property (strong, nonatomic) Class errorClass; //默认：XLEErrorView

@property (assign, nonatomic) UITableViewStyle tableViewStyle; //默认：UITableViewStylePlain

@end
