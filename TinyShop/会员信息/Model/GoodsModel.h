//
//  GoodsModel.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@interface GoodsModel : NSObject

/** 菜品分类名称*/
@property(nonatomic,copy) NSString *kindName;
/** 商品类型*/
@property(nonatomic,copy) NSString *foodType;
/** 菜名*/
@property(nonatomic,copy) NSString *name;
/** 售价*/
@property(nonatomic,copy) NSString *price;
/** 销售数量*/
@property(nonatomic,copy) NSString *count;
/** 单位*/
@property(nonatomic,copy) NSString *unit;
/** 折扣*/
@property(nonatomic,copy) NSString *discount;
/** 子菜品*/
@property(nonatomic,strong) NSArray *subs;

@end
