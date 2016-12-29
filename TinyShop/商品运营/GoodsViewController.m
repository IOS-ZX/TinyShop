//
//  GoodsViewController.m
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "GoodsViewController.h"
#import "MZBarChartView.h"
#import "UIView+Addtions.h"
#import "ColorDefine.h"
//#import "ProductAnalysisNetwork.h"




#define BASE_TAG 20130

@interface GoodsViewController ()

/** <#注释#> **/
@property(nonatomic,strong)NSArray    *colors;
/**  **/
@property(nonatomic,strong)NSArray    *types;
/** <#注释#> **/
@property(nonatomic,strong)MZBarChartView    *barChartView;

/** 顶部滚动视图 **/
@property(nonatomic,strong)UIScrollView    *scrollViewBtn;

/** 分段控制器 **/
@property(nonatomic,strong)UISegmentedControl    *segmentedC;



@end

@implementation GoodsViewController

-(void)shopingNetworking:(NSString *)sales_copies type_name:(NSString *)type_name goods_name:(NSString *)goods_name query:(NSString *)query s_time:(NSString *)s_time e_time:(NSString *)e_time
{
    [NetTool checkRequest:@"goodsTimeAction" loadingMessage:@"加载中" parameter:@{@"body":@{@"shop_id":[UserInstance sharedUserInstance].allShopIDs,@"sales_copies":sales_copies,@"type_name":type_name,@"goods_name":goods_name,@"query":query,@"s_time":s_time,@"e_time":e_time}} success:^(NSDictionary *result) {
        NSLog(@"result:%@",result);
        
//        NSDictionary *resultt;
        NSDictionary *value = result[@"body"][@"value"];
        NSLog(@"value--%@",value);
        NSMutableArray *timeStore = [[value allKeys] mutableCopy];
//        NSLog(@"timeStore---%@",timeStore);
        
        //对时间排序
        
        [timeStore sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            if (obj1 == [NSNull null]) {
                obj1 = @"0000-00-00";
            }
            if (obj2 == [NSNull null]) {
                obj2 = @"0000-00-00";
            }
            
            NSDate *date1 = [formatter dateFromString:obj1];
            NSDate *date2 = [formatter dateFromString:obj2];
            NSComparisonResult result = [date1 compare:date2];
            return result == NSOrderedAscending;
        }];
        for (int i = 0; i < [timeStore count]; i++) {
            NSLog(@"array--:%@", [timeStore objectAtIndex:i]);
        }
        
        //排好序了
        NSArray *barValueStore = [value objectsForKeys:timeStore notFoundMarker:@"0"];
        NSLog(@"barValueStore---:%@",barValueStore);
        
    } error:^(NSError *error) {
        
        
        
        NSLog(@"error:%@",error);
    }];
   
}

#pragma mark -- getter  goodsTimeAction
-(NSArray *)types
{
    if (!_types) {
        _types = @[@"滑蛋粥",@"红薯",@"板栗",@"玉米",@"香蕉",@"苹果",@"梨",@"蛋挞",@"芝士"];
    }
    return _types;
}

-(NSArray *)colors
{
    if (!_colors) {
        _colors = [GoodsViewController colorStoreByCount:self.types.count];
    }
    return _colors;
}

-(UISegmentedControl *)segmentedC
{
    if (!_segmentedC) {
        _segmentedC = [[UISegmentedControl alloc] initWithItems:@[@"销售额",@"份数"]];
        _segmentedC.tintColor = [UIColor redColor];//外观字体颜色
        [_segmentedC addTarget:self action:@selector(segmentedCChange:) forControlEvents:UIControlEventValueChanged];
        _segmentedC.selectedSegmentIndex = 0;
        [self.view addSubview:_segmentedC];
    }
    return _segmentedC;
}
#pragma mark -- Action
-(void)showOrHiddenType:(UIButton *)button
{
    NSInteger typeIndex = button.tag - BASE_TAG;
    
    BOOL success = [self.barChartView hiddenOrShowTyped:typeIndex hiddenSign:!button.selected];
    if (!success) {
        return;
    }
    if (button.selected == NO) {
        button.backgroundColor = BACKGROUNDCOLOR;
    }else
    {
        button.backgroundColor = self.colors[typeIndex];
        
    }
    button.selected = !button.selected;
}

-(void)segmentedCChange:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"1");
    }else if (sender.selectedSegmentIndex == 1)
    {
        NSLog(@"2");
    }
    
}
#pragma mark -- Create
-(void)createTypeViews
{
    CGFloat width = 60;
    CGFloat margin = 15;
    _scrollViewBtn = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, self.view.width, 100)];
    _scrollViewBtn.contentSize = CGSizeMake(margin + self.types.count * (margin + width+15), width);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollViewBtn.maxY - 7, self.view.width, 4)];
    view.backgroundColor = LIGHTRED_COLOR;//滑动线条底部颜色
    [self.view addSubview:view];
    [self.view addSubview:_scrollViewBtn];
    
   [self.types enumerateObjectsUsingBlock:^(NSString  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       button.frame = CGRectMake(margin + (width+margin)*idx, 0, width, width);
       button.tag = BASE_TAG + idx;
       [button setBackgroundImage:[UIImage imageNamed:@"类别框-须自己填色"] forState:UIControlStateNormal];
       
       [button addTarget:self action:@selector(showOrHiddenType:) forControlEvents:UIControlEventTouchUpInside];
       //设置副文本
       
       
       [button setTitle:self.types[idx] forState:UIControlStateNormal];
       [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       button.backgroundColor = self.colors[idx];
       button.layer.masksToBounds = YES;
       [_scrollViewBtn addSubview:button];
   }];
    
    //segmentedC 约束
    [self.segmentedC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.5, SCREEN_W * 0.0928));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(SCREEN_W * 0.01428 + 64);
    }];
    
}

