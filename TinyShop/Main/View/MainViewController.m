//
//  MainViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    CGPoint _startPoint;
    BOOL _isShow;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    _isShow = NO;
}

- (void)setUp{
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"云迈天行特色火锅-销";
    UIBarButtonItem *menu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"抽屉按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(showDrawer)];
    self.navigationItem.leftBarButtonItem = menu;
    UIBarButtonItem *exit = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(userExit)];
    self.navigationItem.rightBarButtonItem = exit;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowRadius = 2;
}

- (void)userExit{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginOut" object:nil];
}

- (void)showDrawer{
    [UIView animateWithDuration:0.3 animations:^{
        if (!_isShow) {
            self.navigationController.view.center = CGPointMake(SCREEN_W, self.navigationController.view.center.y);
        }else{
            self.navigationController.view.center = CGPointMake(SCREEN_W / 2, self.navigationController.view.center.y);
        }
    }];
    _isShow = !_isShow;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGFloat x = self.navigationController.view.center.x;
    CGPoint point = [touch locationInView:self.view];
    if (x >= SCREEN_W / 2 && _isShow) {
        CGFloat value = _startPoint.x - point.x;
        self.navigationController.view.center = CGPointMake(x - value, self.navigationController.view.center.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGFloat x = self.navigationController.view.center.x;
    if (x < SCREEN_W / 4 * 3 && _isShow) {
        _isShow = YES;
        [self showDrawer];
    }else if(x >= SCREEN_W / 3 && _isShow){
        _isShow = NO;
        [self showDrawer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
