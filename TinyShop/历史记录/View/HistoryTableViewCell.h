//
//  HistoryTableViewCell.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

//日历 应该放在表头
@property (nonatomic,strong) UIImageView *calendar;
@property (nonatomic,strong) UILabel *calendarLabel;
@property (nonatomic,strong) UILabel *week;
//店铺icon
@property (nonatomic,strong) UIImageView *shopIcon;
//收入icon
@property (nonatomic,strong) UIImageView  *incomeIcon;
//应收金额
@property (nonatomic,strong) UILabel *goods_amount;
//应收金额
@property (nonatomic,strong) UILabel *cash_money;
//店铺ID
@property (nonatomic,strong) UILabel *shop_id;
//单店总收入
@property (nonatomic,strong) UILabel *sum_money;
//顾客总人数
@property (nonatomic,strong) UILabel *sum_people;
//总单数
@property (nonatomic,strong) UILabel *sum_order;
//总应收
@property (nonatomic,strong) UILabel *sum_goods_amount;
//总差额
@property (nonatomic,strong) UILabel *sum_discount;
//现金收入金额
@property (nonatomic,strong) UILabel *sum_cash_money;
//刷卡总金额
@property (nonatomic,strong) UILabel *sum_creditcard_money;
//预存款总金额
@property (nonatomic,strong) UILabel *sum_use_balance;
//代金券
@property (nonatomic,strong) UILabel *sum_aBulk;

@end
