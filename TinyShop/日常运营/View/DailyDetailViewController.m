//
//  DailyDetailViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/30.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "DailyDetailViewController.h"


@interface DailyDetailViewController ()

/** 统计 **/
@property(nonatomic,strong)MyPieChartView *chartView;

@end

@implementation DailyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
