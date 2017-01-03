//
//  TypeModel.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsModel.h"
#import <MJExtension.h>
#import <UIKit/UIKit.h>

@interface TypeModel : NSObject

//食物类型
@property (nonatomic,copy) NSString *kindName;
//对应类型下的 食物
@property (nonatomic,copy) NSArray *goods;
//第几个type cell
@property (nonatomic,assign) NSUInteger typeCellIndex;

//type cell 的高度
@property (nonatomic,assign) CGFloat typeCellHeight;

//good cell 高度
@property (nonatomic,assign) CGFloat goodCellHeight;

@end
