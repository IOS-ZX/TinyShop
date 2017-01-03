//
//  OrderTableViewCell.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    _order_sn = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.05, 0, SCREENWIDTH*0.9, 30)];
    
    _order_shipping_time = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.05, 20, SCREENWIDTH*0.8, 10)];
    _order_shipping_time.textAlignment = NSTextAlignmentRight;
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.05, 31, SCREENWIDTH*0.8, 1)];
    _line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    _order_stable_deskno = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.225, 30, SCREENWIDTH*0.225, 20)];
    
    _order_person_num = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.45, 30, SCREENWIDTH*0.225, 20)];
    
    _time_length = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.675, 30, SCREENWIDTH*0.225, 20)];
    
    _order_goods_amount = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.225, 50, SCREENWIDTH*0.225, 20)];
    
    _order_use_balance = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.45, 50, SCREENWIDTH*0.225, 20)];
    
    _order_waiter_account = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.675, 50, SCREENWIDTH*0.225, 20)];
    
    _order_cash_money = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.225, 70, SCREENWIDTH*0.225, 20)];
    
    _aBulk = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.45, 70, SCREENWIDTH*0.225, 20)];
    
    _order_order_amount = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.675, 70, SCREENWIDTH*0.225, 20)];
    
    _shopdt_discount = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.225, 90, SCREENWIDTH*0.225, 20)];
    
    _order_creditcard_money = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.675, 90, SCREENWIDTH*0.225, 20)];
    
    _calendar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, SCREENWIDTH*0.225, 40)];
    _calendar.contentMode = UIViewContentModeCenter;
    _calendar.image = [UIImage imageNamed:@"日历框"];
    
    _calendarLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH*0.225, 30)];
    _calendarLabel.font = [UIFont systemFontOfSize:14];
    _calendarLabel.textAlignment = NSTextAlignmentCenter;
    _calendarLabel.textColor = [UIColor colorWithRed:248/255.0 green:82/255.0 blue:61/255.0 alpha:1];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, SCREENWIDTH*0.225, 20)];
    _date.textAlignment = NSTextAlignmentCenter;
    _date.font = [UIFont systemFontOfSize:14];
    _date.textColor = [UIColor grayColor];
    
    _order_sn.font = [UIFont systemFontOfSize:14];
    _order_sn.textColor = [UIColor grayColor];
    
    _order_shipping_time.font = [UIFont systemFontOfSize:9];
    _order_stable_deskno.font = [UIFont systemFontOfSize:11];
    _order_person_num.font = [UIFont systemFontOfSize:11];
    _time_length.font = [UIFont systemFontOfSize:11];
    _order_goods_amount.font = [UIFont systemFontOfSize:11];
    _order_use_balance.font = [UIFont systemFontOfSize:11];
    _order_waiter_account.font = [UIFont systemFontOfSize:11];
    _order_cash_money.font = [UIFont systemFontOfSize:11];
    _aBulk.font = [UIFont systemFontOfSize:11];
    _order_order_amount.font = [UIFont systemFontOfSize:11];
    _shopdt_discount.font = [UIFont systemFontOfSize:11];
    _order_creditcard_money.font = [UIFont systemFontOfSize:11];
    
    _order_shipping_time.textColor = [UIColor grayColor];
    _order_stable_deskno.textColor = [UIColor grayColor];
    _order_person_num.textColor = [UIColor grayColor];
    _time_length.textColor = [UIColor grayColor];
    _order_goods_amount.textColor = [UIColor grayColor];
    _order_use_balance.textColor = [UIColor greenColor];
    _order_waiter_account.textColor = [UIColor grayColor];
    _order_cash_money.textColor = [UIColor grayColor];
    _aBulk.textColor = [UIColor grayColor];
    _order_order_amount.textColor = [UIColor grayColor];
    _shopdt_discount.textColor = [UIColor grayColor];
    _order_creditcard_money.textColor = [UIColor grayColor];
    
    [self.contentView addSubview:_order_sn];
    [self.contentView addSubview:_order_shipping_time];
    [self.contentView addSubview:_line];
    [self.contentView addSubview:_order_stable_deskno];
    [self.contentView addSubview:_order_person_num];
    [self.contentView addSubview:_time_length];
    [self.contentView addSubview:_order_goods_amount];
    [self.contentView addSubview:_order_use_balance];
    [self.contentView addSubview:_order_waiter_account];
    [self.contentView addSubview:_order_cash_money];
    [self.contentView addSubview:_aBulk];
    [self.contentView addSubview:_order_order_amount];
    [self.contentView addSubview:_shopdt_discount];
    [self.contentView addSubview:_order_creditcard_money];
    [self.contentView addSubview:_calendar];
    [self.contentView addSubview:_calendarLabel];
    [self.contentView addSubview:_date];
}
@end
