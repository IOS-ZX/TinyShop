//
//  MyPieChartView.h
//  TinyShop
//
//  Created by rimi on 2016/12/28.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPieChartView : UIView

/** data **/
@property(nonatomic,strong)NSDictionary *data;
/** shopID **/
@property(nonatomic,strong)NSString *shopId;

/** 主图数据 **/
@property(nonatomic,strong)NSArray *dataArray;

/** 详图数据 **/
@property(nonatomic,strong)NSArray *detailArray;

@end
