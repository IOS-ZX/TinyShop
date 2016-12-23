//
//  TestViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    BOOL _isShow;
    PullChooseView *_pull;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isShow = NO;
    _pull = [[PullChooseView alloc]initWithItems:@[@"标签1标签1",@"标签标签11",@"标签1标签1",@"标签1标签1标签1"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(UIButton *)sender {
    _pull.centerPoint = sender.center;
    [_pull showView:self];
}


@end
