//
//  shopModel.h
//  微掌柜
//
//  Created by dandan on 16/3/25.
//  Copyright © 2016年 dandan. All rights reserved.
//
//已登录用户所属店铺信息，如果没有店铺信息，shop的值为：null

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
/** 店铺id*/
@property(nonatomic,copy) NSString *shop_id;
/** 店铺类型0—供应商店铺 1—普通店铺*/
@property(nonatomic,copy) NSString *shop_type;
/** 店铺名称*/
@property(nonatomic,copy) NSString *shop_name;
/** 店铺帐户名*/
@property(nonatomic,copy) NSString *shop_account;
/** 往后延迟扎帐时间，单位：小时*/
@property(nonatomic,copy) NSString *shop_sumtimeoffset;
/** 店铺服务有效期开始时间*/
@property(nonatomic,copy) NSString *shop_EffDateBegin;
/** 店铺服务有效期结束时间*/
@property(nonatomic,copy) NSString *shop_EffDateEnd;
/** 会员充值赠送金额计算比例*/
@property(nonatomic,copy) NSString *charge_money_send_percent;
/** 该url即店铺公众号二维码，如果无公众号为空字符串*/
@property(nonatomic,copy) NSString *shop_qrcode_url;
/** 二维码宣传语的字段*/
@property(nonatomic,copy) NSString *shop_qrCode_pro;
/** 子店铺列表，如果没有子店铺则为 null*/
@property(nonatomic,strong) NSArray *subs;

-(BOOL)shopIsHaveSubShop;

@end
