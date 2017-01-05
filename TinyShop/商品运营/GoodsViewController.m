
#import "GoodsViewController.h"
#import "MZBarChartView.h"
#import "UIView+Addtions.h"
#import "ColorDefine.h"
#import "GoodsSubViewController.h"
#import "Date.h"
#import "MoreView.h"



#define BASE_TAG 20130

@interface GoodsViewController ()<ChooseStoreViewDelgate>

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

/** <#注释#> **/
@property(nonatomic,strong)NSArray    *barValueStore;

/** 排好序时间数组 **/
@property(nonatomic,strong)NSMutableArray    *timerArray;

/** btn上面的文字 **/
@property(nonatomic,strong)UILabel    *btnLabel;

//更多的弹框
@property(nonatomic,strong)MoreView* popView;
//三角形弹框
@property(nonatomic,strong)UIImageView* imageView;

@property(nonatomic,strong)UIView* bgView;

/** 店铺选择 **/
@property(nonatomic,strong)ChooseStoreView *chooseView;

/** 日期 **/
@property(nonatomic,strong)ChooseDateView    *dateView;



@end

@implementation GoodsViewController

-(void)initNavigationItem{
    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)more{

    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    _bgView = [[UIView alloc]init];
    _bgView.frame = window.bounds;

    _bgView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
    [window addSubview:_bgView];
    
    //给这个view添加点击事件，当点击这个view时，背景和弹框消失
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewTapped:)];
    [_bgView addGestureRecognizer:tapGesture];
    
    //三角形
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.width - 45, 64, 30, 6)];
    [_imageView setImage:[UIImage imageNamed:@"三角形-1"]];
    [window addSubview:_imageView];
    
    //弹框
    _popView = [[MoreView alloc]initWithFrame:CGRectMake(self.view.width - 160, 70, 140, 135)];
    
    
    //传回用户选择的是店铺、日期还是种类
    //避免retain cycle
    __block GoodsViewController *blockSelf = self;
    self.popView.moreChooseCallBack = ^(NSInteger index){
        
        //移除三角形
        [blockSelf.imageView removeFromSuperview];
        //再次弹出其它选项
        if (index == 0) {
            //店铺
            blockSelf.chooseView.stores = [[UserInstance sharedUserInstance] allShop];
            blockSelf.chooseView.hidden = !blockSelf.chooseView.hidden;
            [blockSelf.bgView removeFromSuperview];
        }
        if (index == 1) {
            //日期
            [blockSelf.view addSubview:blockSelf.dateView];
            blockSelf.dateView.hidden = NO;
            
            [blockSelf.bgView removeFromSuperview];
        }
        if (index == 2) {
            //种类
            
            [blockSelf.bgView removeFromSuperview];
        }
    };
    
    //4. 把需要展示的控件添加上去
    [window addSubview:_popView];
}

#pragma mark - 点击背景时，弹框消失
-(void)bgViewTapped:(UITapGestureRecognizer*)tapGesture{
    [_bgView removeFromSuperview];
    [_popView removeFromSuperview];
    [_imageView removeFromSuperview];
}

-(void)shopingNetworking:(NSString *)sales_copies type_name:(NSString *)type_name goods_name:(NSString *)goods_name query:(NSString *)query s_time:(NSString *)s_time e_time:(NSString *)e_time
{
    [NetTool checkRequest:@"goodsTimeAction" loadingMessage:@"加载中" parameter:@{@"body":@{@"shop_id":[UserInstance sharedUserInstance].allShopIDs,@"sales_copies":sales_copies,@"type_name":type_name,@"goods_name":goods_name,@"query":query,@"s_time":s_time,@"e_time":e_time}} success:^(NSDictionary *result) {
        NSLog(@"result:%@",result);
        
//        NSDictionary *resultt;
        NSDictionary *value = result[@"body"][@"value"];
        NSLog(@"value--%@",value);
        NSMutableArray *timeStore = [[value allKeys] mutableCopy];
        NSLog(@"timeStore---%@",timeStore);
        
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
            return result == NSOrderedDescending;
        }];
        
        _timerArray = timeStore;
//            NSLog(@"timearr:%@",_timerArray);
        
        
        //排好序了
        _barValueStore = [value objectsForKeys:timeStore notFoundMarker:@"0"];
        NSLog(@"barValueStore---:%@",_barValueStore);
        
        [self createBarChartView];
    } error:^(NSError *error) {
        
        
        
        NSLog(@"error:%@",error);
    }];
   
}

