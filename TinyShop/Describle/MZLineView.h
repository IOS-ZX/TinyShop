//
//  MZLineView.h
//  TinyShop_x
//
//  Created by MrZhao on 16/12/23.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NSString *(^TopTitleCallBack)(CGFloat sumValue);
typedef void(^SelectCallBack)(NSUInteger);
@interface MZLineView : UIView

@property(nonatomic, strong) NSArray *titleStore;
@property(nonatomic, strong) NSArray *incomeStore;
//一个网格宽度
@property(nonatomic, assign) CGFloat singleWidth;
/** 标题后缀 **/
@property(nonatomic,strong)NSString *titleStr;
//
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
//饼状分析图图标
@property(nonatomic, strong) UIButton *selectButton;
//选中回调
@property(nonatomic, copy) SelectCallBack selectCallback;
//收入前缀
@property(nonatomic, copy) NSString *brefixStr;
//收入后缀
@property(nonatomic, copy) NSString *suffixStr;
//收入小数位数
@property(nonatomic, assign) NSUInteger floatNumber;

//绘图
- (void)storkePath;

@end


#define noDisableVerticalScrollTag 836913
#define noDisableHorizontalScrollTag 836914

@interface UIImageView (ForScrollView)

@end

