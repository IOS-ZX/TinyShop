//
//  ViewController.m
//  TinyShop
//
//  Created by 曹晓东 on 2016/12/21.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"


@interface ViewController ()

@end

@implementation ViewController

-(void)initializeDataSource
{

}

- (void)initilizeInterface{
    self.view.backgroundColor = [UIColor orangeColor];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    
    [self.view addSubview:loginVC.view];
    [self addChildViewController:loginVC];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDataSource];
    [self initilizeInterface];

}


@end