#pragma mark -- getter  goodsTimeAction
-(ChooseDateView *)dateView
{
    if (!_dateView) {
        _dateView = [[ChooseDateView alloc] init];
    }
    return _dateView;
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
-(NSArray *)types
{
    if (!_types) {
        _types = @[@"私家秘制",@"时鲜蔬菜",@"牛肉类",@"猪肉类",@"酒水",@"特色主打菜",@"进口啤酒",@"鸡肉类",@"下酒小菜",@"饮料",@"味碟类",@"赠送类"];
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

-(MZBarChartView *)barChartView
{
    if (!_barChartView) {
        _barChartView = [[MZBarChartView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollViewBtn.frame), self.view.width, SCREEN_W * 1.035)];
//        _scrollViewBtn.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_barChartView];
    }
    return _barChartView;
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
        //调用网络方法
        [self shopingNetworking:@"sales" type_name:@"0" goods_name:@"0" query:@"day" s_time:[Date getNineDaysAgo] e_time:[Date getCurrentDate]];
        
    }else if (sender.selectedSegmentIndex == 1)
    {
        [self shopingNetworking:@"sales" type_name:@"0" goods_name:@"0" query:@"day" s_time:@"2016-12-19" e_time:@"2016-12-27"];
        NSLog(@"2");
    }
    
}
#pragma mark -- Create
-(void)createTypeViews
{
    CGFloat width = SCREEN_W * 0.20;
    CGFloat margin = 15;
    _scrollViewBtn = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedC.frame)+90, self.view.width, 100)];
    _scrollViewBtn.contentSize = CGSizeMake(margin + self.types.count * (margin + width+15), width);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollViewBtn.maxY - 7, self.view.width, 4)];
    view.backgroundColor = LIGHTRED_COLOR;//滑动线条底部颜色
    [self.view addSubview:view];
    [self.view addSubview:_scrollViewBtn];
    
   [self.types enumerateObjectsUsingBlock:^(NSString  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       button.frame = CGRectMake(margin + (width+margin)*idx, 0, width, SCREEN_W * 0.24);
       button.tag = BASE_TAG + idx;
       [button setBackgroundImage:[UIImage imageNamed:@"类别框-须自己填色"] forState:UIControlStateNormal];
       //设置字体
       button.titleLabel.font = FONT(14);
       
       [button addTarget:self action:@selector(showOrHiddenType:) forControlEvents:UIControlEventTouchUpInside];
       //设置副文本
       UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W * 0.123, 10)];
       label.center = CGPointMake(button.width/2, button.height/2 +15 );
       label.text = @"统计";
       label.textColor = [UIColor whiteColor];
       label.textAlignment = NSTextAlignmentCenter;
       label.font = FONT(9);
       
       
       [button setTitle:self.types[idx] forState:UIControlStateNormal];
       [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       button.backgroundColor = self.colors[idx];
       button.layer.masksToBounds = YES;
       [_scrollViewBtn addSubview:button];
       [button addSubview:label];
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
    __weak typeof (self) weakself = self;
    self.barChartView.titleStore = _timerArray;
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -5);
    transform = CGAffineTransformRotate(transform, M_PI * 0.25);
    self.barChartView.labelTransform = transform;
    self.barChartView.bottomMargin = 25;
    self.barChartView.incomeBottomMargin = 0;
    self.barChartView.brefixStr = @"份数";
    
    self.barChartView.incomeStore = _barValueStore;//赋值
    NSLog(@"----%@",self.barChartView.incomeStore);
    
    self.barChartView.allTypes = self.types;
    self.barChartView.colorStore = self.colors;
//    [self.view addSubview:self.barChartView];
    self.barChartView.topTitleCallBack = ^NSString *(CGFloat sumValue){
        return [NSString stringWithFormat:@"总销售额：%.f",sumValue];
    };
    self.barChartView.selectCallback = ^(NSUInteger index)
    {
        GoodsSubViewController *goodsSubVC = [[GoodsSubViewController alloc]init];
        [weakself.navigationController pushViewController:goodsSubVC animated:YES];
        
        NSLog(@"选中第%@个",@(index));
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
    
    [self initNavigationItem];
    [self createTypeViews];
    
    [self segmentedCChange:self.segmentedC];
    

}



@end
