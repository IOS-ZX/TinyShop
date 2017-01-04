//
//  UserInstance.m
//  TinyShop
//
//  Created by MrZhao on 16/12/22.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import "UserInstance.h"
#import "NSString+MD5.h"
@implementation UserInstance

+(UserInstance *)sharedUserInstance
{
    static UserInstance *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    return instance;
}

-(BOOL)isExistSubShop
{
    if(self.userShop && (self.userShop.subs.count!=0))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(NSString *)allShopIDs
{
    NSMutableArray *arrM=[NSMutableArray array];
    if (self.userShop.shop_id) {
         [arrM addObject:self.userShop.shop_id];
    }
    if(self.userShop.subs.count)
    {
        [self.userShop.subs enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
            ShopModel *model=(ShopModel *)obj;
            NSString *shopId= [model valueForKey:@"shop_id"];
            [arrM addObject:shopId];
        }];
    }
    if (arrM.count == 0) {
        return @"";
    }
    return [arrM componentsJoinedByString:@","];
}

- (NSArray *)allShop{
    __block NSMutableArray *shops = [NSMutableArray array];
    if (self.userShop.shop_name) {
        [shops addObject:self.userShop];
    }
    if (self.userShop.subs.count > 0) {
        [self.userShop.subs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ShopModel *model = (ShopModel*)obj;
            [shops addObject:model];
        }];
    }
    return shops;
}


- (NSString *)getParamsString
{
    NSMutableString *paramString = [NSMutableString string];
    [paramString appendString:@"client_type=ios"];
    [paramString appendString:@"&client_version=2.0"];
    [paramString appendString:@"&client_token=2a8242f0858bbbde9c5dcbd0a0008e5a"];
    [paramString appendFormat:@"&shop_id=%@",self.mgrShopId];
    [paramString appendFormat:@"&mgr_base_id=%@",self.mgrBaseId];
    [paramString appendFormat:@"&access_token=%@",self.accessToken];
    [paramString appendFormat:@"&mac_code="];
    [paramString appendFormat:@"&key=%@",[paramString MD5]];
    return paramString;
}

- (NSString *)getShopIdByShopName:(NSString *)name{
    __block NSString *shopId;
    if ([name isEqualToString:self.userShop.shop_name]) {
        return self.userShop.shop_id;
    }
    [self.userShop.subs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShopModel *model=(ShopModel *)obj;
        if ([name isEqualToString:[model valueForKey:@"shop_name"]]) {
            shopId= [model valueForKey:@"shop_id"];
            *stop = YES;
        }
    }];
    return shopId;
}

- (NSString *)getNameBySHopId:(NSString *)shopId{
    __block NSString *name;
    if ([shopId isEqualToString:self.userShop.shop_id]) {
        return self.userShop.shop_name;
    }
    [self.userShop.subs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShopModel *model=(ShopModel *)obj;
        if ([shopId isEqualToString:[model valueForKey:@"shop_id"]]) {
            name = [model valueForKey:@"shop_name"];
            *stop = YES;
        }
    }];
    return name;
}

@end
