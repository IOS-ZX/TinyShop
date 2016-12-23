//
//  DrawerViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "DrawerViewController.h"
#import "MainViewController.h"
#import "BaseUINavigationController.h"
#import "DrawerCell.h"

@interface DrawerViewController ()
{
    NSArray *_icons;
    NSArray *_texts;
}

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _icons = @[@"进货管理图标",@"销货管理图标",@"库存管理图标",@"成本分析图标"];
    _texts = @[@"进货管理",@"销货管理",@"库存管理",@"成本分析"];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self initMainView];
    [self test];
}

- (void)initMainView{
    MainViewController *main = [MainViewController new];
    BaseUINavigationController *nav = [[BaseUINavigationController alloc]initWithRootViewController:main];
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)test{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *mgr_base_id = [ud objectForKey:@"base_id"];
    NSString *shop_id = [ud objectForKey:@"shop_id"];
    NSString *access_token = [ud objectForKey:@"login_token"];
    NSString *pa = [NSString stringWithFormat:@"client_type=ios&client_version=2.0&client_token=2a8242f0858bbbde9c5dcbd0a0008e5a&shop_id=%@&mgr_base_id=%@&access_token=%@&mac_code=2322323",shop_id,mgr_base_id,access_token];
    NSString *md5 = [pa MD5];
    NSString *url = [NSString stringWithFormat:@"%@?%@&key=%@",TimeCount,pa,md5];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DrawerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"DrawerCell" owner:self options:nil].firstObject;
    }
    cell.backgroundColor = self.view.backgroundColor;
    cell.text.text = _texts[indexPath.row];
    cell.icon.image = [UIImage imageNamed:_icons[indexPath.row]];
    return cell;
}

@end
