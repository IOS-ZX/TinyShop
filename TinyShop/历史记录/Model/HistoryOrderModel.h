//
//  HistoryOrderModel.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryOrderModel : NSObject

//店铺ID
@property (nonatomic,strong) NSString *shop_id;
//单店总收入
@property (nonatomic,strong) NSString *sum_money;
//顾客总人数
@property (nonatomic,strong) NSString *sum_people;
//总单数
@property (nonatomic,strong) NSString *sum_order;
//总应收
@property (nonatomic,strong) NSString *sum_goods_amount;
//总差额
@property (nonatomic,strong) NSString *sum_discount;
//现金收入金额
@property (nonatomic,strong) NSString *sum_cash_money;
//刷卡总金额
@property (nonatomic,strong) NSString *sum_creditcard_money;
//预存款总金额
@property (nonatomic,strong) NSString *sum_use_balance;
//代金券
@property (nonatomic,strong) NSString *sum_aBulk;
//时间
@property (nonatomic,strong) NSString *date;

@end
