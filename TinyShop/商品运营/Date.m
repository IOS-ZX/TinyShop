//
//  Date.m
//  TinyShop
//
//  Created by 曹晓东 on 2017/1/3.
//  Copyright © 2017年 CXD. All rights reserved.
//

#import "Date.h"

@implementation Date

+(NSString *)getCurrentDate{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)getNineDaysAgo{
    //得到当前的时间
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* nowDate = [NSDate date];
    NSDate* theDate;
    
    NSTimeInterval  oneDay = 24*60*60*1;
    //1天的长度
    theDate = [nowDate initWithTimeIntervalSinceNow:-oneDay*8];
    return [dateFormatter stringFromDate:theDate];
}

+(NSString *)getFiveDaysAgo{
    //得到当前的时间
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* nowDate = [NSDate date];
    NSDate* theDate;
    
    NSTimeInterval  oneDay = 24*60*60*1;
    //1天的长度
    theDate = [nowDate initWithTimeIntervalSinceNow:-oneDay*5];
    return [dateFormatter stringFromDate:theDate];
}

@end
