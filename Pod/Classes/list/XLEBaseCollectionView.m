//
//  XLEBaseCollectionView.m
//  Pods
//
//  Created by Randy on 16/1/11.
//
//

#import "XLEBaseCollectionView.h"
#import <MJRefresh/MJRefresh.h>
#import "XLEPullRefreshApperance.h"
#import "XLEMJRefreshFactory.h"

@interface XLEBaseCollectionView ()
@property (strong, nonatomic) UIView *blankView;
@property (strong, nonatomic) UIView *errorView;
@end

@implementation XLEBaseCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setDelegate:(id<XLEBaseCollectionViewDelegate>)delegate;
{
    [super setDelegate:delegate];
}

- (void)startRefresh
{
    [self.mj_header beginRefreshing];
}

- (void)removeBlankView
{
    [self.blankView removeFromSuperview];
    self.blankView = nil;
}

- (void)removeErrorView
{
    [self.errorView removeFromSuperview];
    self.errorView = nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.blankView) {
        CGFloat y = 0 + self.contentInset.top;
        self.blankView.frame = CGRectMake(self.contentInset.right, y, self.bounds.size.width - self.contentInset.right - self.contentInset.left, self.bounds.size.height - y - self.contentInset.bottom);
    }
    
    if (self.errorView) {
        CGFloat y = 0 + self.contentInset.top;
        self.errorView.frame = CGRectMake(self.contentInset.right, y, self.bounds.size.width - self.contentInset.right - self.contentInset.left, self.bounds.size.height - y - self.contentInset.bottom);
    }
}

- (void)showBlankView:(UIView *)blankView
{
    if (blankView != self.blankView) {
        [self removeBlankView];
        self.blankView = blankView;
        if (blankView) {
            [self addSubview:blankView];
        }
    }
}

- (void)analyseShowBlankView
{
    NSInteger sectionNumber = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sectionNumber = [self.dataSource numberOfSectionsInCollectionView:self];
    }
    NSInteger section = sectionNumber - 1;
    if ((section < 0 ||
         [self.dataSource collectionView:self numberOfItemsInSection:section]==0) &&
        [self.delegate respondsToSelector:@selector(viewForBlankInCollectionView:)])
    {
        UIView *blankView = nil;
        blankView = [(id<XLEBaseCollectionViewDelegate>)self.dataSource viewForBlankInCollectionView:self];
        [self showBlankView:blankView];
    }
    else
    {
        [self removeBlankView];
    }
}

- (void)showErrorView:(UIView *)errorView
{
    if (errorView != self.errorView) {
        [self removeErrorView];
        self.errorView = errorView;
        if (errorView) {
            [self addSubview:errorView];
        }
    }
}

- (void)analyseShowErrorView
{
    if ([self.delegate respondsToSelector:@selector(viewForErrorInCollectionView:)]) {
        UIView *errorView = nil;
        errorView = [(id<XLEBaseCollectionViewDelegate>)self.delegate viewForErrorInCollectionView:self];
        [self showErrorView:errorView];
    }
    else
    {
        [self removeErrorView];
    }
}

- (void)insertSections:(NSIndexSet *)sections;
{
    [super insertSections:sections];
    [self analyseShowBlankView];
}

- (void)deleteSections:(NSIndexSet *)sections;
{
    [super deleteSections:sections];
    [self analyseShowBlankView];
}

- (void)reloadSections:(NSIndexSet *)sections;
{
    [super reloadSections:sections];
    [self analyseShowBlankView];
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
{
    [super insertItemsAtIndexPaths:indexPaths];
    [self analyseShowBlankView];
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
{
    [super deleteItemsAtIndexPaths:indexPaths];
    [self analyseShowBlankView];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
{
    [super reloadItemsAtIndexPaths:indexPaths];
    [self analyseShowBlankView];
}

- (void)updateFooterHidden
{
    if ([self.delegate respondsToSelector:@selector(hasMoreInCollectionView:)]) {
        if ([(id<XLEBaseCollectionViewDelegate>)self.delegate hasMoreInCollectionView:self]) {
            if (self.mj_footer.state == MJRefreshStateNoMoreData) {
                [self.mj_footer resetNoMoreData];
            }
        }
        else
        {
            if (self.mj_footer.state != MJRefreshStateNoMoreData) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }
}

- (void)reloadData{
    XLEWS(weakSelf);
    BOOL hasMore = NO;
    
    if ([self.delegate respondsToSelector:@selector(hasMoreInCollectionView:)]) {
        hasMore = YES;
        if (!self.mj_footer) {
            self.mj_footer = [XLEMJRefreshFactory createFooterWithBlock:^{
                if ([weakSelf.delegate respondsToSelector:@selector(collectionView:getMore:)]) {
                    [(id<XLEBaseCollectionViewDelegate>)weakSelf.delegate collectionView:weakSelf getMore:^() {
                        [weakSelf.mj_footer endRefreshing];
                        [weakSelf updateFooterHidden];
                    }];
                }
                else
                    [weakSelf.mj_footer endRefreshing];
            }];
        }
        [self updateFooterHidden];
    }
    
    if ([self.delegate respondsToSelector:@selector(hasRefreshInCollectionView:)]) {
        if ([(id<XLEBaseCollectionViewDelegate>)self.delegate hasRefreshInCollectionView:self]) {
            self.mj_header = [XLEMJRefreshFactory createHeaderWithBlock:^{
                if (hasMore) {
                    if ([weakSelf.mj_footer isRefreshing]) {
                        [weakSelf.mj_footer endRefreshing];
                    }
                }
                
                if ([weakSelf.delegate respondsToSelector:@selector(collectionView:refresh:)]) {
                    [(id<XLEBaseCollectionViewDelegate>)weakSelf.delegate collectionView:weakSelf refresh:^(BOOL isSuc) {
                        [weakSelf.mj_header endRefreshing];
                        
                        [weakSelf updateFooterHidden];
                        
                        if (![(id<XLEBaseCollectionViewDelegate>)self.delegate hasRefreshInCollectionView:weakSelf]) {
                            weakSelf.mj_header = nil;
                        }
                        
                        if (isSuc) {
                            [weakSelf removeErrorView];
                            [weakSelf analyseShowBlankView];
                        }
                        else
                        {
                            [weakSelf removeBlankView];
                            [weakSelf analyseShowErrorView];
                        }
                    }];
                }
                else
                {
                    [weakSelf.mj_header endRefreshing];
                }
            }];
        }
        else{
            self.mj_header = nil;
        }
    }
    ///必须放到后面，MJRefresh框架依赖于上面的是否显示有做处理，所以先判断header和footer是否显示再刷新
    [super reloadData];
    [self analyseShowBlankView];
}

@end
