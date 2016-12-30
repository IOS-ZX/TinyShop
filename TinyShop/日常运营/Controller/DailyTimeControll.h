//
//  DailyTimeControll.h
//  TinyShop
//
//  Created by rimi on 2016/12/28.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RequestDataType) {
    sales = 0,
    order_num = 1,
    people_num = 2,
    people_avg = 3,
    avg_meal = 4
};

typedef NS_ENUM(NSInteger,RequestQueryType) {
    day = 3,
    week = 2,
    month = 1,
    year = 0
};

@interface DailyTimeControll : NSObject

typedef void(^SuccessResult)(NSArray *titles,NSArray* values);
typedef void(^SubSuccessResult)(NSDictionary *dic);

+ (void)dailyTimeRequest:(SuccessResult)succesResult
                  shopId:(NSString*)shopId
         statisticalType:(RequestDataType)type
                   query:(RequestQueryType)query
                   sTime:(NSString*)s_time
                   eTime:(NSString*)e_time;

+ (void)subDailyTimeRequest:(SuccessResult)succesResult
                  shopId:(NSString*)shopId
         statisticalType:(RequestDataType)type
                   query:(RequestQueryType)query
                   time:(NSString*)time;

@end
