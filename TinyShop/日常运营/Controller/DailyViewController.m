//
//  DailyViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "DailyViewController.h"
#import "DailyTimeControll.h"
#import "MZLineView.h"
#import "DailyDetailViewController.h"

@interface DailyViewController ()<PullChooseViewDelegate,ChooseStoreViewDelgate>

/** 折线图 **/
@property(nonatomic,strong)MZLineView *lineView;
/** 顶部按钮 **/
@property(nonatomic,strong)NSMutableArray *topBtns;
/** 数据类型 **/
@property(nonatomic,assign)RequestDataType dataType;
/** 统计类型 **/
@property(nonatomic,assign)RequestQueryType queryType;
/** 选择菜单 **/
@property(nonatomic,strong)PullChooseView *chooseView;
/** 选择店铺 **/
@property(nonatomic,strong)ChooseStoreView *shopView;
/** 选择Date **/
@property(nonatomic,strong)ChooseDateView *chooseDate;
/** 选中时间 **/
@property(nonatomic,strong)NSString *chooseValueString;
/** 店铺id **/
@property(nonatomic,strong)NSString *shopId;
/** title **/
@property(nonatomic,strong)NSString *titleText;

@end

@implementation DailyViewController

#pragma mark - 回调

// 下拉菜单选择回调
- (void)pullChooseViewItemClick:(NSInteger)index{
    if (index == 0) {
        self.chooseView.hidden = YES;
        self.shopView.stores = [[UserInstance sharedUserInstance] allShop];
        self.shopView.hidden = !self.shopView.hidden;
    }else if (index == 1){
        self.chooseDate.hidden = NO;
    }
}

// 店铺选择回调
- (void)chooseShop:(NSString *)shopid{
    self.shopId = shopid;
    [self loadDatas];
}

// 时间选择回调
- (ChooseDate)chooseValue{
    __weak typeof(self) weakSelf = self;
    return ^(RequestQueryType type, NSString* value){
        weakSelf.queryType = type;
        weakSelf.chooseValueString = value;
        [weakSelf loadDatas];
    };
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"按天为单位统计";
    [self initDatas];
    [self loadDatas];
    [self typeClick:self.topBtns[0]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *more = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:self action:@selector(chooseMore:)];
    self.navigationItem.rightBarButtonItem = more;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 自定义方法

// 初始化数据
- (void)initDatas{
    self.dataType = sales;
    self.queryType = day;
    self.titleText = @"销售额";
    self.shopId = [[UserInstance sharedUserInstance]allShopIDs];
    self.chooseValueString = [self defaultStartTime];
    [self makeTypeButton];
}


// 默认开始时间
- (NSString*)defaultStartTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    NSString *years = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MM"];
    NSString *months = [formatter stringFromDate:date];
    [formatter setDateFormat:@"dd"];
    NSString *days = [formatter stringFromDate:date];
    NSString *str = @"";
    if ([days integerValue] > 8) {
        str = [NSString stringWithFormat:@"%@-%@-%ld",years,months,[days integerValue] - 8];
    }else if ([months integerValue] > 1){
        months = [NSString stringWithFormat:@"%ld",[months integerValue] - 1];
        NSInteger upMonth = [self.chooseDate getDay:years month:months].count;
        days = [NSString stringWithFormat:@"%ld",(8 - [days integerValue] + upMonth)];
        str = [NSString stringWithFormat:@"%@-%@-%@",years,months,days];
    }else{
        years = [NSString stringWithFormat:@"%ld",[years integerValue] - 1];
        months = [NSString stringWithFormat:@"%ld",[months integerValue] - 1 + 12];
        NSInteger upMonth = [self.chooseDate getDay:years month:months].count;
        days = [NSString stringWithFormat:@"%ld",(8 - [days integerValue] + upMonth)];
        str = [NSString stringWithFormat:@"%@-%@-%@",years,months,days];
    }
    return str;
}

// 请求数据
- (void)loadDatas{
    __weak typeof(self) weakSelf = self;
    [DailyTimeControll dailyTimeRequest:^(NSArray *titles, NSArray *values) {
        // 设置数据
        weakSelf.lineView.titleStore = titles;
        weakSelf.lineView.incomeStore = values;
        // 开始绘图
        [weakSelf.lineView storkePath];
        // 显示顶部按钮
        [weakSelf showBtns];
    } shopId:self.shopId statisticalType:self.dataType query:self.queryType sTime:self.chooseValueString eTime:[self endTime]];
}

//获取当前时间
- (NSString*)endTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    NSString *years = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MM"];
    NSString *months = [formatter stringFromDate:date];
    [formatter setDateFormat:@"dd"];
    NSString *days = [formatter stringFromDate:date];
    NSString *str = @"";
    switch (self.queryType) {
        case year:
            str = years;
            break;
        case month:
            str = [NSString stringWithFormat:@"%@-%@",years,months];
            break;
        case week:
            str = [NSString stringWithFormat:@"2016,48"];
            break;
        case day:
            str = [NSString stringWithFormat:@"%@-%@-%@",years,months,days];
            break;
    }
    return str;
}

