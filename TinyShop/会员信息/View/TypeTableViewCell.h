//
//  TypeTableViewCell.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeModel.h"
#import "GoodsTableViewCell.h"

@interface TypeTableViewCell : UITableViewCell

//类型背景
@property (nonatomic,strong) UIView *typeBackground;
//类型label
@property (nonatomic,strong) UILabel *typeLabel;
//订单详情
@property (nonatomic,strong) UILabel *detialLabel;
//对应此类型的食物tableview
@property (nonatomic,strong) UITableView *goodsTableView;
//对应的类型model
@property (nonatomic,strong) TypeModel *typeModel;

@end
