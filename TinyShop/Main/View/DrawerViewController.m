//
//  DrawerViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "DrawerViewController.h"
#import "HomeViewController.h"
#import "BaseUINavigationController.h"
#import "DrawerCell.h"

@interface DrawerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_icons;
    NSArray *_texts;
    UILabel *_headView;
}

/** tableview **/
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initView];
    [self initMain];
}

/** 初始化数据 **/
- (void)initDatas{
    _icons = @[@"进货管理图标",@"销货管理图标",@"库存管理图标",@"成本分析图标"];
    _texts = @[@"进货管理",@"销货管理",@"库存管理",@"成本分析"];
}

/** 初始化view **/
- (void)initView{
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 80)];
    _headView.backgroundColor = self.view.backgroundColor;
    _headView.text = @"\t云迈天行特色火锅";
    _headView.font = [UIFont systemFontOfSize:24];
}

/** 初始化主界面 **/
- (void)initMain{
    HomeViewController *home = [HomeViewController new];
    BaseUINavigationController *nav = [[BaseUINavigationController alloc]initWithRootViewController:home];
    nav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    nav.view.layer.shadowOffset = CGSizeMake(5, 6);
    nav.view.layer.shadowOpacity = 0.5;
    nav.view.layer.shadowRadius = 10;
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DrawerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"DrawerCell" owner:self options:nil].firstObject;
    }
    cell.backgroundColor = self.view.backgroundColor;
    cell.text.text = _texts[indexPath.row];
    cell.icon.image = [UIImage imageNamed:_icons[indexPath.row]];
    return cell;
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
