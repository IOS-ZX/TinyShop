//
//  GoodsTableViewCell.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "Masonry.h"

@implementation GoodsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftView];
        [self.contentView addSubview:self.rightView];
        [self.leftView addSubview:self.goodNameLabel];
        [self.leftView addSubview:self.goodUnitPriceLabel];
        [self.rightView addSubview:self.goodNumLabel];
        [self.rightView addSubview:self.goodTotalPriceLabel];
        
        __weak typeof(self) weakSelf = self;
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(weakSelf).offset(-2);
            make.top.equalTo(weakSelf);
            make.width.equalTo(weakSelf).multipliedBy(0.38);
            make.left.equalTo(weakSelf);
        }];
        
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.leftView.mas_right).offset(2);
            make.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf.leftView);
            make.height.equalTo(weakSelf.leftView);
        }];
        
        [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.leftView).offset(3);
            make.right.equalTo(weakSelf.leftView);
            make.top.equalTo(weakSelf.leftView);
            make.height.equalTo(weakSelf.leftView).multipliedBy(0.35);
        }];
        [self.goodUnitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.leftView);
            make.right.equalTo(weakSelf.leftView).offset(-3);
            make.bottom.equalTo(weakSelf.leftView);
            make.height.equalTo(weakSelf.leftView).multipliedBy(0.35);
        }];
        [self.goodNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.rightView);
            make.width.equalTo(weakSelf.rightView).multipliedBy(0.35);
            make.bottom.equalTo(weakSelf.rightView);
            make.height.equalTo(weakSelf.rightView).multipliedBy(0.5);
        }];
        [self.goodTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.goodNumLabel.mas_right);
            make.right.equalTo(weakSelf.rightView);
            make.bottom.equalTo(weakSelf.rightView);
            make.height.equalTo(weakSelf.rightView).multipliedBy(0.5);
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark- Getter
-(UIView *)leftView
{
    if (!_leftView) {
        _leftView = [[UIView alloc]init];
    }
    return _leftView;
}
-(UIView *)rightView
{
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
    }
    return _rightView;
}

-(UILabel *)goodNameLabel
{
    if (!_goodNameLabel) {
        _goodNameLabel = [[UILabel alloc]init];
        _goodNameLabel.textColor = [UIColor whiteColor];
        _goodNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goodNameLabel;
    
}
-(UILabel *)goodUnitPriceLabel
{
    if (!_goodUnitPriceLabel) {
        _goodUnitPriceLabel = [[UILabel alloc]init];
        _goodUnitPriceLabel.textColor = [UIColor whiteColor];
        _goodUnitPriceLabel.font = [UIFont systemFontOfSize:13];
        _goodUnitPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _goodUnitPriceLabel;
}
-(UILabel *)goodNumLabel
{
    if (!_goodNumLabel) {
        _goodNumLabel = [[UILabel alloc]init];
        _goodNumLabel.textAlignment = NSTextAlignmentCenter;
        _goodNumLabel.textColor = [UIColor whiteColor];
        _goodNumLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goodNumLabel;
}
-(UILabel *)goodTotalPriceLabel
{
    if (!_goodTotalPriceLabel) {
        _goodTotalPriceLabel = [[UILabel alloc]init];
        _goodTotalPriceLabel.textAlignment = NSTextAlignmentCenter;
        _goodTotalPriceLabel.textColor = [UIColor whiteColor];
        _goodTotalPriceLabel.font = [UIFont systemFontOfSize:17.0];
    }
    return _goodTotalPriceLabel;
}
#pragma mark- Setter
-(void)setGoodModel:(GoodsModel *)goodModel
{
    _goodModel = goodModel;
    self.leftView.backgroundColor = self.leftColor;
    self.rightView.backgroundColor = self.rightColor;
    self.goodNameLabel.text = goodModel.name;
    self.goodUnitPriceLabel.text = [NSString stringWithFormat:@"%.2f元/%@",[goodModel.price floatValue],goodModel.unit];
    self.goodNumLabel.text = [NSString stringWithFormat:@"%@%@",goodModel.count,goodModel.unit];
    self.goodTotalPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[goodModel.price floatValue] * [goodModel.count floatValue]];
    
    
}

@end
