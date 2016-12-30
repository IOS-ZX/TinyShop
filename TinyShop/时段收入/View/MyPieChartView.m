//
//  MyPieChartView.m
//  TinyShop
//
//  Created by rimi on 2016/12/28.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "MyPieChartView.h"
#import "PieChartView.h"

@interface MyPieChartView()

/** 滑动 **/
@property(nonatomic,strong)UIScrollView *scrollView;
/** dataSet **/
@property(nonatomic,strong)MZPieChartDataSet *dataSet;
/** chartView **/
@property(nonatomic,strong)PieChartView *chartView;
/** 分割线 **/
@property(nonatomic,strong)UIImageView *carveUp;
/** 选中下标 **/
@property(nonatomic,assign)NSInteger index;
/** 详细图标 **/
@property(nonatomic,strong)PieChartView *detailsChart;

@end

@implementation MyPieChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.index = -1;
    }
    return self;
}

- (void)checkShop{
    if ([self.data[@"body"][@"branch"] count] > 1) {
        self.scrollView.contentOffset = CGPointMake(SCREEN_W * 0.8 + 7, 0);
    }else{
        self.scrollView.contentSize = CGSizeMake(0, 0);
        self.chartView.hidden = YES;
        self.detailsChart.frame = CGRectMake(0, 0, self.width, self.height);
        [self details:0 data:self.data];
    }
}

#pragma mark - Setter

- (void)setData:(NSDictionary *)data{
    _data = data;
    [self makeDatas:self.data];
    [self checkShop];
}

- (void)setShopId:(NSString *)shopId{
    _shopId = shopId;
}

// 处理数据
- (void)makeDatas:(NSDictionary*)data{
    __block NSMutableArray *titles = [NSMutableArray array];
    __block NSMutableArray *values = [NSMutableArray array];
    [data[@"body"][@"branch"] enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:obj[@"name"]];
        [values addObject:obj[@"value"]];
    }];
    self.dataSet.textStore = titles;
    self.dataSet.valueStore = values;
    self.dataSet.text = @"所有店铺";
    self.dataSet.colorStore = [MZPieChartDataSet colorStoreByCount:self.dataSet.valueStore.count];
    self.chartView.dataSet = self.dataSet;
    __weak typeof(self) weakSelf = self;
    //取消选中
    self.chartView.deselects = ^(void){
        weakSelf.scrollView.scrollEnabled = NO;
        weakSelf.index = -1;
    };
    //选中
    self.chartView.selects = ^(NSInteger index){
        weakSelf.index = index;
        weakSelf.scrollView.scrollEnabled = YES;
        weakSelf.carveUp.hidden = NO;
        [weakSelf details:index data:data];
    };
}

//详细界面
- (void)details:(NSInteger)index data:(NSDictionary*)data{
    MZPieChartDataSet *set = [MZPieChartDataSet new];
    __block NSMutableArray *titles = [NSMutableArray array];
    __block NSMutableArray *values = [NSMutableArray array];
    NSString *shopName = data[@"body"][@"branch"][index][@"name"];
    NSString *shopId = [NSString stringWithFormat:@"shop_id_%@",[[UserInstance sharedUserInstance]getShopIdByShopName:shopName]];
    [data[@"body"][@"vegetables"][shopId] enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:obj[@"name"]];
        [values addObject:obj[@"value"]];
    }];
    set.textStore = titles;
    set.valueStore = values;
    set.text = self.chartView.dataSet.textStore[index];
    set.colorStore = [MZPieChartDataSet colorStoreByCount:titles.count];
    self.detailsChart.dataSet = set;
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, self.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_W * 0.9 * 2 + 7,0);
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (MZPieChartDataSet *)dataSet{
    if (!_dataSet) {
        _dataSet = [MZPieChartDataSet new];
    }
    return _dataSet;
}

- (PieChartView *)chartView{
    if (!_chartView) {
        _chartView = [[PieChartView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.9 + 7, 0, SCREEN_W * 0.9, self.height)];
        [self.scrollView addSubview:_chartView];
    }
    return _chartView;
}

- (UIImageView *)carveUp{
    if (!_carveUp) {
        _carveUp = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"影子导图"]];
        _carveUp.frame = CGRectMake(SCREEN_W * 0.9, 0, 7, self.height);
        [self.scrollView addSubview:_carveUp];
    }
    return _carveUp;
}

- (PieChartView *)detailsChart{
    if (!_detailsChart) {
        _detailsChart = [[PieChartView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W * 0.95, self.height)];
        _detailsChart.isDetail = YES;
        [self.scrollView insertSubview:_detailsChart atIndex:0];
    }
    return _detailsChart;
}

@end
