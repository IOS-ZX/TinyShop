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

@interface TimeViewController ()

/** 所有店铺 **/
@property(nonatomic,strong)UILabel *allShopLabel;
/** 折线图 **/
@property(nonatomic,strong)MZLineView *lineView;

@end

@implementation TimeViewController

- (void)lineBtnClick:(NSInteger)tag{
    
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
}

#pragma mark - 初始化
- (void)setUp{
    self.title = @"实时销售总趋势图";
}

- (void)loadDatas{
    __weak typeof(self) weakSelf = self;
    [TimeControll timeIncomeRequest:^(NSArray *titles, NSArray *values) {
        [self setUp];
//        [self setUpUI];
        [self.view layoutIfNeeded];
        weakSelf.lineView.titleStore = titles;
        weakSelf.lineView.bottomMargin = 65;
        weakSelf.lineView.incomeBottomMargin = 30;
        weakSelf.lineView.brefixStr = @"桌数";
        weakSelf.lineView.incomeStore = values;
        [weakSelf.view addSubview:weakSelf.lineView];
        weakSelf.lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
            return [NSString stringWithFormat:@"实时总收入:%.1f元",sumValue];
        };
        
        weakSelf.lineView.selectCallback = ^(NSUInteger index){
            NSLog(@"选中第%@个",@(index));
        };
        [weakSelf.lineView storkePath];
    }];
}

#pragma mark - 约束
- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    [self.allShopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 35));
        make.bottom.equalTo(weakSelf.lineView.mas_top);
        make.left.equalTo(self.view.mas_left).offset(20);
    }];
}

#pragma mark - 懒加载

- (UILabel *)allShopLabel{
    if (!_allShopLabel) {
        _allShopLabel = [[UILabel alloc]init];
        _allShopLabel.textColor = [UIColor redColor];
        _allShopLabel.font = [UIFont systemFontOfSize:20];
        _allShopLabel.text = @"所有店铺";
        [self.view addSubview:_allShopLabel];
    }
    return _allShopLabel;
}


- (MZLineView *)lineView{
    if (!_lineView) {
        _lineView = [[MZLineView alloc]initWithFrame:CGRectMake(0, 64+40, self.view.width,self.view.height-144)];
    }
    return _lineView;
}

@end
