//
//  MZBarChartView.h
//  TinyShop_x
//
//  Created by MrZhao on 16/12/25.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZLineView.h"
#import "Masonry.h"

@interface MZBarChartView : UIView

@property(nonatomic, strong) NSArray *titleStore;
@property(nonatomic, strong) NSArray *incomeStore;
@property(nonatomic, strong) NSArray *colorStore;
@property(nonatomic, strong) NSArray *allTypes;
//一个网格宽度
@property(nonatomic, assign) CGFloat singleWidth;
//柱状图宽度所占网格宽度 的比例 默认0.55
@property(nonatomic, assign) CGFloat barWidthPercent;

@property(nonatomic, assign) CGFloat bottomMargin;
//titleLabel transfrom
@property(nonatomic, assign) CGAffineTransform labelTransform;
//收入top 边距
@property(nonatomic, assign) CGFloat incomeBottomMargin;
//收入底部边距
@property(nonatomic, assign) CGFloat incomeTopMargin;
//总收入文字回调
@property(nonatomic, copy) TopTitleCallBack topTitleCallBack;
//当前选中下标 默认为－1 没有选中
@property(nonatomic, assign) NSInteger selectIndex;
//选中回调
@property(nonatomic, copy) SelectCallBack selectCallback;
//收入前缀
@property(nonatomic, copy) NSString *brefixStr;
//收入后缀
@property(nonatomic, copy) NSString *suffixStr;
//收入小数位数
@property(nonatomic, assign)NSUInteger floatNumber;

//显示所有类型
//- (void)showAllType;
//显示或者隐藏某些类型
- (BOOL)hiddenOrShowTyped:(NSUInteger)typeIndex hiddenSign:(BOOL)sign;
//绘图
- (void)storkePath;


@end
