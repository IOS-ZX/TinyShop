//
//  HomeViewController.m
//  TinyShop
//
//  Created by Mac on 16/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation HomeViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSArray *leftImageName = @[@"时段收入分析图标",@"日常运营分析图标",@"商品运营分析图标",@"会员信息图标1",@"历史记录图标"];
    NSArray *label1Text = @[@"时段收入分析",@"日常运营分析",@"商品运营分析",@"会员信息",@"历史记录"];
    NSArray *label2Text = @[@"计时统计",@"销售额统计",@"销售额统计",@"会员消费单",@"历史额统计"];
    NSArray *label3Text = @[@"种类统计",@"人均消费",@"种类统计",@"总消费",@"总收入"];
    NSArray *rightImageName = @[@"红",@"蓝",@"黄",@"绿",@"紫"];
    cell.leftImage.contentMode=UIViewContentModeTop;
    cell.label1.text=label1Text[indexPath.row];
    cell.leftImage.image=[UIImage imageNamed:leftImageName[indexPath.row]];
    cell.label2.text=label2Text[indexPath.row];
    cell.label3.text=label3Text[indexPath.row];
    cell.rightImage.image=[UIImage imageNamed:rightImageName[indexPath.row]];
    cell.rightImage.contentMode=UIViewContentModeCenter;
    return cell;
}

@end
