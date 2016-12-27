//
//  TimeControll.m
//  TinyShop
//
//  Created by rimi on 2016/12/24.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "TimeControll.h"

@implementation TimeControll

// 获取数据
+ (void)timeIncomeRequest:(SuccessResult)succesResult shopId:(NSString*)shopId{
    [NetTool checkRequest:@"incomeTimeAction" loadingMessage:@"加载中.." parameter:@{@"body":@{@"shop_id":shopId}} success:^(NSDictionary *result) {
        NSMutableArray *resultData = [NSMutableArray array];
        NSDictionary *dic = result[@"body"][@"value"];
        NSArray *keys = [self getKeys:dic];
        for (NSNumber *key in keys) {
            if (!dic[key]) {
                [resultData addObject:@0];
            }else{
                [resultData addObject:dic[key]];
            }
        }
        succesResult([self stringForNumber:keys],[self stringForNumber:resultData]);
    } error:^(NSError *error) {
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
}

// 排序处理
+ (NSArray *)getKeys:(NSDictionary*)dic{
    NSDate *date = [NSDate new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    NSString *now = [formatter stringFromDate:date];
    NSMutableArray *resultKeys = [NSMutableArray arrayWithCapacity:24];
    for (NSInteger index = 0; index < dic.allKeys.count; index ++) {
        [resultKeys addObject:@"0"];
    }
    for (NSInteger index = 0; index < dic.allKeys.count; index++) {
        NSNumber *num = dic.allKeys[index];
        if (num.integerValue - now.integerValue >= 0) {
            resultKeys[num.integerValue - now.integerValue] = num;
        }else if (num.integerValue - now.integerValue == -now.integerValue) {
            resultKeys[23 - now.integerValue] = num;
        } else{
            resultKeys[23 - now.integerValue + num.integerValue + 1] = num;
        }
    }
    return resultKeys;
}

// Number 转 String
+ (NSArray *)stringForNumber:(NSArray*)numbers{
    NSMutableArray *array = [NSMutableArray array];
    [numbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string = [NSString stringWithFormat:@"%@",obj];
        [array addObject:string];
    }];
    return array;
}
@end
