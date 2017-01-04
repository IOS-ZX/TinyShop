//
//  OrderModel.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"types" : @"TypeModel"};
}

@end
