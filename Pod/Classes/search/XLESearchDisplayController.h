//
//  BJXLESearchDisplayController.h
//  BJEducation_Institution
//
//  Created by Randy on 15/3/31.
//  Copyright (c) 2015年 com.bjhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLESearchResultsViewController.h"
#import "XLEBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XLESearchDisplayDelegate;

@interface XLESearchDisplayController : NSObject
@property (nonatomic, weak, nullable) id<XLESearchDisplayDelegate> delegate;
@property (nonatomic, strong, readonly) UISearchBar *searchBar;

@property (nonatomic, strong) XLESearchResultsViewController *searchResultsViewController;
@property (strong, readonly, nonatomic) UITableView *searchResultsTableView;

@property (nonatomic, getter=isActive)  BOOL active;

- (instancetype)initWithSearchBar:(nullable UISearchBar *)searchBar;

- (void)setActive:(BOOL)active animated:(BOOL)animated;

@end


@protocol XLESearchDisplayDelegate <NSObject>

@optional

- (void) searchDisplayControllerWillBeginSearch:(XLESearchDisplayController *)controller;
- (void) searchDisplayControllerDidBeginSearch:(XLESearchDisplayController *)controller;
- (void) searchDisplayControllerWillEndSearch:(XLESearchDisplayController *)controller;
- (void) searchDisplayControllerDidEndSearch:(XLESearchDisplayController *)controller;

- (void) searchDisplayControllerDidCancel:(XLESearchDisplayController *)controller;
- (void) searchDisplayControllerDidSearch:(XLESearchDisplayController *)controller;

- (BOOL)searchDisplayController:(XLESearchDisplayController *)controller shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (BOOL)searchDisplayController:(XLESearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;

- (BOOL)searchDisplayController:(XLESearchDisplayController *)controller shouldReloadTableForSearchScope:(NSUInteger)selectedScope;

@end

NS_ASSUME_NONNULL_END
