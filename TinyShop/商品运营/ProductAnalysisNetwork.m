//
//  ProductAnalysisNetwork.m
//  TinyShop
//
//  Created by 曹晓东 on 2016/12/29.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ProductAnalysisNetwork.h"

@implementation ProductAnalysisNetwork

+(void)shopingNetworking:(NSString *)sales_copies type_name:(NSString *)type_name goods_name:(NSString *)goods_name query:(NSString *)query s_time:(NSString *)s_time e_time:(NSString *)e_time
{
    [NetTool checkRequest:@"goodsTimeAction" loadingMessage:@"加载中" parameter:@{@"body":@{@"shop_id":[UserInstance sharedUserInstance].allShopIDs,@"sales_copies":sales_copies,@"type_name":type_name,@"goods_name":goods_name,@"query":query,@"s_time":s_time,@"e_time":e_time}} success:^(NSDictionary *result) {
        NSLog(@"result:%@",result);
    } error:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
}

////得到年月日
//-(void)gainTime
//{
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY"];
//    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    NSLog(@"dateString:%@",dateString);
//    
//    
//    
//    
//}

@end
