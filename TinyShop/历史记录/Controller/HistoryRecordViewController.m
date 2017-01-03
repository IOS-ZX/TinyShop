//
//  HistoryRecordViewController.m
//  FrameTinyShop
//
//  Created by Mac on 17/1/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "HistoryRecordViewController.h"
#import "NetTool.h"
#import "TQConst.h"
#import "OrderModel.h"
#import "TypeTableViewCell.h"
#import <MJExtension.h>
#import "OrderTableViewCell.h"
#import "OrderSectionHeaderView.h"

@interface HistoryRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation HistoryRecordViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.05, 0, SCREENWIDTH*0.9, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        //注册cell
        [_tableView registerClass:[TypeTableViewCell class] forCellReuseIdentifier:@"TypeTableViewCell"];
        //注册section header
        [_tableView registerClass:[OrderSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"OrderSectionHeaderView"];
        //section header 高度
        _tableView.sectionHeaderHeight = 100;
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH*0.05, 5, SCREENWIDTH*0.9, 50)];
        headerImageView.image = [UIImage imageNamed:@"半圆角背景图"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.05, 5, SCREENWIDTH*0.9, 50)];
        label.text = @"订单消费记录";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:16];
        
        [headerImageView addSubview:label];
        _tableView.tableHeaderView = headerImageView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadDataSource];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    // Do any additional setup after loading the view.
}

- (void)loadDataSource{

    [NetTool checkRequest:@"historyDetailedAction" loadingMessage:@"加载中" parameter:@{@"body":@{@"shop_id":self.shop_id ,@"time":self.date,@"dinner":self.dinner,@"limit":@"0,10"}} success:^(NSDictionary *result) {
        NSArray *orders = [NSArray arrayWithArray:[result objectForKey:@"body"]];
        NSMutableArray *processOrders = [NSMutableArray array];
        [orders enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSMutableDictionary *single_order = [obj mutableCopy];
            //
            [self orderProcessClassify:single_order];
            [processOrders addObject:single_order];
        }];
        //字典数组转模型数组
        _dataSource = [OrderModel mj_objectArrayWithKeyValuesArray:processOrders];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
}

//订单中的食物的类型处理
- (void)orderProcessClassify:(NSMutableDictionary *)single_order
{
    //{@"goods":@[食品1,食品2,食品3,...]}
    //1.订单中的食品:@[食品1,食品2,食品3,...]
    NSArray *goodStore = single_order[@"goods"];
    
    //2.遍历每个食品得到 @{类型1:[食品1，食品2],类型2:[]}
    NSDictionary *typeAndGoodsStore = [self typeAndGoodsStoreByGoods:goodStore];
    
    //3.[{@"kindName":@"类型1",@"goodStore":@[食物1，食物2]},...]
    NSArray *goodsByType = [self goodByTypeWithTypeAndGoodsStore:typeAndGoodsStore];
    [single_order removeObjectForKey:@"goods"];
    [single_order setObject:goodsByType forKey:@"types"];
}
//@[食品1,食品2,食品3,...] -> @{类型1:[食品1，食品2],类型2:[食品3]}
- (NSDictionary *)typeAndGoodsStoreByGoods:(NSArray *)goodStore
{
    NSMutableDictionary *typeAndGoodsStore = [NSMutableDictionary dictionary];
    
    [goodStore enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *typeName = obj[@"kindName"];
        [typeAndGoodsStore setObject:[NSMutableArray array] forKey:typeName];
        
    }];
    //{热菜:[],凉菜:[]}
    [goodStore enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //取出类型
        NSString *typeName = obj[@"kindName"];
        //当前类型的食物数组
        NSMutableArray *currentType = typeAndGoodsStore[typeName];
        [currentType addObject:obj];
    }];
    return typeAndGoodsStore;
}
//@{类型1:[食品1，食品2],类型2:[食品3]} -> [{@"kindName":@"类型1",@"goodStore":@[食物1，食物2]},...]
- (NSArray *)goodByTypeWithTypeAndGoodsStore:(NSDictionary *)typeAndGoodsStore
{
    NSMutableArray *store = [NSMutableArray array];
    [typeAndGoodsStore enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull type, NSString *  _Nonnull goodStore, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:type forKey:@"kindName"];
        [dic setObject:goodStore forKey:@"goods"];
        [store addObject:dic];
    }];
    return store;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    OrderModel *orderModel = self.dataSource[section];
    if (orderModel.sectionOpenSign) {
        //订单下类型的个数
        return orderModel.types.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeTableViewCell *typeCell = [tableView dequeueReusableCellWithIdentifier:@"TypeTableViewCell" forIndexPath:indexPath];
    //对应订单
    OrderModel *orderModel = self.dataSource[indexPath.section];
    //对应类型
    TypeModel *typeModel = orderModel.types[indexPath.row];
    
    typeCell.typeModel = typeModel;
    return typeCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    OrderSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderSectionHeaderView"];
    sectionHeaderView.section = section;
    
    OrderModel *order = self.dataSource[section];
    NSString *hour = [order.order_shipping_time substringFromIndex:10];
    NSString *day = [order.order_shipping_time substringWithRange:NSMakeRange(8, 2)];
    NSString *month = [order.order_shipping_time substringToIndex:7];
    sectionHeaderView.order_sn.text = [NSString stringWithFormat:@"订单号:%@",order.order_sn];
    sectionHeaderView.order_shipping_time.text = [NSString stringWithFormat:@"at %@",hour];
    sectionHeaderView.order_stable_deskno.text = [NSString stringWithFormat:@"桌号: %@",order.order_stable_deskno];
    sectionHeaderView.order_person_num.text =[NSString stringWithFormat:@"人数: %@",order.order_person_num];
    sectionHeaderView.time_length.text = [NSString stringWithFormat:@"时长: %@",order.time_length];
    sectionHeaderView.order_goods_amount.text = [NSString stringWithFormat:@"应收: %d",[order.order_goods_amount intValue]];
    sectionHeaderView.order_use_balance.text = [NSString stringWithFormat:@"实收: %d",[order.order_use_balance intValue]];
    sectionHeaderView.order_waiter_account.text = [NSString stringWithFormat:@"收银员: %@",order.order_waiter_account];
    sectionHeaderView.order_cash_money.text = [NSString stringWithFormat:@"现金: %d",[order.order_cash_money intValue]];
    sectionHeaderView.aBulk.text = [NSString stringWithFormat:@"刷卡: %d",[order.aBulk intValue]];
    sectionHeaderView.order_order_amount.text = [NSString stringWithFormat:@"预付款: %d",[order.order_order_amount intValue]];
    sectionHeaderView.shopdt_discount.text = [NSString stringWithFormat:@"折扣: %@",order.shopdt_discount];
    sectionHeaderView.order_creditcard_money.text = [NSString stringWithFormat:@"代金券: %d",[order.order_creditcard_money intValue]];
    sectionHeaderView.calendarLabel.text = [NSString stringWithFormat:@"%@日",day];
    sectionHeaderView.date.text = month;
    
    __weak typeof(self) weakSelf = self;
    sectionHeaderView.didSelectSection = ^(NSUInteger section_x){
        OrderModel *orderModel = weakSelf.dataSource[section_x];
        orderModel.sectionOpenSign = !orderModel.sectionOpenSign;
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section_x] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    //}
    
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //对应订单
    OrderModel *orderModel = self.dataSource[indexPath.section];
    //对应类型
    TypeModel *typeModel = orderModel.types[indexPath.row];
    typeModel.typeCellIndex = indexPath.row;
    return typeModel.typeCellHeight;
}

@end
