//
//  Date.h
//  TinyShop
//
//  Created by 曹晓东 on 2017/1/3.
//  Copyright © 2017年 CXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject

+(NSString*)getCurrentDate;
+(NSString *)getNineDaysAgo;
+(NSString *)getFiveDaysAgo;

@end
