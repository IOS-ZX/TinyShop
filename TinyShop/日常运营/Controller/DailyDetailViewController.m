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

/** 分类 **/
@property(nonatomic,strong)UISegmentedControl *segment;

/** 实时收入 **/
@property(nonatomic,strong)NSArray *times;

/** 会员消费 **/
@property(nonatomic,strong)NSArray *vip;

/** 支付类型 **/
@property(nonatomic,strong)NSArray *way;

/** 主图数据 **/
@property(nonatomic,strong)NSArray *main;

@end

@implementation DailyDetailViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDatas];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 自定义方法
// 加载数据
- (void)loadDatas{
    __weak typeof(self) weakSelf = self;
    [DailyTimeControll subDailyTimeRequest:^(NSArray *branch, NSArray *times, NSArray *way, NSArray *vip) {
        weakSelf.times = times;
        weakSelf.way = way;
        weakSelf.vip = vip;
        weakSelf.main = branch;
        weakSelf.chartView.detailArray = times;
        weakSelf.chartView.dataArray = branch;
        [weakSelf makeTitle];
        if (way) {
            weakSelf.segment.hidden = NO;
        }else{
            weakSelf.segment.hidden = YES;
        }
        if (branch.count == 1) {
            weakSelf.segment.center = CGPointMake(self.view.width / 2, weakSelf.segment.center.y);
        }
    }  shopId:self.shopId statisticalType:self.dataType query:self.queryType time:self.date];
}

// 设置title
- (void)makeTitle{
    NSString *title;
    switch (self.dataType) {
        case sales:
            title = [NSString stringWithFormat:@"%@:%g元",self.date,[self getSumValue]];
            break;
        case order_num:
            title = [NSString stringWithFormat:@"%@:%g桌",self.date,[self getSumValue]];
            break;
        case people_num:
            title = [NSString stringWithFormat:@"%@:%g人",self.date,[self getSumValue]];
            break;
        case people_avg:
            title = [NSString stringWithFormat:@"%@:%g元",self.date,[self getSumValue]];
            break;
        case avg_meal:
            title = [NSString stringWithFormat:@"%@:%g小时",self.date,[self getSumValue]];
            break;
    }
    self.title = title;
}

// 获取总和
- (CGFloat)getSumValue{
    __block CGFloat sum = 0;
    [self.main enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *num = dic[@"value"];
        sum += [num floatValue];
    }];
    return sum;
}

#pragma mark - segment Value Change

- (void)segmentValueChange:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:
            //实时收入
            self.chartView.detailArray = self.times;
            break;
        case 1:
            //会员消费
            self.chartView.detailArray = self.vip;
            break;
        case 2:
            //支付类型
            self.chartView.detailArray = self.way;
            break;
        default:
            break;
    }
    [self.chartView stork];
}

#pragma mark - 懒加载

- (MyPieChartView *)chartView{
    if (!_chartView) {
        _chartView = [[MyPieChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        [self.view addSubview:_chartView];
    }
    return _chartView;
}

- (UISegmentedControl *)segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"实时总收入",@"会员消费",@"支付类型"]];
        _segment.selectedSegmentIndex = 0;
        _segment.hidden = YES;
        [_segment setTintColor:[UIColor redColor]];
        [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateNormal];
        _segment.frame = CGRectMake(0, 0, SCREEN_W * 0.7, 40);
        _segment.center = CGPointMake(SCREEN_W * 0.9 * 0.5, 25);
        [_segment addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
        [self.chartView.scrollView addSubview:self.segment];
    }
    return _segment;
}

@end