// 更多
- (void)chooseMore:(UIBarButtonItem*)sender{
    self.chooseView.centerPoint = CGPointMake(self.view.width - 20 - sender.width / 2, 42);
    [self.chooseView showView];
}

// 创建button
- (void)makeTypeButton{
    NSArray *title = [NSArray arrayWithObjects:@"销售额",@"桌数",@"人数",@"人均",@"餐时", nil];
    __weak typeof(self) weakSelf = self;
    __block CGFloat w = (SCREEN_W - 60) / 5;
    [title enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake( idx * (w + 10) + 10, 114 - (w + 10) / 2, w, w + 10)];
        btn.tag = 1000+idx;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-选中",obj]] forState:UIControlStateSelected];
        btn.hidden = YES;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-未选",obj]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.view addSubview:btn];
        [weakSelf.topBtns addObject:btn];
    }];
}

// 默认为不显示，修改为显示
- (void)showBtns{
    [self.topBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.hidden = NO;
    }];
}

// 类型点击
- (void)typeClick:(UIButton*)sender{
    [self.topBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (sender.tag == 1000 + idx) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }];
    NSString *titleHx = @"元";
    switch (sender.tag - 1000) {
        case 0:
            self.dataType = sales;
            self.lineView.brefixStr = @"收入";
            self.titleText = @"销售额";
            titleHx = @"元";
            break;
        case 1:
            self.dataType = order_num;
            self.lineView.brefixStr = @"桌数";
            self.titleText = @"桌数";
            titleHx = @"桌";
            break;
        case 2:
            self.dataType = people_num;
            self.lineView.brefixStr = @"人数";
            self.titleText = @"人数";
            titleHx = @"人";
            break;
        case 3:
            self.dataType = people_avg;
            self.lineView.brefixStr = @"人均";
            self.titleText = @"人均";
            titleHx = @"元";
            break;
        case 4:
            self.dataType = avg_meal;
            self.lineView.brefixStr = @"餐时";
            self.titleText = @"餐时";
            titleHx = @"小时";
            break;
        default:
            self.dataType = sales;
            self.lineView.brefixStr = @"收入";
            self.titleText = @"销售额";
            titleHx = @"元";
            break;
    }
    __weak typeof(self) weakSelf = self;
    // 标题回调
    self.lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        return [NSString stringWithFormat:@"总%@:%.1f%@",weakSelf.titleText,sumValue,titleHx];
    };
    // 重新获取数据
    [self loadDatas];
}

#pragma mark - 懒加载

- (MZLineView *)lineView{
    if (!_lineView) {
        _lineView = [[MZLineView alloc]initWithFrame:CGRectMake(0, 64+100, self.view.width,self.view.height-174)];
        _lineView.singleWidth = self.view.width / 6;
        _lineView.bottomMargin = 65;
        _lineView.incomeBottomMargin = 30;
        _lineView.brefixStr = @"收入";
        _lineView.titleStr = @"";
        CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 15, 40);
        transform = CGAffineTransformRotate(transform, M_PI*0.31);
        _lineView.labelTransform = transform;
        _lineView.topTitleCallBack = ^NSString *(CGFloat sumValue){
            return [NSString stringWithFormat:@"总销售额:%.1f元",sumValue];
        };
        [self.view addSubview:_lineView];
        __weak typeof(self) weakSelf = self;
        _lineView.selectCallback = ^(NSUInteger index){
            DailyDetailViewController *detailView = [DailyDetailViewController new];
            detailView.shopId = weakSelf.shopId;
            detailView.date = weakSelf.lineView.titleStore[index];
            detailView.dataType = weakSelf.dataType;
            detailView.queryType = weakSelf.queryType;
            [weakSelf.navigationController pushViewController:detailView animated:YES];
        };
    }
    return _lineView;
}

- (NSMutableArray *)topBtns{
    if (!_topBtns) {
        _topBtns = [NSMutableArray array];
    }
    return _topBtns;
}

- (PullChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[PullChooseView alloc]initWithItems:@[@"选择店铺",@"选择日期"]];
        _chooseView.delegate = self;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_chooseView];
    }
    return _chooseView;
}

- (ChooseStoreView *)shopView{
    if (!_shopView) {
        _shopView = [[ChooseStoreView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _shopView.hidden = YES;
        _shopView.delegate = self;
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:_shopView];
    }
    return _shopView;
}

- (ChooseDateView *)chooseDate{
    if (!_chooseDate) {
        _chooseDate = [ChooseDateView new];
        _chooseDate.frame = self.view.bounds;
        _chooseDate.hidden = YES;
        _chooseDate.dates = [self chooseValue];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_chooseDate];
    }
    return _chooseDate;
}

@end
