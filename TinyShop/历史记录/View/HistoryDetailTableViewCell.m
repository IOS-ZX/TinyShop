//
//  HistoryDetailTableViewCell.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HistoryDetailTableViewCell.h"

@implementation HistoryDetailTableViewCell

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
    _typeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 5, SCREEN_W*0.05, 30)];
    _typeText = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.15, 5, SCREEN_W*0.2, 30)];
    
    _proportionIcon = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W*0.65, 5, SCREEN_W*0.05, 30)];
    _proportionText = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.75, 5, SCREEN_W*0.2, 30)];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 41, SCREEN_W*0.9, 1)];
    _line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 40, SCREEN_W*0.45, 20)];
    _week = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.5, 40, SCREEN_W*0.45, 20)];
    
    _sum_table = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 60, SCREEN_W*0.3, 20)];
    _sum_people = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.35, 60, SCREEN_W*0.3, 20)];
    _avg_people = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.65, 60, SCREEN_W*0.3, 20)];
    
    _sum_goods_amount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.05, 80, SCREEN_W*0.3, 20)];
    _sum_order_amount = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.35, 80, SCREEN_W*0.3, 20)];
    _sum_chae = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.65, 80, SCREEN_W*0.3, 20)];
    
    _typeIcon.contentMode = UIViewContentModeCenter;
    _proportionIcon.contentMode = UIViewContentModeCenter;
    
    _typeText.font = [UIFont systemFontOfSize:FONT(13)];
    _typeText.textColor = [UIColor grayColor];
    _proportionText.font = [UIFont systemFontOfSize:FONT(13)];
    _proportionText.textColor = [UIColor orangeColor];
    
    _date.font = [UIFont systemFontOfSize:FONT(11)];
    _date.textColor = [UIColor grayColor];
    _sum_table.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_table.textColor = [UIColor grayColor];
    _sum_people.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_people.textColor = [UIColor grayColor];
    _avg_people.font = [UIFont systemFontOfSize:FONT(11)];
    _avg_people.textColor = [UIColor grayColor];
    _sum_goods_amount.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_goods_amount.textColor = [UIColor grayColor];
    _sum_order_amount.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_order_amount.textColor = [UIColor grayColor];
    _sum_chae.font = [UIFont systemFontOfSize:FONT(11)];
    _sum_chae.textColor = [UIColor grayColor];
    _week.font = [UIFont systemFontOfSize:FONT(11)];
    _week.textColor = [UIColor colorWithRed:248/255.0 green:82/255.0 blue:61/255.0 alpha:1];

    
    [self.contentView addSubview:_typeIcon];
    [self.contentView addSubview:_typeText];
    [self.contentView addSubview:_proportionIcon];
    [self.contentView addSubview:_proportionText];
    [self.contentView addSubview:_line];
    [self.contentView addSubview:_date];
    [self.contentView addSubview:_week];
    [self.contentView addSubview:_sum_table];
    [self.contentView addSubview:_sum_people];
    [self.contentView addSubview:_avg_people];
    [self.contentView addSubview:_sum_goods_amount];
    [self.contentView addSubview:_sum_order_amount];
    [self.contentView addSubview:_sum_chae];
    
}
@end
