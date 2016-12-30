//
//  DailyTimeControll.m
//  TinyShop
//
//  Created by rimi on 2016/12/28.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "DailyTimeControll.h"

@interface DailyTimeControll()

/** 数据类型 **/
@property(nonatomic,strong)NSArray *dataArray;
/** 统计类型 **/
@property(nonatomic,strong)NSArray *queryArray;

@end

@implementation DailyTimeControll

// 主图请求
+ (void)dailyTimeRequest:(SuccessResult)succesResult
                  shopId:(NSString *)shopId
         statisticalType:(RequestDataType)type
                   query:(RequestQueryType)query
                   sTime:(NSString *)s_time
                   eTime:(NSString *)e_time
{
    NSArray *dataArray = @[@"sales",@"order_num",@"people_num",@"people_avg",@"avg_meal"];
    NSArray *queryArray = @[@"year",@"month",@"week",@"day"];
    NSDictionary *para = @{@"body":@{@"shop_id":shopId,@"statistical_type":dataArray[type],@"query":queryArray[query],@"s_time":s_time,@"e_time":e_time}};
    //请求数据
    [NetTool checkRequest:@"dailyTimeAction" loadingMessage:@"加载中.." parameter:para success:^(NSDictionary *result) {
        NSLog(@"datas:%@",result);
        [self makeTitleDatas:result success:succesResult];
    } error:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

// 子图请求
+ (void)subDailyTimeRequest:(SuccessResult)succesResult
                     shopId:(NSString *)shopId
            statisticalType:(RequestDataType)type
                      query:(RequestQueryType)query
                       time:(NSString *)time
{
    NSArray *dataArray = @[@"sales",@"order_num",@"people_num",@"people_avg",@"avg_meal"];
    NSArray *queryArray = @[@"year",@"month",@"week",@"day"];
    NSDictionary *para = @{@"body":@{@"shop_id":shopId,@"statistical_type":dataArray[type],@"query":queryArray[query],@"time":time}};
    [NetTool checkRequest:@"dailyScaleAction" loadingMessage:@"加载中..." parameter:para success:^(NSDictionary *result) {
        
    } error:^(NSError *error) {
        
    }];
}

// 处理子图数据
+ (void)makeSubDatas:(NSDictionary *)dic type:(RequestDataType)type{
    
}

// 处理主图数据
+ (void)makeTitleDatas:(NSDictionary*)dic
                    success:(SuccessResult)succesResult
{
    if ([dic[@"body"] count] == 0) {
        return;
    }
    NSArray *keys = [dic[@"body"] allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    __block NSMutableArray *arr = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:dic[@"body"][key]];
    }];
    succesResult(keys,arr);
}

@end
