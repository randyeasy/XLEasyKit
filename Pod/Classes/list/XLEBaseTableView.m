//
//  TXBaseTableView.m
//  Pods
//
//  Created by Randy on 15/12/19.
//
//

#import "XLEBaseTableView.h"
#import <MJRefresh/MJRefresh.h>
#import "XLEMJRefreshFactory.h"

@interface XLEBaseTableView ()
@property (strong, nonatomic) UIView *blankView;
@property (strong, nonatomic) UIView *errorView;

@end

@implementation XLEBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.rowHeight = XLEApperanceInstance.rowHeight;
        self.separatorInset = UIEdgeInsetsMake(0, XLEApperanceInstance.separatorLeftMargin, 0, 0);
        self.separatorColor = XLEApperanceInstance.separateColor;
    }
    return self;
}

- (void)setDelegate:(id<XLEBaseTableViewDelegate>)delegate;
{
    [super setDelegate:delegate];
}

#pragma mark - public
- (void)noticeErrorChange;
{
    [self analyseShowErrorView];
}


//- (id<XLEBaseTableViewDelegate>)delegate;
//{
//    return (id<XLEBaseTableViewDelegate>)[super delegate];
//}
//
//- (id<TXBaseTableViewDataSource>)dataSource;{
//    return (id<TXBaseTableViewDataSource>)[super dataSource];
//}

- (void)startRefresh
{
    XLEWS(weakSelf);
    if (self.mj_header) {
        [self.mj_header beginRefreshing];
    }
    else{
        if ([(id<XLEBaseTableViewDelegate>)self.delegate respondsToSelector:@selector(tableView:refresh:)]) {
            [(id<XLEBaseTableViewDelegate>)self.delegate tableView:self refresh:^(BOOL isSuc) {
                [weakSelf refreshFinishHandle:isSuc];
            }];
        }
    }
}

#pragma mark - private
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

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
}

- (CGFloat)analyseHeightOutLastSection
{
    CGFloat height = 0;
    NSInteger sections = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [self.dataSource numberOfSectionsInTableView:self];
    }
    
    for (int i=0; i<(sections-1); i++) {
        NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:i];
        
        if (![self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            height+= self.rowHeight*rows;
        }
        else
        {
            for (int j=0; j<rows; j++) {
                height += [self.delegate tableView:self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            }
        }

        if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
            height += [self.delegate tableView:self heightForFooterInSection:i];
        }
        
        if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            height += [self.delegate tableView:self heightForHeaderInSection:i];
        }
    }
    if (sections>1) {
        height += [self.delegate tableView:self heightForHeaderInSection:sections-1];
    }
    return height;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.blankView) {
        CGFloat y = [self analyseHeightOutLastSection]/*TODOself.contentInset.top*/;
        self.blankView.frame = CGRectMake(self.contentInset.right, y, self.bounds.size.width - self.contentInset.right - self.contentInset.left, self.bounds.size.height - y - self.contentInset.bottom);
    }
    
    if (self.errorView) {
        CGFloat y = [self analyseHeightOutLastSection]+self.contentInset.top;
        self.errorView.frame = CGRectMake(self.contentInset.right, y, self.bounds.size.width - self.contentInset.right - self.contentInset.left, self.bounds.size.height - y - self.contentInset.bottom);
    }
}

- (void)showBlankView:(UIView *)blankView
{
    if (blankView != self.blankView) {
        [self removeBlankView];
        self.blankView = blankView;
        if (blankView) {
            CGFloat y = [self analyseHeightOutLastSection]+self.contentInset.top;
            blankView.frame = CGRectMake(self.contentInset.right, y, self.bounds.size.width - self.contentInset.right - self.contentInset.left, self.bounds.size.height - y - self.contentInset.bottom);
            [self addSubview:blankView];
        }
    }
}

- (void)analyseShowBlankView
{
    if ([self analyseNeedShowError]) {
        [self removeBlankView];
        return;
    }
    NSInteger sectionNumber = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sectionNumber = [self.dataSource numberOfSectionsInTableView:self];
    }
    NSInteger section = sectionNumber - 1;
    if ((section < 0 ||
        [self.dataSource tableView:self numberOfRowsInSection:section]==0) &&
        [self.delegate respondsToSelector:@selector(viewForBlankInTableView:)])
    {
        UIView *blankView = nil;
        blankView = [(id<XLEBaseTableViewDelegate>)self.delegate viewForBlankInTableView:self];
        [self showBlankView:blankView];
    }
    else
    {
        [self removeBlankView];
    }
}

- (void)showErrorView:(UIView *)errorView
{
    [self removeBlankView];
    if (errorView != self.errorView) {
        [self removeErrorView];
        self.errorView = errorView;
        //TODO 位置
        if (errorView) {
            CGFloat y = [self analyseHeightOutLastSection]+self.contentInset.top;
            errorView.frame = CGRectMake(self.contentInset.right, y, self.bounds.size.width - self.contentInset.right - self.contentInset.left, self.bounds.size.height - y - self.contentInset.bottom);
            [self addSubview:errorView];
        }
    }
}

