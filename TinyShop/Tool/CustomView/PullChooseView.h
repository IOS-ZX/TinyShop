//
//  PullChooseView.h
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PullChooseViewDelegate <NSObject>

- (void)pullChooseViewItemClick:(NSInteger)index;

@end

@interface PullChooseView : UIView

/** 中心点 **/
@property(nonatomic,assign)CGPoint centerPoint;

/** 三角形的颜色 **/
@property(nonatomic,strong)UIColor    *triangleColor;

/** items **/
@property(nonatomic,strong)NSArray *items;

/** 代理 **/
@property(nonatomic,assign)id<PullChooseViewDelegate> delegate;

- (instancetype)initWithItems:(NSArray *)items;

- (void)showView;

- (void)hiddenView;

@end
