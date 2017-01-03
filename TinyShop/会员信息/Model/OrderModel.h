//
//  OrderModel.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/24.
//  Copyright © 2016年 Mac. All rights reserved.
//
/*
    会员消费的记录
 */
#import <Foundation/Foundation.h>
#import "TypeModel.h"
#import <MJExtension.h>

@interface OrderModel : NSObject

//
@property (nonatomic,strong) NSString *order_shopping_volume_fee;
//订单的具体桌号
@property (nonatomic,strong) NSString *order_stable_deskno;
//订单号码
@property (nonatomic,strong) NSString *order_sn;
//
@property (nonatomic,strong) NSString *aBulk;
//订单实收金额
@property (nonatomic,strong) NSString *order_goods_amount;
//订单的ID
@property (nonatomic,strong) NSString *order_id;
//订单时间
@property (nonatomic,strong) NSString *order_shipping_time;
//
@property (nonatomic,strong) NSString *weixin;
//订单时长
@property (nonatomic,strong) NSString *time_length;
//收银员ID
@property (nonatomic,strong) NSString *order_waiter_account;
//用餐人数
@property (nonatomic,strong) NSString *order_person_num;
//订单应收金额
@property (nonatomic,strong) NSString *order_use_balance;
//订单折扣
@property (nonatomic,strong) NSString *shopdt_discount;
//代金券
@property (nonatomic,strong) NSString *order_creditcard_money;
//
@property (nonatomic,strong) NSString *order_order_amount;
//
@property (nonatomic,strong) NSString *order_cash_money;
///** 食物类型*/ 元素为MZTypeModel
@property(nonatomic,strong) NSArray *types;
//对应section 是否打开
@property(nonatomic,assign) BOOL sectionOpenSign;

@end
