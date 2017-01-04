//
//  HistoryViewController.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryOrderModel.h"
#import "HistoryTableViewCell.h"
#import "HistoryDetailViewController.h"
#import "OnlyChooseDate.h"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource,OnlyChooseDateDelegate>

@property (nonatomic,strong) OnlyChooseDate *pickDate;
@property (nonatomic,strong) NSString *lastPick;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *headerData;

@end

@implementation HistoryViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 0, SCREEN_W*0.9, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *pickDate = [[UIBarButtonItem alloc]initWithTitle:@"日期" style:UIBarButtonItemStyleDone target:self action:@selector(createPicker:)];
    self.navigationItem.rightBarButtonItem = pickDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastPick = @"2016-12-31";
    [self loadDataSource];
    self.navigationItem.title = @"历史记录";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)loadDataSource{
    _dataSource = [NSMutableArray array];
    [NetTool checkRequest:@"historyListAction" loadingMessage:@"加载中" parameter:@{@"body":@{@"shop_id":[[UserInstance sharedUserInstance] allShopIDs] ,@"s_time":@"2016-12-23",@"e_time":self.lastPick}} success:^(NSDictionary *result) {
        
        _headerData = [NSMutableArray arrayWithArray:result[@"body"]];
        [result[@"body"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            __block NSMutableArray *arr = [NSMutableArray array];
            
            [obj[@"orderInfo"][@"zhidian"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HistoryOrderModel *model = [HistoryOrderModel mj_objectWithKeyValues:obj];
                [arr addObject:model];
            }];
            [_dataSource addObject:arr];
            
        }];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource[section]count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // section的header的背景视图
    NSString *day = [_headerData[section][@"date"] substringWithRange:NSMakeRange(8, 2)];
    NSString *month = [_headerData[section][@"date"] substringToIndex:7];
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W*0.05, 5, SCREEN_W*0.9, 50)];
    headerImageView.image = [UIImage imageNamed:@"半圆角背景图"];
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 50)];
    icon.contentMode = UIViewContentModeTop;
    icon.image = [UIImage imageNamed:@"订单记录图标"];
    
    UIImageView *calendar = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W*0.1, 5, SCREEN_W*0.225, 40)];
    calendar.contentMode = UIViewContentModeCenter;
    calendar.image = [UIImage imageNamed:@"日历框"];
    
    UILabel *calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W*0.1, 20, SCREEN_W*0.225, 20)];
    calendarLabel.text = [NSString stringWithFormat:@"%@日",day];
    calendarLabel.textAlignment = NSTextAlignmentCenter;
    calendarLabel.font = [UIFont systemFontOfSize:14];
    calendarLabel.textColor = [UIColor colorWithRed:248/255.0 green:82/255.0 blue:61/255.0 alpha:1];
    
    UILabel *dateDay = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W*0.1, 45, SCREEN_W*0.225, 10)];
    dateDay.text = month;
    dateDay.textAlignment = NSTextAlignmentCenter;
    dateDay.font = [UIFont systemFontOfSize:12];
    dateDay.textColor = [UIColor grayColor];
    
    UILabel *goods_amount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.275, 35, SCREEN_W*0.3, 10)];
    goods_amount.text = [NSString stringWithFormat:@"应收:%@",_headerData[section][@"orderInfo"][@"cash_money"]];
    goods_amount.textAlignment = NSTextAlignmentCenter;
    goods_amount.font = [UIFont systemFontOfSize:12];
    goods_amount.textColor = [UIColor grayColor];
    
    UILabel *cash_money = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.575, 35, SCREEN_W*0.3, 10)];
    cash_money.text = [NSString stringWithFormat:@"实收:%@",_headerData[section][@"orderInfo"][@"goods_amount"]];
    cash_money.textAlignment = NSTextAlignmentCenter;
    cash_money.font = [UIFont systemFontOfSize:12];
    cash_money.textColor = [UIColor grayColor];
    
    /*
     根据日期来判断星期几
     */
    NSString *strDate = _headerData[section][@"date"];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [dateformatter dateFromString:strDate];
    [dateformatter setDateFormat:@"EEE"];
    NSString *  weekString = [dateformatter stringFromDate:date];
    NSString *weekLastText = [weekString substringFromIndex:1];
    NSLog(@"%@",weekString);
    
    UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.575, 15, SCREEN_W*0.33, 10)];
    week.text = [NSString stringWithFormat:@"星期%@",weekLastText];
    week.textAlignment= NSTextAlignmentCenter;
    week.font = [UIFont systemFontOfSize:12];
    week.textColor = [UIColor colorWithRed:248/255.0 green:82/255.0 blue:61/255.0 alpha:1];
    
    [headerImageView addSubview:icon];
    [headerImageView addSubview:calendar];
    [headerImageView addSubview:calendarLabel];
    [headerImageView addSubview:dateDay];
    [headerImageView addSubview:goods_amount];
    [headerImageView addSubview:cash_money];
    [headerImageView addSubview:week];
    return headerImageView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryOrderModel *model = _dataSource[indexPath.section][indexPath.row];
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.shop_id.text = [NSString stringWithFormat:@"%@",[[UserInstance sharedUserInstance] getNameBySHopId:model.shop_id]];
    cell.sum_money.text = [NSString stringWithFormat:@"收入:%@",model.sum_money];
    cell.sum_people.text = [NSString stringWithFormat:@"总人数:%@",model.sum_people];
    cell.sum_order.text = [NSString stringWithFormat:@"总单数:%@",model.sum_order];
    cell.sum_goods_amount.text = [NSString stringWithFormat:@"总应收:%@",model.sum_goods_amount];
    cell.sum_discount.text = [NSString stringWithFormat:@"总差额:%.2f",model.sum_discount.floatValue];
    cell.sum_cash_money.text = [NSString stringWithFormat:@"现金:%@",model.sum_cash_money];
    cell.sum_creditcard_money.text = [NSString stringWithFormat:@"刷卡:%@",model.sum_creditcard_money];
    cell.sum_use_balance.text = [NSString stringWithFormat:@"预付款:%@",model.sum_use_balance];
    cell.sum_aBulk.text = [NSString stringWithFormat:@"代金券:%@",model.sum_aBulk];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryOrderModel *model = _dataSource[indexPath.section][indexPath.row];
    HistoryDetailViewController *historyDetail = [[HistoryDetailViewController alloc]init];
    historyDetail.historyOrder = model;
    historyDetail.shopName = [[UserInstance sharedUserInstance] getNameBySHopId:model.shop_id];
    [self.navigationController pushViewController:historyDetail animated:YES];
    
}

-(OnlyChooseDate *)pickDate{
    if (!_pickDate) {
        _pickDate = [[OnlyChooseDate alloc]init];
        _pickDate.delegate = self;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_pickDate];
    }
    return _pickDate;
}

- (void)createPicker:(UIBarButtonItem *)sender{
    self.pickDate.hidden = NO;
}

- (void)chooseDatesOnlyForDate:(NSString *)date{
    _lastPick = date;
    [self loadDataSource];
}

@end
