//
//  ViewController.m
//  TinyShop
//
//  Created by 曹晓东 on 2016/12/21.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "DrawerViewController.h"


@interface ViewController ()

@end

@implementation ViewController

-(void)initializeDataSource
{

}

-(void)initializeDrawer
{
    DrawerViewController *drawer = [DrawerViewController new];
    [self.view addSubview:drawer.view];
    [self addChildViewController:drawer];
}

- (void)initilizeInterface{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.view addSubview:loginVC.view];
    [self addChildViewController:loginVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initilizeInterface];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initializeDrawer) name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initilizeInterface) name:@"loginOut" object:nil];
}
@end