- (BOOL)analyseNeedShowError
{
    NSInteger sectionNumber = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sectionNumber = [self.dataSource numberOfSectionsInTableView:self];
    }
    NSInteger section = sectionNumber - 1;
    if ((section < 0 ||
         [self.dataSource tableView:self numberOfRowsInSection:section]==0) &&
        [self.delegate respondsToSelector:@selector(viewForErrorInTableView:)]) {
        UIView *errorView = nil;
        errorView = [(id<XLEBaseTableViewDelegate>)self.delegate  viewForErrorInTableView:self];
        if (errorView) {
            return YES;
        }
    }
    return NO;
}

- (void)analyseShowErrorView
{
    NSInteger sectionNumber = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sectionNumber = [self.dataSource numberOfSectionsInTableView:self];
    }
    NSInteger section = sectionNumber - 1;
    if ((section < 0 ||
         [self.dataSource tableView:self numberOfRowsInSection:section]==0) &&
        [self.delegate respondsToSelector:@selector(viewForErrorInTableView:)]) {
        UIView *errorView = nil;
        errorView = [(id<XLEBaseTableViewDelegate>)self.delegate  viewForErrorInTableView:self];
        [self showErrorView:errorView];
    }
    else
    {
        [self removeErrorView];
    }
}

#pragma mark -override UITableView method
- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
{
    [super insertSections:sections withRowAnimation:animation];
    [self analyseShowBlankView];
}

- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
{
    [super deleteSections:sections withRowAnimation:animation];
    [self analyseShowBlankView];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [super reloadSections:sections withRowAnimation:animation];
    [self analyseShowBlankView];
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
{
    if (animation == UITableViewRowAnimationNone) {
        [UIView setAnimationsEnabled:NO];
    }
    [super insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    if (animation == UITableViewRowAnimationNone) {
        [UIView setAnimationsEnabled:YES];
    }

    [self analyseShowBlankView];
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
{
    [super deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self analyseShowBlankView];
}

- (void)updateFooterHidden
{
    if ([self.delegate respondsToSelector:@selector(hasMoreDataInTableView:)]) {
        if ([(id<XLEBaseTableViewDelegate>)self.delegate hasMoreDataInTableView:self]) {
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

- (void)refreshFinishHandle:(BOOL)refreshSuc
{
    XLEWS(weakSelf);

    [weakSelf.mj_header endRefreshing];
    
    if (![(id<XLEBaseTableViewDelegate>)self.delegate hasRefreshInTableView:self]) {
        weakSelf.mj_header = nil;
    }
    
    [weakSelf updateFooterHidden];
    
    if (refreshSuc) {
        [weakSelf removeErrorView];
        [weakSelf analyseShowBlankView];
        [super reloadData];
    }
    else
    {
        [weakSelf removeBlankView];
        [weakSelf analyseShowErrorView];
    }
}

- (BOOL)setupFooter
{
    BOOL hasMore = NO;
    XLEWS(weakSelf);

    if ([self.delegate respondsToSelector:@selector(hasMoreViewInTableView:)] && [(id<XLEBaseTableViewDelegate>)self.delegate hasMoreViewInTableView:self]) {
        hasMore = YES;
        if (!self.mj_footer) {
            self.mj_footer = [XLEMJRefreshFactory createFooterWithBlock:^{
                if ([weakSelf.delegate respondsToSelector:@selector(tableView:getMore:)]) {
                    [(id<XLEBaseTableViewDelegate>)weakSelf.delegate tableView:weakSelf getMore:^(BOOL isSuc) {
                        [weakSelf.mj_footer endRefreshing];
                        [weakSelf updateFooterHidden];
                        if (isSuc) {
                            [super reloadData];
                        }
                    }];
                }
                else
                {
                    [weakSelf.mj_footer endRefreshing];
                }
            }];
            self.mj_footer.automaticallyHidden = YES;
        }
    }
    else
        self.mj_footer = nil;
    return hasMore;
}

- (BOOL)setupRefresh
{
    XLEWS(weakSelf);
    
    BOOL hasMore = ([self.delegate respondsToSelector:@selector(hasMoreViewInTableView:)] && [(id<XLEBaseTableViewDelegate>)self.delegate hasMoreViewInTableView:self]);

    if ([self.delegate respondsToSelector:@selector(hasRefreshInTableView:)] && [(id<XLEBaseTableViewDelegate>)self.delegate hasRefreshInTableView:self]) {
        self.mj_header = [XLEMJRefreshFactory createHeaderWithBlock:^{
            if (hasMore) {
                if ([weakSelf.mj_footer isRefreshing]) {
                    [weakSelf.mj_footer endRefreshing];
                }
            }
            
            if ([weakSelf.delegate respondsToSelector:@selector(tableView:refresh:)]) {
                [(id<XLEBaseTableViewDelegate>)weakSelf.delegate tableView:weakSelf refresh:^(BOOL isSuc) {
                    [weakSelf refreshFinishHandle:isSuc];
                }];
            }
            else
            {
                [weakSelf.mj_header endRefreshing];
            }
        }];
        return YES;
    }
    else
    {
        self.mj_header = nil;
        return NO;
    }
}

- (void)reloadData{
    
    if ([self setupFooter]) {
        [self updateFooterHidden];
    }
    
    [self setupRefresh];
    ///必须放到后面，MJRefresh框架依赖于上面的是否显示有做处理，所以先判断header和footer是否显示再刷新
    [super reloadData];
    [self analyseShowBlankView];
    [self analyseShowErrorView];
}

@end
