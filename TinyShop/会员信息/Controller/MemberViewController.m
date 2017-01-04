//
//  MemberViewController.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberTableViewCell.h"
#import "VipModel.h"
#import "DetailOrderViewController.h"

@interface MemberViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,
UISearchControllerDelegate,UISearchBarDelegate,PullChooseViewDelegate>

/** 选择菜单 **/
@property (nonatomic,strong) PullChooseView *chooseView;
@property (nonatomic,strong) NSMutableArray *allShopName;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *searchArray;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *pageTitle;
@property (nonatomic,assign) int times;

@end

@implementation MemberViewController

- (void)pullChooseViewItemClick:(NSInteger)index{
    self.shopId = [[UserInstance sharedUserInstance]getShopIdByShopName:_allShopName[index]];
    self.pageTitle = [[UserInstance sharedUserInstance] getALLShopNames][index];
    self.navigationItem.title = self.pageTitle;
    [self loadDataSource];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *shop = [[UIBarButtonItem alloc]initWithTitle:@"店铺" style:UIBarButtonItemStyleDone target:self action:@selector(chooseMore:)];
    self.navigationItem.rightBarButtonItem = shop;
    self.navigationItem.title = [[UserInstance sharedUserInstance] getALLShopNames][0];
    _allShopName = [NSMutableArray array];
    _allShopName = [[UserInstance sharedUserInstance] getALLShopNames];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadDataSource];
            [self.tableView.mj_header endRefreshing];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadDataSource];
            [self.tableView.mj_footer endRefreshing];
        }];
    }
    return _tableView;
}

-(UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
        _searchController.searchBar.placeholder = @"输入会员号码";
        //_searchController.searchBar.backgroundImage = [UIImage imageNamed:@"搜索框"];
        [_searchController.searchBar setBarTintColor:[UIColor colorWithRed:248/255.0 green:82/255.0 blue:61/255.0 alpha:1]];
        //设置输入框的背景色
        [_searchController.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索框"] forState:UIControlStateNormal];
        //设置字体颜色/大小，和圆角边框
        //_searchController.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:82/255.0 blue:61/255.0 alpha:1];
        _searchController.dimsBackgroundDuringPresentation = NO;
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopId= [UserInstance sharedUserInstance].mgrShopId;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDataSource];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)loadDataSource{
    
      _times += 10;
      [NetTool checkRequest:@"vipListAction" loadingMessage:@"加载中" parameter:@{@"body":@{@"shop_id":self.shopId,@"vip_mobile":@"",@"limit":[NSString stringWithFormat:@"0,%d",_times]}} success:^(NSDictionary *result) {
        _dataSource = [NSMutableArray new];
        for (NSDictionary *dic in result[@"body"]) {
            VipModel *VIP = [VipModel mj_objectWithKeyValues:dic];
            NSLog(@"%@",dic);
            [_dataSource addObject:VIP];
        }
        //_dataSource = [NSArray arrayWithArray:result[@"body"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        NSLog(@"%@",_dataSource);
    } error:^(NSError *error) {
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchController.active) {
        return _searchArray.count;
    } else {
        return _dataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = self.searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vip_mobile CONTAINS[cd] %@",searchString];
    // 移除原数据
    if (_searchArray != nil) {
        [self.searchArray removeAllObjects];
    }
    // 过滤数据
    self.searchArray = [NSMutableArray arrayWithArray:[_dataSource filteredArrayUsingPredicate:predicate]];
    // 刷新表格
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MemberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    VipModel *vip = _dataSource[indexPath.row];
    if (_searchController.active) {
        vip = _searchArray[indexPath.row];
    }
        if ([vip.userSex integerValue] == 0) {
            cell.vip_nickname.textColor = [UIColor colorWithRed:250/255.0 green:99/255.0 blue:169/255.0 alpha:1];
        }else{
            cell.vip_nickname.textColor = [UIColor colorWithRed:128/255.0 green:192/255.0 blue:244/255.0 alpha:1];
        }
        cell.vip_nickname.text = vip.vip_nickname;
        cell.vip_mobile.text = vip.vip_mobile;
        cell.uvgrade_money.text = [NSString stringWithFormat:@"预存款:%@元",vip.uvgrade_money];
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VipModel *vip = _dataSource[indexPath.row];
    if (_searchController.active) {
        vip = _searchArray[indexPath.row];
        _searchController.active = NO;
    }
    
    DetailOrderViewController *detailOrderPage = [[DetailOrderViewController alloc]init];
    detailOrderPage.vipInfo = vip;
    [self.navigationController pushViewController:detailOrderPage animated:YES];
}

- (void)chooseMore:(UIBarButtonItem*)sender{
    self.chooseView.centerPoint = CGPointMake(self.view.width - 20 - sender.width / 2, 0);
    [self.chooseView showView];
}

- (PullChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[PullChooseView alloc]initWithItems:_allShopName];
        _chooseView.delegate = self;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_chooseView];
    }
    return _chooseView;
}

@end
