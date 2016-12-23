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
{
    CGPoint _startPoint;
    UIView *_touchView;
    BOOL _isShow;
}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    _isShow = NO;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"云迈天行特色火锅-销";
}

/** 初始化 **/
- (void)setUp{
    self.view.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"抽屉按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(showDrawer)];
    self.navigationItem.leftBarButtonItem = menu;
    UIBarButtonItem *exit = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(userExit)];
    self.navigationItem.rightBarButtonItem = exit;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT(17)]} forState:UIControlStateNormal];
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowRadius = 2;
    _touchView = [[UIView alloc]initWithFrame:self.view.bounds];
    _touchView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0];
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, -70) forBarMetrics:UIBarMetricsDefault];
}

/** 注销 **/
- (void)userExit{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginOut" object:nil];
}

/** 显示隐藏抽屉 **/
- (void)showDrawer{
    [UIView animateWithDuration:0.3 animations:^{
        if (!_isShow) {
            self.navigationController.view.center = CGPointMake(SCREEN_W + SCREEN_W / 6, self.navigationController.view.center.y);
            [self.view addSubview:_touchView];
        }else{
            self.navigationController.view.center = CGPointMake(SCREEN_W / 2, self.navigationController.view.center.y);
            [_touchView removeFromSuperview];
        }
    }];
    _isShow = !_isShow;
}

#pragma mark - 拖动

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:_touchView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGFloat x = self.navigationController.view.center.x;
    CGPoint point = [touch locationInView:_touchView];
    if (x >= SCREEN_W / 2 && _isShow) {
        CGFloat value = _startPoint.x - point.x;
        self.navigationController.view.center = CGPointMake(x - value, self.navigationController.view.center.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGFloat x = self.navigationController.view.center.x;
    if (x < SCREEN_W / 4 * 3 && _isShow) {
        _isShow = YES;
        [self showDrawer];
    }else if(x >= SCREEN_W / 3 && _isShow){
        _isShow = NO;
        [self showDrawer];
    }
}

#pragma mark - tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_W * 0.275;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.title = @"";
    switch (indexPath.row) {
        case 0:
            //时段收入
        {
            TimeViewController *timeVC = [TimeViewController new];
            timeVC.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:timeVC animated:YES];
        }
            break;
        case 1:
            //日常运营
        {
            DailyViewController *daily = [DailyViewController new];
            daily.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:daily animated:YES];
        }
            break;
        case 2:
            //商品运营
        {
            GoodsViewController *goods = [GoodsViewController new];
            goods.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:goods animated:YES];
        }
            break;
        case 3:
            //会员
        {
            UserTableViewController *user = [UserTableViewController new];
            user.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:user animated:YES];
        }
            break;
        case 4:
            //历史
        {
            HistoryTableViewController *history = [HistoryTableViewController new];
            history.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:history animated:YES];
        }
            break;
        default:
            break;
    }
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
    cell.leftImage.contentMode = UIViewContentModeTop;
    cell.leftImage.image=[UIImage imageNamed:leftImageName[indexPath.row]];
    cell.label1.text = label1Text[indexPath.row];
    cell.label2.text = label2Text[indexPath.row];
    cell.label3.text = label3Text[indexPath.row];
    cell.rightImage.contentMode = UIViewContentModeCenter;
    cell.rightImage.image = [UIImage imageNamed:rightImageName[indexPath.row]];
    return cell;
}

#pragma mark - 懒加载

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
