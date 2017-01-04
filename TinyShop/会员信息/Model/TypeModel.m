//
//  TypeModel.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "TypeModel.h"

@implementation TypeModel

/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"goods" : @"GoodsModel"};
}

-(CGFloat)goodCellHeight
{
    if (_goodCellHeight > 0) {
        return _goodCellHeight;
        
    }
    _goodCellHeight = 70;
    return _goodCellHeight;
}

-(CGFloat)typeCellHeight
{
    if (_typeCellHeight > 0) {
        return _typeCellHeight;
    }
    _typeCellHeight = self.goods.count * (self.goodCellHeight) + 8 ;
    if (self.typeCellIndex == 0) {
        _typeCellHeight += 40;
    }
    return _typeCellHeight;
}

@end
