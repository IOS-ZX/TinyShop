//
//  GrayWhiteView.m
//  TinyShop_x
//
//  Created by MrZhao on 16/12/23.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import "GrayWhiteView.h"
#import "UIView+Addtions.h"
#import "ColorDefine.h"

@interface GrayWhiteView()
@end

@implementation GrayWhiteView
#pragma mark- LifeCycle
-(instancetype)initWithFrame:(CGRect)frame
                 singleWidth:(CGFloat)width
                       count:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.single_width = width;
        self.count = count;
        self.backgroundColor = BACKGROUNDCOLOR;
    }
    return self;
}



#pragma mark- Setter
-(void)setCount:(NSInteger)count
{
    _count = count;
    [self setUI];
}
-(void)setSingle_width:(CGFloat)single_width
{
    _single_width = single_width;
    [self setUI];
}

#pragma mark- UI
- (void)setUI
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    for (int i = 0; i < self.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*(self.single_width+1)+1, 1, self.single_width, self.height-2)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
    }
}

@end
