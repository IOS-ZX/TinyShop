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
{
    NSArray *_items;
    UIView *_contentView;
    CGFloat _maxWidth;
    CGPoint _pointA;
    CGPoint _pointB;
    CGPoint _pointC;
    UITableView *_tableView;
}

/** 中心点 **/
@property(nonatomic,assign)CGPoint centerPoint;

/** 三角形的颜色 **/
@property(nonatomic,strong)UIColor    *triangleColor;

/** 代理 **/
@property(nonatomic,assign)id<PullChooseViewDelegate> delegate;

- (instancetype)initWithItems:(NSArray *)items;

- (void)showView:(UIViewController *)controller;

- (void)hiddenView;

@end
