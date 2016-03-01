//
//  BJSearchDisplayController.m
//  BJEducation_Institution
//
//  Created by Randy on 15/3/31.
//  Copyright (c) 2015年 com.bjhl. All rights reserved.
//

#import "XLESearchDisplayController.h"
#import "XLESearchResultsViewController.h"
#import "XLEBaseSearchBar.h"
#import "XLENavigationController.h"

@interface XLESearchDisplayController ()<UISearchBarDelegate>

@property (nonatomic, readwrite, strong) UISearchBar *searchBar;

@property (nonatomic, readwrite, strong) UINavigationController *navController;

@end

@implementation XLESearchDisplayController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar
{
    if (searchBar == nil) {
        searchBar = [[XLEBaseSearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        searchBar.showsCancelButton = YES;
    }
    
    self = [super init];
    if (self) {
        
        _searchBar = searchBar;
        _searchBar.delegate = self;
    }
    return self;
}

- (void)setActive:(BOOL)active {
    [self setActive:active animated:NO];
}

- (void)setActive:(BOOL)active animated:(BOOL)animated {
    if (_active != active) {
        _active = active;
        if (_active) {
            UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            self.searchBar.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44);

            self.navController.view.frame = rootViewController.view.bounds;
            [rootViewController.view addSubview:self.navController.view];
            [rootViewController.view addSubview:self.searchBar];
            
            if (animated) {
                self.navController.view.alpha = 0;
                self.searchBar.alpha = 0;
                [UIView animateKeyframesWithDuration:0.2 delay:0.0f options: UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
                    self.navController.view.alpha = 1;
                    self.searchBar.alpha = 1;
                } completion:nil];
            }

            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.searchBar becomeFirstResponder];
            });
        } else {
            if (animated) {
                [UIView animateKeyframesWithDuration:0.15 delay:0.0f options: UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
                    self.navController.view.alpha = 0;
                    self.searchBar.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.searchBar removeFromSuperview];
                    [self.navController.view removeFromSuperview];
                }];
            }
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
            [self.searchBar resignFirstResponder];
        }
    }
}

- (XLEBaseTableView *)searchResultsTableView
{
    return self.searchResultsViewController.tableView;
}

- (XLESearchResultsViewController *)searchResultsViewController {
    if (!_searchResultsViewController) {
        _searchResultsViewController = [[XLESearchResultsViewController alloc] init];
    }
    return _searchResultsViewController;
}

- (UINavigationController *)navController {
    if (!_navController) {
        _navController = [[XLENavigationController alloc] initWithRootViewController:self.searchResultsViewController];
        _navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _navController;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if ([self.delegate respondsToSelector:@selector(searchDisplayControllerWillBeginSearch:)]) {
        [self.delegate searchDisplayControllerWillBeginSearch:self];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self setActive:YES animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(searchDisplayControllerDidBeginSearch:)]) {
        [self.delegate searchDisplayControllerDidBeginSearch:self];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    if ([self.delegate respondsToSelector:@selector(searchDisplayControllerWillEndSearch:)]) {
        [self.delegate searchDisplayControllerWillEndSearch:self];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if ([self.delegate respondsToSelector:@selector(searchDisplayControllerDidEndSearch:)]) {
        [self.delegate searchDisplayControllerDidEndSearch:self];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    BOOL shouldReloadTable = YES;
    if ([self.delegate respondsToSelector:@selector(searchDisplayController:shouldReloadTableForSearchString:)]) {
        shouldReloadTable = [self.delegate searchDisplayController:self shouldReloadTableForSearchString:searchBar.text];
    }
    if (shouldReloadTable) {
        [self.searchResultsTableView reloadData];
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]){
        return YES;
    }
    
    NSString * toBeString = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    if (toBeString.length > 40) {
        return NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(searchDisplayController:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate searchDisplayController:self shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    [self setActive:NO animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(searchDisplayControllerDidSearch:)]) {
        [self.delegate searchDisplayControllerDidSearch:self];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [self setActive:NO animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(searchDisplayControllerDidCancel:)]) {
        [self.delegate searchDisplayControllerDidCancel:self];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeDidChange:(NSInteger)selectedScope {
    BOOL shouldReloadTable = YES;
    
    if ([self.delegate respondsToSelector:@selector(searchDisplayController:shouldReloadTableForSearchScope:)]) {
        shouldReloadTable = [self.delegate searchDisplayController:self shouldReloadTableForSearchScope:selectedScope];
    }
    if (shouldReloadTable) {
        [self.searchResultsTableView reloadData];
    }
}

#pragma mark - 处理键盘事件
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    endFrame = [self.searchResultsTableView.superview convertRect:endFrame fromView:nil];
    UIEdgeInsets contentInset = self.searchResultsTableView.contentInset;
    contentInset.bottom = self.searchResultsTableView.superview.bounds.size.height - endFrame.origin.y;
    
    UIEdgeInsets scrollIndicatorInsets = self.searchResultsTableView.scrollIndicatorInsets;
    scrollIndicatorInsets.bottom = self.searchResultsTableView.superview.bounds.size.height - endFrame.origin.y;
    
    [UIView animateKeyframesWithDuration:duration delay:0.0f options:(curve | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        self.searchResultsTableView.contentInset = contentInset;
        self.searchResultsTableView.scrollIndicatorInsets = scrollIndicatorInsets;
    } completion:nil];
}

@end
