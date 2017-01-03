//
//  TimeIncomeDetailViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/27.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "TimeIncomeDetailViewController.h"
#import "TimeControll.h"

@interface TimeIncomeDetailViewController ()

/** 统计图 **/
@property(nonatomic,strong)MyPieChartView *chartView;

@end

@implementation TimeIncomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopId = _shopId;
    self.time = _time;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 请求数据
- (void)loadDatas{
    __weak typeof(self) weakSelf = self;
    [TimeControll subgraphRequest:^(NSArray *titles, NSArray *values) {
        weakSelf.chartView.detailArray = values;
        weakSelf.chartView.dataArray = titles;
    } shopId:self.shopId time:self.time];
}

#pragma mark - 懒加载

- (MyPieChartView *)chartView{
    if (!_chartView) {
        _chartView = [[MyPieChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        [self.view addSubview:_chartView];
    }
    return _chartView;
}

@end
