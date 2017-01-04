//
//  MemberTableViewCell.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MemberTableViewCell.h"

@implementation MemberTableViewCell

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
    _vip_nickname = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_W*0.5, 40)];
    _vip_mobile = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, SCREEN_W*0.5, 40)];
    _uvgrade_money = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W*0.5+20, 40, SCREEN_W*0.5-20, 40)];
    _vip_mobile.textColor = [UIColor lightGrayColor];
    _uvgrade_money.textColor = [UIColor grayColor];
    
    [self.contentView addSubview:_vip_nickname];
    [self.contentView addSubview:_vip_mobile];
    [self.contentView addSubview:_uvgrade_money];
}

@end
