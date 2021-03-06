//
//  HomeTableViewCell.m
//  TinyShop
//
//  Created by Mac on 16/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadInterFace];
    }
    return self;
}

-(void)loadInterFace{
    _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, SCREEN_W*0.05, SCREEN_W * 0.21)];
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(50+SCREEN_W*0.05, 0, SCREEN_W*0.4, 50)];
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(50+SCREEN_W*0.05, 50, SCREEN_W*0.4, 50)];
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(30+SCREEN_W*0.45, 50, SCREEN_W*0.2, 50)];
    _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(30+SCREEN_W*0.75, 30, 40, 40)];
    _label1.font = [UIFont systemFontOfSize:FONT(20) weight:1];
    _label1.textColor = [UIColor blackColor];
    _label2.font = [UIFont systemFontOfSize:FONT(14)];
    _label2.textColor = [UIColor lightGrayColor];
    _label3.font = [UIFont systemFontOfSize:FONT(14)];
    _label3.textColor = [UIColor lightGrayColor];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 98, SCREEN_W, 2)];
    bottomLine.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    [self.contentView addSubview:bottomLine];
    [self.contentView addSubview:_leftImage];
    [self.contentView addSubview:_label1];
    [self.contentView addSubview:_label2];
    [self.contentView addSubview:_label3];
    [self.contentView addSubview:_rightImage];
    
//    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(0);
//        make.right.equalTo(self.mas_right).offset(30);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_W*0.05, SCREEN_W * 0.21));
////        make.size.mas_equalTo(CGSizeMake(SCREEN_W*0.05, SCREEN_W * 0.21);
//        
//    }];
    
}


@end
