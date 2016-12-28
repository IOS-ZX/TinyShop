//
//  PieChartView.m
//  TinyShop
//
//  Created by rimi on 2016/12/27.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "PieChartView.h"
#import "ChartTableViewCell.h"
#import "ChartTableViewDetailCellTableViewCell.h"

@interface PieChartView()<UITableViewDelegate,UITableViewDataSource>

/** 统计图 **/
@property(nonatomic,strong)MZPieChartView *chart;
/** tableView **/
@property(nonatomic,strong)UITableView *tableView;
/** 选中 **/
@property(nonatomic,strong)NSMutableArray *chooseStatus;

@end

@implementation PieChartView

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSet.textStore.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.chart selectOne:indexPath.row];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.isDetail) {
        ChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chart" forIndexPath:indexPath];
        cell.titleLabel.text = self.dataSet.textStore[indexPath.row];
        cell.leftView.backgroundColor = self.dataSet.colorStore[indexPath.row];
        cell.rightLabel.text = self.dataSet.valueStore[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSInteger status = [self.chooseStatus[indexPath.row] integerValue];
        if (status == 1) {
            cell.titleLabel.textColor = [UIColor redColor];
            cell.rightLabel.textColor = [UIColor redColor];
        }else{
            cell.titleLabel.textColor = [UIColor hexColor:@"919191"];
            cell.rightLabel.textColor = [UIColor hexColor:@"919191"];
        }
        return cell;
    }else{
        ChartTableViewDetailCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
        cell.color = self.dataSet.colorStore[indexPath.row];
        cell.titleLabel.text = self.dataSet.textStore[indexPath.row];
        cell.valueLabel.text = self.dataSet.valueStore[indexPath.row];
        cell.sumValue = [self.dataSet.sumValue floatValue];
        cell.value = [self.dataSet.valueStore[indexPath.row] floatValue];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - 自定义方法
- (void)stroke{
    [self.chart stroke];
    [self.tableView reloadData];
}

- (void)setDataSet:(MZPieChartDataSet *)dataSet{
    _dataSet = dataSet;
    self.chart.dataSet = self.dataSet;
    [self stroke];
}

/** 选中回调 */

- (SelectCallBack)select
{
    __weak typeof(self) weakSelf = self;
    return ^(NSInteger index){
        [self.chooseStatus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == index) {
                weakSelf.chooseStatus[idx] = @1;
            }else{
                weakSelf.chooseStatus[idx] = @0;
            }
        }];
        [weakSelf.tableView reloadData];
        if (self.selects) {
            weakSelf.selects(index);
        }
    };
}

/** 取消选中回调 */

- (DeselectCallBack)deselect
{
    __weak typeof(self) weakSelf = self;
    return ^{
        [self.chooseStatus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            weakSelf.chooseStatus[idx] = @0;
            [weakSelf.tableView reloadData];
        }];
        if (self.deselects) {
            weakSelf.deselects();
        }
    };
}

#pragma mark - 懒加载
- (MZPieChartView *)chart{
    if (!_chart) {
        _chart = [[MZPieChartView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height / 2)];
        _chart.selectOne = [self select];
        _chart.deselect = [self deselect];
        _chart.fontColorSet = self.colors;
        _chart.dataSet = self.dataSet;
        _chart.set = [self set];
        _chart.backgroundColor = [UIColor hexColor:@"f1f2f3"];
        [self addSubview:_chart];
    }
    return _chart;
}

/** 饼状图 设置 */
- (MZPieChartSet *)set
{
    MZPieChartSet *set = [[MZPieChartSet alloc]init];
    return set;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height / 2, self.width, self.height / 2)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        if (!self.isDetail) {
            UINib *nib = [UINib nibWithNibName:@"ChartTableViewCell" bundle:nil];
            [_tableView registerNib:nib forCellReuseIdentifier:@"chart"];
        }else{
            [_tableView registerClass:[ChartTableViewDetailCellTableViewCell class] forCellReuseIdentifier:@"detail"];
        }
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)chooseStatus{
    if (!_chooseStatus) {
        _chooseStatus = [NSMutableArray array];
        for (NSInteger index = 0; index < self.dataSet.textStore.count; index ++) {
            [_chooseStatus addObject:@0];
        }
    }
    return _chooseStatus;
}
@end
