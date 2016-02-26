//
//  XLEDemoViewController.m
//
//  Created by Randy on 16/1/20.
//  Copyright © 2016年 Randy. All rights reserved.
//

#import "XLEDemoViewController.h"

@interface XLEDemoViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<XLEDemoItem *> *items;

@end

@implementation XLEDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self doAddItemsOperation];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)doAddItemsOperation
{
    
}

- (void)showDemoResultString:(NSString *)result
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:result delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    XLEDemoItem *demoItem = self.items[indexPath.row];
    cell.detailTextLabel.text = demoItem.desc;
    cell.textLabel.text = demoItem.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XLEDemoItem *demoItem = self.items[indexPath.row];
    if (demoItem.handleBlock) {
        demoItem.handleBlock();
    }
}


#pragma mark - set get
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

- (NSMutableArray<XLEDemoItem *> *)items{
    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

@end

@implementation XLEDemoItem

+ (XLEDemoItem *)itemWithName:(NSString *)name
                         desc:(NSString *)desc
                     callback:(void(^)())callback;
{
    XLEDemoItem *demoItem = [[XLEDemoItem alloc] init];
    demoItem.name = name;
    demoItem.desc = desc;
    demoItem.handleBlock = callback;
    return demoItem;
}

@end
