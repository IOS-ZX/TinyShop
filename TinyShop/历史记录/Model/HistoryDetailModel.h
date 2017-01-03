//
//  HistoryDetailModel.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/29.
//  Copyright © 2016年 Mac. All rights reserved.
//
/*
 历史记录营业记录的食堂和外卖列表
 */
#import <Foundation/Foundation.h>

@interface HistoryDetailModel : NSObject

//应收金额
@property (nonatomic,strong) NSString *sum_goods_amount;
//人数
@property (nonatomic,strong) NSString *sum_people;
//人均消费金额
@property (nonatomic,strong) NSString *avg_people;
//差额
@property (nonatomic,strong) NSString *sum_chae;
//实际收入
@property (nonatomic,strong) NSString *sum_order_amount;
//桌数
@property (nonatomic,strong) NSString *sum_table;


@end
