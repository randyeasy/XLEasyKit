//
//  XLEBaseTableViewController.m
//  Pods
//
//  Created by Randy on 16/2/25.
//
//

#import "XLEBaseTableViewController.h"
#import "XLETableConfigModel.h"

@interface XLEBaseTableViewController ()<
    XLEBaseTableViewDelegate,
    UITableViewDataSource>
{
    XLEBaseTableView *_tableView;
}

@property (strong, nonatomic) NSMutableArray *constraints;
@property (strong, nonatomic) XLETableConfigModel *config;
@property (strong, nonatomic) NSMutableArray *mutList;
@property (assign, nonatomic) BOOL dataLoaded;

@end

@implementation XLEBaseTableViewController
@synthesize tableView = _tableView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(0, @"不能使用此初始化方法");
    }
    return self;
}

- (instancetype)initWithConfig:(XLETableConfigModel *)config;
{
    self = [super init];
    if (self) {
        _forceRefreshWhenViewAppear = NO;
        _config = config;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.constraints addObjectsFromArray:[self.tableView autoPinEdgesToSuperviewEdgesWithInsets:self.tableViewInsets]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self forceRefreshWhenViewAppear]) {
        [self.tableView startRefresh];
    }
}

#pragma mark - override method

/**
 *  override method
 *
 *  @param data      选择的item
 *  @param indexPath
 */
- (void)onTableView:(XLEBaseTableView *)tableView
       selectedItem:(id)data
          indexPath:(NSIndexPath *)indexPath;
{
    
}

/**
 *  override method
 *
 *  @param cell
 *  @param item
 */
- (void)onTableView:(XLEBaseTableView *)tableView
         updateCell:(UITableViewCell *)cell
               item:(id<NSObject>)item
          indexPath:(NSIndexPath *)indexPath;
{
    
}

/**
 *  override method
 *
 *  @return 高度
 */
- (CGFloat)onTableView:(XLEBaseTableView *)tableView
         heightForItem:(id)data
             indexPath:(NSIndexPath *)indexPath;
{
    return 44;
}

- (void)onTableView:(XLEBaseTableView *)tableView updateBlankView:(UIView *)blankView;
{
    
}

- (void)onTableView:(XLEBaseTableView *)tableView updateErrorView:(UIView *)blankView;
{
    
}

- (Class)onTableView:(UITableView *)tableView
         cellForItem:(id)data
           indexPath:(NSIndexPath *)indexPath;
{
    return nil;
}

#pragma mark XLEBaseTableViewDelegate
- (CGFloat)tableView:(XLEBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self onTableView:tableView heightForItem:[self.mutList xle_objectAtIndex:indexPath.row] indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(XLEBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self onTableView:tableView selectedItem:[self.mutList xle_objectAtIndex:indexPath.row] indexPath:indexPath];
}

- (void)tableView:(XLEBaseTableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self onTableView:tableView updateCell:cell item:[self.mutList xle_objectAtIndex:indexPath.row] indexPath:indexPath];
}

//默认no
- (void)tableView:(XLEBaseTableView *)tableView getMore:(void(^)(BOOL isSuc))callback;
{
    XLEWS(weakSelf);
    if ([self.requestDelegate respondsToSelector:@selector(requestOpeGetMore:callback:)]) {
        [self.requestDelegate requestOpeGetMore:self.pageModel callback:^(NSArray *items, XLEPageModel *pageModel, XLEError *error) {
            if (!error) {
                weakSelf.pageModel = pageModel;
                [weakSelf.mutList addObjectsFromArray:items];
            }
            if (callback) {
                callback(!error);
            }
        }];
    }
}

//默认no
- (void)tableView:(XLEBaseTableView *)tableView refresh:(void(^)(BOOL isSuc))callback;
{
    XLEWS(weakSelf);
    if ([self.requestDelegate respondsToSelector:@selector(requestOpeRefresh:)]) {
        [self.requestDelegate requestOpeRefresh:^(NSArray *items, XLEPageModel *pageModel, XLEError *error) {
            weakSelf.dataLoaded = YES;
            if (!error) {
                weakSelf.pageModel = pageModel;
                [weakSelf.mutList removeAllObjects];
                [weakSelf.mutList addObject:items];
            }
            if (callback) {
                callback(!error);
            }
        }];
    }
}

//默认no
- (BOOL)hasMoreInTableView:(XLEBaseTableView *)tableView;
{
    return self.config.hasMore && self.pageModel.hasMore;
}
//默认no
- (BOOL)hasRefreshInTableView:(XLEBaseTableView *)tableView;
{
    return self.config.hasPull;
}
//默认不显示 目前只支持最后一个section。
- (UIView *)viewForBlankInTableView:(XLEBaseTableView *)tableView;
{
    if (self.dataLoaded) {
        UIView *blankView = [[self.config.blankClass alloc] init];
        [self onTableView:tableView updateBlankView:blankView];
        return blankView;
    }
    return nil;
}

//默认不显示 目前只支持最后一个section。
- (UIView *)viewForErrorInTableView:(XLEBaseTableView *)tableView;
{
    if (self.dataLoaded) {
        UIView *errorView = [[self.config.errorClass alloc] init];
        [self onTableView:tableView updateErrorView:errorView];
        return errorView;
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.config.hasRemove;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLEWS(weakSelf);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self.requestDelegate respondsToSelector:@selector(requestOpeDelete:callback:)]) {
            //TODO loading
            [self.requestDelegate requestOpeDelete:[self.mutList xle_objectAtIndex:indexPath.row] callback:^(XLEError *error) {
                if (!error) {
                    [weakSelf.mutList xle_removeObjectAtIndex:indexPath.row];
                    [tableView beginUpdates];
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [tableView endUpdates];
                    //TODO 错误提示
                }
            }];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mutList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    Class cellClass = [self onTableView:tableView cellForItem:[self.mutList xle_objectAtIndex:indexPath.row] indexPath:indexPath];
    NSString *className = NSStringFromClass([cellClass class]);
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:className];
    }
    return cell;
}

#pragma mark - set get
- (XLEBaseTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[XLEBaseTableView alloc] initWithFrame:CGRectZero style:self.config.tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)constraints
{
    if (_constraints == nil) {
        _constraints = [NSMutableArray new];
    }
    return _constraints;
}

- (void)setTableViewInsets:(UIEdgeInsets)tableViewInsets
{
    [self.view removeConstraints:self.constraints];
    [_tableView removeConstraints:self.constraints];
    _tableViewInsets = tableViewInsets;
    if ([_tableView superview]) {
        [self.constraints addObjectsFromArray:[_tableView autoPinEdgesToSuperviewEdgesWithInsets:_tableViewInsets]];
    }
}

- (void)setTableView:(XLEBaseTableView *)tableView{
    _tableView = tableView;
    if (self.isViewLoaded) {
        [self.view addSubview:tableView];
        [_tableView autoPinEdgesToSuperviewEdgesWithInsets:self.tableViewInsets];
    }
}

- (NSMutableArray *)mutList{
    if (_mutList == nil) {
        _mutList = [[NSMutableArray alloc] init];
    }
    return _mutList;
}

@end
