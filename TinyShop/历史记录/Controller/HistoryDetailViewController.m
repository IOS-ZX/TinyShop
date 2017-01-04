//
//  HistoryDetailViewController.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "HistoryDetailModel.h"
#import "HistoryDetailTableViewCell.h"
#import "HistoryRecordViewController.h"

@interface HistoryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation HistoryDetailViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.shopName;
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self loadDataSource];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)loadDataSource{
    _dataSource = [NSMutableArray array];

    [NetTool checkRequest:@"historyTypeAction" loadingMessage:@"加载中" parameter:@{@"body":@{@"shop_id":self.historyOrder.shop_id ,@"time":self.historyOrder.date}} success:^(NSDictionary *result) {
        
        NSDictionary *tangshi = [result[@"body"] valueForKey:@"tangshi"];
        HistoryDetailModel *model_tangshi = [HistoryDetailModel mj_objectWithKeyValues:tangshi];
        [_dataSource addObject:model_tangshi];
        
        NSDictionary *waimai = [result[@"body"] valueForKey:@"waimai"];
        HistoryDetailModel *model_waimai = [HistoryDetailModel mj_objectWithKeyValues:waimai];
        [_dataSource addObject:model_waimai];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        NSLog(@"食堂%@",tangshi);
        NSLog(@"外卖%@",waimai);
        NSLog(@"shop_id%@",self.historyOrder.shop_id);
        NSLog(@"数组的长度%ld",_dataSource.count);
           
    } error:^(NSError *error) {
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
    //[self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HistoryDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *strDate = self.historyOrder.date;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [dateformatter dateFromString:strDate];
    [dateformatter setDateFormat:@"EEE"];
    NSString *  weekString = [dateformatter stringFromDate:date];
    NSString *weekLastText = [weekString substringFromIndex:1];
    
    HistoryDetailModel *model = _dataSource[indexPath.section];
    cell.date.text = self.historyOrder.date;
    cell.sum_table.text = [NSString stringWithFormat:@"桌数:%@",model.sum_table];
    cell.sum_people.text = [NSString stringWithFormat:@"人数:%@",model.sum_people];
    cell.avg_people.text = [NSString stringWithFormat:@"人均:%@",model.avg_people];
    cell.sum_goods_amount.text = [NSString stringWithFormat:@"应收:%@",model.sum_goods_amount];
    cell.sum_order_amount.text = [NSString stringWithFormat:@"实收:%@",model.sum_order_amount];
    cell.sum_chae.text = [NSString stringWithFormat:@"人数:%@",model.sum_chae];
    cell.proportionIcon.image = [UIImage imageNamed:@"比例图标"];
    cell.week.text = [NSString stringWithFormat:@"星期%@",weekLastText];
    if (model.sum_goods_amount.intValue == 0 || self.historyOrder.sum_goods_amount.intValue == 0) {
        cell.proportionText.text = @"比例:0.00";
    }else{
        cell.proportionText.text = [NSString stringWithFormat:@"比例:%.2f",(model.sum_goods_amount.floatValue)/(self.historyOrder.sum_goods_amount.floatValue)];
    }
    if (indexPath.section == 0) {
        cell.typeIcon.image = [UIImage imageNamed:@"堂食图标"];
        cell.typeText.text = @"食堂";
    }else if (indexPath.section == 1) {
        cell.typeIcon.image = [UIImage imageNamed:@"外卖图标"];
        cell.typeText.text = @"外卖";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryDetailModel *model = _dataSource[indexPath.section];
    HistoryRecordViewController *record = [[HistoryRecordViewController alloc]init];
    record.date = self.historyOrder.date;
    record.shop_id = self.historyOrder.shop_id;
    record.shop_name = self.shopName;
    record.model = model;
    if (indexPath.section == 0) {
        record.dinner = @"0,2,5";
    }else if (indexPath.section == 1){
        record.dinner = @"1,3,6";
    }
    [self.navigationController pushViewController:record animated:YES];
    
}
@end
