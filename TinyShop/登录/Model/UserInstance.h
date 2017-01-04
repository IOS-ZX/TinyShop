//
//  UserInstance.h
//  TinyShop
//
//  Created by MrZhao on 16/12/22.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shopModel.h"
@interface UserInstance : NSObject

+(UserInstance *)sharedUserInstance;

/** 访问令牌*/
@property(nonatomic,copy) NSString *accessToken;
/** 账号登陆进来存在的所有商铺*/
@property(nonatomic,strong) ShopModel *userShop;
/** 登录员工id*/
@property(nonatomic,copy) NSString *mgrBaseId;
/** 员工所属店铺id*/
@property(nonatomic,copy) NSString *mgrShopId;
/** 登录员工权限*/
@property(nonatomic,copy) NSArray *rights;
/** 判断该店铺是否有子店铺*/
-(BOOL)isExistSubShop;

/** 所有店铺ID*/ //12,13,14,15 或 12

- (NSString *)allShopIDs;

- (NSArray *)allShop;

- (NSString *)getShopIdByShopName:(NSString *)name;

- (NSString *)getNameBySHopId:(NSString *)shopId;

//get参数
- (NSString *)getParamsString;

@end
