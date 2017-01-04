//
//  VipModel.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/24.
//  Copyright © 2016年 Mac. All rights reserved.
//
/*
    根据所选的单店的所有会员信息
 */
#import <Foundation/Foundation.h>

@interface VipModel : NSObject

//所属店铺的id
@property (nonatomic,strong) NSString *shop_id;
//所属店铺的名字
@property (nonatomic,strong) NSString *shop_name;
//多少折扣的会员
@property (nonatomic,strong) NSString *sigd_discount;
//会员的ID
@property (nonatomic,strong) NSString *userId;
//会员性别 0为女士 1为男士
@property (nonatomic,strong) NSString *userSex;
//会员的总消费
@property (nonatomic,strong) NSString *uvgrade_consume_money;
//会员预存款
@property (nonatomic,strong) NSString *uvgrade_money;
//
@property (nonatomic,strong) NSString *uvgrade_recharge_all_money;
//VIP的ID
@property (nonatomic,strong) NSString *vip_base_id;
//VIP的手机号码
@property (nonatomic,strong) NSString *vip_mobile;
//VIP客户的名字
@property (nonatomic,strong) NSString *vip_nickname;


@end
