//
//  HistoryDetailTableViewCell.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface HistoryDetailTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *typeIcon;

@property (nonatomic,strong) UIImageView *proportionIcon;

@property (nonatomic,strong) UILabel *typeText;

@property (nonatomic,strong) UILabel *proportionText;

@property (nonatomic,strong) UILabel *date;

@property (nonatomic,strong) UILabel *week;

@property (nonatomic,strong) UILabel *sum_goods_amount;

@property (nonatomic,strong) UILabel *sum_people;

@property (nonatomic,strong) UILabel *avg_people;

@property (nonatomic,strong) UILabel *sum_chae;

@property (nonatomic,strong) UILabel *sum_order_amount;

@property (nonatomic,strong) UILabel *sum_table;

@property (nonatomic,strong) UIView *line;

@end
