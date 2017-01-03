//
//  DailyTimeControll.m
//  TinyShop
//
//  Created by rimi on 2016/12/28.
//  Copyright © 2016年 CXD. All rights reserved.
//

#define STRING(value) [NSString stringWithFormat:@"%@",value]

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
+ (void)subDailyTimeRequest:(subSuccessResult)succesResult
                     shopId:(NSString *)shopId
            statisticalType:(RequestDataType)type
                      query:(RequestQueryType)query
                       time:(NSString *)time
{
    NSArray *dataArray = @[@"sales",@"order_num",@"people_num",@"people_avg",@"avg_meal"];
    NSArray *queryArray = @[@"year",@"month",@"week",@"day"];
    NSDictionary *para = @{@"body":@{@"shop_id":shopId,@"statistical_type":dataArray[type],@"query":queryArray[query],@"time":time}};
    [NetTool checkRequest:@"dailyScaleAction" loadingMessage:@"加载中..." parameter:para success:^(NSDictionary *result) {
//        NSLog(@"result:%@",result);
        [self makeSubDatas:result type:type result:succesResult];
    } error:^(NSError *error) {
        [MBProgressHUD showError:@"服务器开小差了。"];
    }];
}

// 处理子图数据
+ (void)makeSubDatas:(NSDictionary *)dic type:(RequestDataType)type result:(subSuccessResult)reslut{
    switch (type) {
        case sales:
            [self makeSales:dic result:reslut];
            break;
        default:
            [self makeOtherData:dic result:reslut];
            break;
    }
}

// 处理数据（桌数、人数、人均、餐时）
+ (void)makeOtherData:(NSDictionary *)dic
               result:(subSuccessResult)reslut
{
    NSArray *keys = [dic[@"body"] allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    __block NSMutableArray *detail = [NSMutableArray array];
    __block NSMutableArray *main = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [detail addObject:[self makeSubDetailData:dic[@"body"][key]]];
        NSArray *sk = [key componentsSeparatedByString:@"_"];
        if (sk.count > 2) {
            NSString *shopid = STRING(sk[2]);
            [main addObject:[self makeMainSumData:dic[@"body"][key] shopId:shopid]];
        }
    }];
    reslut(main,detail,nil,nil);
}

// 主图（桌数、人数、人均、餐时）
+ (NSDictionary *)makeMainSumData:(NSDictionary *)dic shopId:(NSString *)shopid{
    NSArray *keys = [dic allKeys];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    __block CGFloat sum = 0;
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += [dic[key] floatValue];
    }];
    NSString *name = [[UserInstance sharedUserInstance]getNameBySHopId:shopid];
    [data setObject:STRING(@(sum)) forKey:@"value"];
    [data setObject:name forKey:@"title"];
    return data;
}

// 详细数据（桌数、人数、人均、餐时）
+ (NSArray *)makeSubDetailData:(NSDictionary *)dic{
    __block NSMutableArray *detail = [NSMutableArray array];
    NSArray *keys = [dic allKeys];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:STRING(dic[key]) forKey:@"value"];
        [data setObject:key forKey:@"title"];
        [detail addObject:data];
    }];
    return detail;
}

// 处理销售额数据
+ (void)makeSales:(NSDictionary *)dic
           result:(subSuccessResult)reslut
{
    NSArray *branchKeys = [dic[@"body"][@"real_time"][@"branch"] allKeys];
    branchKeys = [branchKeys sortedArrayUsingSelector:@selector(compare:)];
    __block NSMutableArray *branchValues = [NSMutableArray array];
    __block NSMutableArray *branchDetail = [NSMutableArray array];
    __block NSMutableArray *branchWay = [NSMutableArray array];
    __block NSMutableArray *branchVip = [NSMutableArray array];
    [branchKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:STRING(dic[@"body"][@"real_time"][@"branch"][key]) forKey:@"value"];
        NSArray *value = [key componentsSeparatedByString:@"_"];
        if (value.count > 2) {
            [data setObject:[[UserInstance sharedUserInstance]getNameBySHopId:value[2]] forKey:@"title"];
        }
        [branchValues addObject:data];
        NSArray *arr = [self periodTime:dic[@"body"][@"real_time"][@"period_time"][key]];
        [branchDetail addObject:arr];
        NSDictionary *vipData = dic[@"body"][@"vip"][key];
        [branchVip addObject:[self makeVipData:vipData]];
        [branchWay addObject:[self makeWay:dic[@"body"][@"way"][key]]];
    }];
    reslut(branchValues,branchDetail,branchWay,branchVip);
}

+ (NSArray *)periodTime:(NSDictionary *)dic{
    NSArray *allKey = [dic allKeys];
    __block NSMutableArray *branchDetail = [NSMutableArray array];
    [allKey enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:key forKey:@"title"];
        [data setObject:STRING(dic[key]) forKey:@"value"];
        [branchDetail addObject:data];
    }];
    return branchDetail;
}

+ (NSArray *)makeWay:(NSDictionary *)dic{
    NSArray *keys = [dic allKeys];
    __block NSMutableArray *way = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:key forKey:@"title"];
        [data setObject:STRING(dic[key]) forKey:@"value"];
        [way addObject:data];
    }];
    return way;
}

+ (NSArray *)makeVipData:(NSDictionary *)dic{
    NSArray *keys = [dic allKeys];
    __block NSMutableArray *vip = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        if ([key isEqualToString:@"vip"]) {
            [data setObject:@"会员" forKey:@"title"];
        }else{
            [data setObject:@"非会员" forKey:@"title"];
        }
        [data setObject:STRING(dic[key]) forKey:@"value"];
        [vip addObject:data];
    }];
    return vip;
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
