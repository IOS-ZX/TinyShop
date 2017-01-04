//
//  OrderSectionHeaderView.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

typedef void (^SectionCallBack)(NSUInteger section);
@interface OrderSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) NSUInteger section;

@property (nonatomic,strong) UILabel *order_sn;

@property (nonatomic,strong) UILabel *order_shipping_time;

@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UILabel *order_stable_deskno;

@property (nonatomic,strong) UILabel *order_person_num;

@property (nonatomic,strong) UILabel *time_length;

@property (nonatomic,strong) UILabel *order_goods_amount;

@property (nonatomic,strong) UILabel *order_use_balance;

@property (nonatomic,strong) UILabel *order_waiter_account;

@property (nonatomic,strong) UILabel *order_cash_money;

@property (nonatomic,strong) UILabel *aBulk;

@property (nonatomic,strong) UILabel *order_order_amount;

@property (nonatomic,strong) UILabel *shopdt_discount;

@property (nonatomic,strong) UILabel *order_creditcard_money;

@property (nonatomic,strong) UIImageView *calendar;

@property (nonatomic,strong) UILabel *calendarLabel;

@property (nonatomic,strong) UILabel *date;

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic, copy) SectionCallBack didSelectSection;

@end
