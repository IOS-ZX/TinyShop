//
//  HistoryTableViewCell.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

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
    _shopIcon = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 0, SCREEN_W*0.4, 30)];
    _shopIcon.contentMode = UIViewContentModeLeft;
    _shopIcon.image = [UIImage imageNamed:@"店铺图标"];
    
    _incomeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W*0.5, 0, SCREEN_W*0.4, 30)];
    _incomeIcon.contentMode = UIViewContentModeLeft;
    _incomeIcon.image = [UIImage imageNamed:@"店铺收入图标"];
    
    _shop_id = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.1, 0, SCREEN_W*0.4, 30)];
    _sum_money = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.56, 0, SCREEN_W*0.4, 30)];
    
    _sum_people = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 30, SCREEN_W*0.4, 20)];
    _sum_order = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.5, 30, SCREEN_W*0.4, 20)];
    
    _sum_goods_amount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 50, SCREEN_W*0.4, 20)];
    _sum_discount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.5, 50, SCREEN_W*0.4, 20)];
    
    _sum_cash_money = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 70, SCREEN_W*0.4, 20)];
    _sum_creditcard_money = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.5, 70, SCREEN_W*0.4, 20)];
    
    _sum_use_balance = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 90, SCREEN_W*0.4, 20)];
    _sum_aBulk = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.5, 90, SCREEN_W*0.4, 20)];
    
    _shop_id.font = [UIFont systemFontOfSize:FONT(13)];
    _shop_id.textColor = [UIColor grayColor];
    _shop_id.numberOfLines = 0;
    _sum_money.font = [UIFont systemFontOfSize:FONT(13)];
    _sum_money.textColor = [UIColor grayColor];
    _sum_people.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_people.textColor = [UIColor lightGrayColor];
    _sum_goods_amount.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_goods_amount.textColor = [UIColor lightGrayColor];
    _sum_order.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_order.textColor = [UIColor lightGrayColor];
    _sum_discount.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_discount.textColor = [UIColor lightGrayColor];
    _sum_cash_money.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_cash_money.textColor = [UIColor lightGrayColor];
    _sum_creditcard_money.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_creditcard_money.textColor = [UIColor lightGrayColor];
    _sum_use_balance.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_use_balance.textColor = [UIColor lightGrayColor];
    _sum_aBulk.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_aBulk.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_shop_id];
    [self.contentView addSubview:_sum_money];
    [self.contentView addSubview:_sum_people];
    [self.contentView addSubview:_sum_order];
    [self.contentView addSubview:_sum_goods_amount];
    [self.contentView addSubview:_sum_discount];
    [self.contentView addSubview:_sum_cash_money];
    [self.contentView addSubview:_sum_creditcard_money];
    [self.contentView addSubview:_sum_use_balance];
    [self.contentView addSubview:_sum_aBulk];
    [self.contentView addSubview:_shopIcon];
    [self.contentView addSubview:_incomeIcon];
    
}
@end
