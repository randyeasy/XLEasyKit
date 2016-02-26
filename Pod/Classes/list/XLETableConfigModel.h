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
@property (assign, nonatomic) BOOL hasMore;
@property (assign, nonatomic) BOOL hasPull;
@property (assign, nonatomic) BOOL hasRemove;

@property (copy, nonatomic) NSString *nodataTip;

@property (strong, nonatomic) Class blankClass;
@property (strong, nonatomic) Class errorClass;
@property (strong, nonatomic) Class cellClass;

@property (assign, nonatomic) UITableViewStyle tableViewStyle;

@end
