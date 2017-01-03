//
//  GoodsTableViewCell.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@interface GoodsTableViewCell : UITableViewCell

@property (nonatomic,strong)GoodsModel *goodModel;
@property (nonatomic,strong)UIColor *leftColor;
@property (nonatomic,strong)UIColor *rightColor;

@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;
@property (nonatomic,strong)UILabel *goodNameLabel;
@property (nonatomic,strong)UILabel *goodUnitPriceLabel;
@property (nonatomic,strong)UILabel *goodNumLabel;
@property (nonatomic,strong)UILabel *goodTotalPriceLabel;
@property (nonatomic,assign) CGFloat goodCellHeight;

@end
