//
//  TimeViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "TimeViewController.h"
#import "TimeControll.h"
#import "MZLineView.h"
#import "ColorDefine.h"
#import "TimeIncomeDetailViewController.h"

@interface TimeViewController ()<ChooseStoreViewDelgate>

/** 折线图 **/
@property(nonatomic,strong)MZLineView *lineView;
/** 所有店铺 **/
@property(nonatomic,strong)UILabel *allStore;
/** 店铺选择 **/
@property(nonatomic,strong)ChooseStoreView *chooseView;
/** shopId **/
@property(nonatomic,strong)NSString *shopId;

@end

@implementation TimeViewController

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.allStore];
    self.shopId = [UserInstance sharedUserInstance].allShopIDs;
    [self loadDatas];
}

#pragma mark - 初始化
- (void)setUp{
    self.title = @"实时销售总趋势图";
    UIBarButtonItem *chooseShop = [[UIBarButtonItem alloc]initWithTitle:@"选择店铺" style:UIBarButtonItemStyleDone target:self action:@selector(chooseShop)];
    self.navigationItem.rightBarButtonItem = chooseShop;
}

- (void)chooseShop{
    self.chooseView.stores = [[UserInstance sharedUserInstance] allShop];
    self.chooseView.hidden = !self.chooseView.hidden;
}

- (void)loadDatas{
    __weak typeof(self) weakSelf = self;
    [TimeControll timeIncomeRequest:^(NSArray *titles, NSArray *values) {
        [self setUp];
        weakSelf.lineView.titleStore = titles;
        weakSelf.lineView.incomeStore = values;
        [weakSelf.lineView storkePath];
    } shopId:self.shopId];
}
#pragma mark - 选中代理
- (void)chooseShop:(NSString *)shopid{
    self.shopId = shopid;
    [self loadDatas];
}

#pragma mark - 懒加载

- (MZLineView *)lineView{
    if (!_lineView) {
        _lineView = [[MZLineView alloc]initWithFrame:CGRectMake(0, 64+40, self.view.width,self.view.height-144)];
        _lineView.bottomMargin = 65;
        _lineView.incomeBottomMargin = 30;
        _lineView.brefixStr = @"收入";
        _lineView.titleStr = @"时";
        _lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
            return [NSString stringWithFormat:@"实时总收入:%.1f元",sumValue];
        };
        [self.view addSubview:_lineView];
        __weak typeof(self) weakSelf = self;
        _lineView.selectCallback = ^(NSUInteger index){
            TimeIncomeDetailViewController *time = [TimeIncomeDetailViewController new];
            NSMutableArray *arr = [NSMutableArray arrayWithArray:[weakSelf.shopId componentsSeparatedByString:@","]];
            [arr removeObject:@([UserInstance sharedUserInstance].userShop.shop_id.integerValue)];
            time.time = weakSelf.lineView.titleStore[index];
            time.shopId = [arr componentsJoinedByString:@","];
            [weakSelf.navigationController pushViewController:time animated:YES];
        };
    }
    return _lineView;
}

- (UILabel *)allStore{
    if (!_allStore) {
        _allStore = [[UILabel alloc]initWithFrame:CGRectMake(10, 79, 200, 25)];
        _allStore.textColor = MAIN_COLOR;
        _allStore.font = FONT(18);
        _allStore.text = @"所有店铺";
    }
    return _allStore;
}

- (ChooseStoreView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[ChooseStoreView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _chooseView.hidden = YES;
        _chooseView.delegate = self;
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:_chooseView];
    }
    return _chooseView;
}

@end
