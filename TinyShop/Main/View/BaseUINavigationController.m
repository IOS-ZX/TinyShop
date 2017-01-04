//
//  BaseUINavigationController.m
//  TinyShop
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "BaseUINavigationController.h"

@interface BaseUINavigationController ()

@end

@implementation BaseUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor redColor]];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT(17)]}];
    
    [self makeBottomLine];
}

- (void)makeBottomLine{
    CALayer *bottomBorder = [CALayer layer];
    float width = self.navigationController.view.frame.size.width;
    bottomBorder.frame = CGRectMake(0.0f, 43, width, 1.0f);
    bottomBorder.backgroundColor = [UIColor redColor].CGColor;
    [self.navigationController.view.layer addSublayer:bottomBorder];
}

@end