-(void)createBarChartView
{
    self.barChartView = [[MZBarChartView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollViewBtn.frame), self.view.width, SCREEN_W * 1.035)];
    [self.view addSubview:self.barChartView];
    
    
    self.barChartView.titleStore = @[@"2016-11-11",@"2016-11-12",@"2016-11-13",@"2016-11-14",@"2016-11-15",@"2016-11-16",@"2016-11-17"];
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -5);
    transform = CGAffineTransformRotate(transform, M_PI * 0.25);
    self.barChartView.labelTransform = transform;
    self.barChartView.bottomMargin = 25;
    self.barChartView.incomeBottomMargin = 0;
    self.barChartView.brefixStr = @"份数";
    
    self.barChartView.incomeStore = @[@{@"滑蛋粥":@"2",@"红薯":@"3",@"板栗":@"0",@"玉米":@"1",@"香蕉":@"1",@"苹果":@"0",@"梨":@"0"},@{@"滑蛋粥":@"2",@"红薯":@"0",@"板栗":@"10",@"玉米":@"1",@"香蕉":@"1",@"苹果":@"1",@"梨":@"0",@"蛋挞":@"1"},@{@"滑蛋粥":@"2",@"红薯":@"3",@"板栗":@"0",@"玉米":@"1",@"香蕉":@"1",@"苹果":@"0",@"梨":@"1"},@{@"滑蛋粥":@"2",@"红薯":@"1",@"板栗":@"10",@"玉米":@"1",@"香蕉":@"1",@"苹果":@"1",@"梨":@"0"},@{@"滑蛋粥":@"2",@"红薯":@"3",@"板栗":@"10",@"玉米":@"1",@"香蕉":@"1",@"苹果":@"0",@"梨":@"0"},@{@"滑蛋粥":@"2",@"红薯":@"5",@"板栗":@"0",@"玉米":@"1",@"香蕉":@"1",@"苹果":@"1",@"梨":@"0"},@{@"滑蛋粥":@"2",@"红薯":@"3",@"板栗":@"10",@"玉米":@"1",@"香蕉":@"1",@"苹果":@"0",@"梨":@"1",@"芝士":@"1"}];
    self.barChartView.allTypes = self.types;
    self.barChartView.colorStore = self.colors;
    [self.view addSubview:self.barChartView];
    self.barChartView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        return [NSString stringWithFormat:@"总销售额：%.f",sumValue];
    };
    self.barChartView.selectCallback = ^(NSUInteger index)
    {
//        NSLog(@"选中第%@个",@(index));
    };
    [self.barChartView storkePath];
}


#pragma mark -- Color
+ (NSArray *)colorStoreByCount:(NSInteger)count
{
    
    NSArray *moreColors =@[UICOLOR_FROM_RGB(247, 79, 56),UICOLOR_FROM_RGB(1, 194, 251),  UICOLOR_FROM_RGB(28, 149, 198),UICOLOR_FROM_RGB(255, 202, 40), UICOLOR_FROM_RGB(110, 193, 149),  UICOLOR_FROM_RGB(90, 83, 161), UICOLOR_FROM_RGB(178, 110, 193)];
    
    NSMutableArray *colorStore = [NSMutableArray array];
    NSInteger num = count / moreColors.count;
    NSInteger dis = count % moreColors.count;
    while (num) {
        [colorStore addObjectsFromArray:moreColors];
        num--;
    }
    if (dis == 1) {
        [colorStore addObject:moreColors[1]];
    }else{
        [colorStore addObjectsFromArray:[moreColors subarrayWithRange:NSMakeRange(0, dis)]];
    }
    
    return colorStore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"按天为单位统计";
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self createTypeViews];
    [self createBarChartView];
    
    //调用网络方法
    [self shopingNetworking:@"sales" type_name:@"0" goods_name:@"0" query:@"day" s_time:@"2016-12-26" e_time:@"2016-12-27"];
    
//    NSDictionary *result;
//    NSDictionary *value = result[@"body"][@"value"];
//    NSLog(@"value--%@",value);
//    NSMutableArray *timeStore = [[value allKeys] mutableCopy];
//    NSLog(@"timeStore---%@",timeStore);
//    //排好序了
//    NSArray *barValueStore = [value objectsForKeys:timeStore notFoundMarker:@"0"];
    

}



@end
