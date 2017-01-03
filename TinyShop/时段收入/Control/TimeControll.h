//
//  TimeControll.h
//  TinyShop
//
//  Created by rimi on 2016/12/24.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeControll : NSObject

typedef void(^SuccessResult)(NSArray *titles,NSArray *values);

+ (void)timeIncomeRequest:(SuccessResult)succesResult shopId:(NSString*)shopId;

+ (void)subgraphRequest:(SuccessResult)succesResult shopId:(NSString*)shopId time:(NSString*)time;

@end
