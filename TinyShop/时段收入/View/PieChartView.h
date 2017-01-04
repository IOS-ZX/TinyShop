//
//  PieChartView.h
//  TinyShop
//
//  Created by rimi on 2016/12/27.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZPieChartDataSet.h"
#import "MZPieChartFontColorSet.h"
#import "MZPieChartView.h"

@interface PieChartView : UIView

/** data **/
@property(nonatomic,strong)MZPieChartDataSet *dataSet;
/** colors **/
@property(nonatomic,strong)MZPieChartFontColorSet *colors;
/** 选中回调 **/
@property(nonatomic,copy)SelectCallBack selects;
/** 取消选中 **/
@property(nonatomic,strong)DeselectCallBack deselects;
/** 详细界面 **/
@property(nonatomic,assign)BOOL isDetail;

- (void)stroke;

@end
