//
//  shopModel.m
//  微掌柜
//
//  Created by dandan on 16/3/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

-(NSDictionary *)objectClassInArray
{
    return @{@"subs":[ShopModel class]};
}

-(BOOL)shopIsHaveSubShop
{
    return self.subs.count > 0;
}
@end
