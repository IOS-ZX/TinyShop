//
//  MZBarChartView.m
//  TinyShop_x
//
//  Created by MrZhao on 16/12/25.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import "MZBarChartView.h"
#import "GrayWhiteView.h"
#import "UIView+Addtions.h"
#import "ColorDefine.h"
#define BARCHART_BASE_TAG 4000

@interface MZBarChartView()
//顶部总收入
@property(nonatomic, strong) UILabel* topLabel;
//
@property(nonatomic, strong) UIScrollView *scrollview;
//网格背景图
@property(nonatomic, strong) GrayWhiteView *backGrayView;
//时间label数组
@property(nonatomic, strong) NSMutableArray *titleLabelStore;
//最大收入
@property(nonatomic, assign) CGFloat maxValue;
//总收入
@property(nonatomic, assign) CGFloat sumValue;
//收入label数组
@property(nonatomic, strong) NSMutableArray *incomeLabelStore;
//button数组
@property(nonatomic, strong) NSMutableArray *buttonStore;
//柱状图数组
@property(nonatomic, strong) NSMutableArray *barStore;
//隐藏类型下标数组 [@(1),@(0),@(3)]
@property(nonatomic, strong) NSMutableArray *hiddenTypeIndexStore;
//隐藏类型字符串数组 [@"私家秘制",@"板栗",@"蛋挞"]
@property(nonatomic, strong) NSMutableArray *hiddenTypeStrString;
//收入高度
@property(nonatomic, assign) CGFloat incomeHeight;
//浮点位数 @"%.2f"
@property(nonatomic, copy) NSString *floatType;
@end

@implementation MZBarChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.singleWidth = 60;
        self.bottomMargin = 20;
        self.incomeTopMargin = 60;
        self.incomeBottomMargin= 0;
        self.labelTransform = CGAffineTransformIdentity;
        self.selectIndex = -1;
        self.brefixStr = @"收入";
        self.suffixStr = @"";
        self.floatNumber = 0;
        self.barWidthPercent = 0.55;
    }
    return self;
}

#pragma mark- Getter
-(UILabel *)topLabel
{
    
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 25)];
        _topLabel.textColor = MAIN_COLOR;
        _topLabel.font = FONT(18);
        _topLabel.text = self.topTitleCallBack(self.sumValue);
    }
    return _topLabel;
}

- (UIScrollView *)scrollview
{
    
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, self.width, self.height-45)];
        _scrollview.contentSize = CGSizeMake(self.titleStore.count*(self.singleWidth+1)+1, _scrollview.height);
        _scrollview.tag = noDisableHorizontalScrollTag;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollview.maxY-7, self.width, 4)];
        view.backgroundColor = LIGHTRED_COLOR;
        [self addSubview:view];
    }
    return _scrollview;
    
}
-(GrayWhiteView *)backGrayView
{
    if (!_backGrayView) {
        _backGrayView = [[GrayWhiteView alloc]initWithFrame:CGRectMake(0, 0, self.scrollview.contentSize.width, self.scrollview.height-self.bottomMargin)
                                                singleWidth:self.singleWidth
                                                      count:self.titleStore.count];
    }
    return _backGrayView;
}

- (NSMutableArray *)titleLabelStore
{
    if (!_titleLabelStore) {
        _titleLabelStore = [NSMutableArray array];
    }
    return _titleLabelStore;
}
-(NSMutableArray *)incomeLabelStore
{
    if (!_incomeLabelStore) {
        _incomeLabelStore = [NSMutableArray array];
    }
    return _incomeLabelStore;
}
-(NSMutableArray *)buttonStore
{
    if (!_buttonStore) {
        _buttonStore = [NSMutableArray array];
    }
    return _buttonStore;
}
-(NSMutableArray *)barStore
{
    if (!_barStore) {
        _barStore = [NSMutableArray array];
    }
    return _barStore;
}
-(NSMutableArray *)hiddenTypeStrString
{
    if (!_hiddenTypeStrString) {
        _hiddenTypeStrString = [NSMutableArray array];
    }
    return _hiddenTypeStrString;
}
-(NSMutableArray *)hiddenTypeIndexStore
{
    if (!_hiddenTypeIndexStore) {
        _hiddenTypeIndexStore = [NSMutableArray array];
    }
    return _hiddenTypeIndexStore;
}
#pragma mark- Setter
-(void)setFloatNumber:(NSUInteger)floatNumber
{
    _floatNumber = floatNumber;
    self.floatType = [NSString stringWithFormat:@"%%.%luf",self.floatNumber];
}
-(void)setAllTypes:(NSArray *)allTypes
{
    _allTypes = allTypes;
    [_hiddenTypeStrString removeAllObjects];
    [_hiddenTypeIndexStore removeAllObjects];
}
#pragma mark- calculate
- (void)calculate
{
    self.sumValue = 0;
    self.maxValue = 0;
    NSMutableArray *showType = [self.allTypes mutableCopy];
    [showType removeObjectsInArray:self.hiddenTypeStrString];
    __weak typeof(self) weakSelf = self;
    [self.incomeStore enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *allValues = [obj objectsForKeys:showType notFoundMarker:@"0"];
        
        __block CGFloat sum = 0;
        [allValues enumerateObjectsUsingBlock:^(NSString *  _Nonnull value, NSUInteger idx, BOOL * _Nonnull stop) {
            sum += value.floatValue;
        }];
       
        if (weakSelf.maxValue < sum) {
            weakSelf.maxValue = sum;
        }
        weakSelf.sumValue += sum;
    }];
    
    self.incomeHeight = self.backGrayView.height - self.incomeTopMargin -self.incomeBottomMargin;
}
- (CGPoint)pointByIndex:(NSUInteger)idx value:(CGFloat)value
{
    CGFloat centerX = 1+(self.singleWidth+1)*idx + self.singleWidth *0.5;
    CGFloat centerY = self.incomeTopMargin + self.incomeHeight*(1 - value/self.maxValue);
    return CGPointMake(centerX, centerY);
    
}
- (void)selectAllType
{
    [self.hiddenTypeStrString removeAllObjects];
    [self.hiddenTypeIndexStore removeAllObjects];
    [self reStrokePath];
}

- (BOOL)hiddenOrShowTyped:(NSUInteger)typeIndex hiddenSign:(BOOL)sign
{
    if (sign) {
        if (self.hiddenTypeStrString.count + 1 == self.allTypes.count) {
            return NO;
        }
        [self.hiddenTypeStrString addObject:self.allTypes[typeIndex]];
        [self.hiddenTypeIndexStore addObject:@(typeIndex)];
    }else{
        [self.hiddenTypeStrString removeObject:self.allTypes[typeIndex]];
        [self.hiddenTypeIndexStore removeObject:@(typeIndex)];
    }
    
    [self reStrokePath];
    return YES;
}
#pragma mark- Storke
//隐藏或者显示一个类型时，重新刷新界面
- (void)reStrokePath
{
    //重新计算值
    [self calculate];
    //2、改变topLabelText
    self.topLabel.text = self.topTitleCallBack(self.sumValue);
    
    [self.incomeStore enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull obj, NSUInteger barIndex, BOOL * _Nonnull stop) {
        //3、每个柱状图小块的告诉
        __block CGFloat barIncome = 0;
        //每个bar所有小块的收入
        NSArray *allValues = [obj objectsForKeys:self.allTypes notFoundMarker:@"0"];
        
        [allValues enumerateObjectsUsingBlock:^(NSString  *_Nonnull value, NSUInteger typeIndex, BOOL * _Nonnull stop) {
            CGFloat heigth = 0;
            //如果隐藏下边数组不包含 typeIndex 则显示
            if (![self.hiddenTypeIndexStore containsObject:@(typeIndex)]) {
                heigth = [value floatValue] / self.maxValue * self.incomeHeight;
                barIncome += [value floatValue];
            }
            //取出对应的小块，改变高度
            UIView *view = [self.barStore[barIndex] objectAtIndex:typeIndex];
            
            //修改约束
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(heigth);
                
            }];
            
        }];
        //4.改变 收入字符串
        UILabel *label = self.incomeLabelStore[barIndex];
        NSString *type = [NSString stringWithFormat:@"%@\n%@%@",self.brefixStr,self.floatType,self.suffixStr];
        
        label.text = [NSString stringWithFormat:type,barIncome];
        
    }];
}
//绘图
- (void)storkePath
{
    [self calculate];
    [self addSubview:self.topLabel];
    [self addSubview:self.scrollview];
    [self.scrollview addSubview:self.backGrayView];
    [self addTitleLabels];
    
    [self createBars];
}

#pragma mark- Storke Detial 
- (void)addTitleLabels
{
    for (int i = 0; i < self.titleStore.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(1+(self.singleWidth+1)*i-10, self.backGrayView.height-30, self.singleWidth+20, 25)];
        label.text = self.titleStore[i];
        label.textColor = NORMALTEXTCOLOR;;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(14);
        label.transform = self.labelTransform;
        [self.scrollview addSubview:label];
        [self.titleLabelStore addObject:label];
    }
}

- (void)createBars
{
    [self.incomeStore enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger barIndex, BOOL * _Nonnull stop) {
        
        //1. 添加柱状图灰色背景图
        UIView *barGrayView =  [self addBarGrayView:barIndex];
       
        //2、添加每个柱状图
        __block CGFloat barIncome = 0;
        //每个柱状图小块
        NSMutableArray *singleBarStore = [NSMutableArray array];
        
        [self.barStore addObject:singleBarStore];
        
        NSArray *allValues = [obj objectsForKeys:self.allTypes notFoundMarker:@"0"];
        [allValues enumerateObjectsUsingBlock:^(NSString  *_Nonnull value, NSUInteger typeIndex, BOOL * _Nonnull stop) {
            
            CGFloat height = 0;
            //隐藏下边数组不包含typeIndex 才显示
            if (![self.hiddenTypeIndexStore containsObject:@(typeIndex)]) {
                height = [value floatValue]/self.maxValue * self.incomeHeight;
                barIncome += [value floatValue];
                
            }
            //2.1添加每个柱状图的小块
            [self addSingleBarWithHeight:height typeIndex:typeIndex barGrayView:barGrayView];
            
        }];
        //3、添加收入
        [self addincomeLabel:barIncome barGrayView:barGrayView lastSingleBar:singleBarStore.lastObject];
        
        //4.添加button
        [self addButtonByIndex:barIndex];
        
    }];
}

- (UIView *)addBarGrayView:(NSUInteger)barIndex
{
    CGFloat w = self.singleWidth * self.barWidthPercent;
    CGFloat h = self.backGrayView.height-self.incomeTopMargin/2.0 - self.incomeBottomMargin;
    CGFloat centerX = 1+(self.singleWidth + 1)*barIndex + self.singleWidth *0.5;
    CGFloat y = self.incomeTopMargin/2.0;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(centerX-w/2.0, y , w , h)];
    view.backgroundColor = BACKGROUNDCOLOR;
    [self.backGrayView addSubview:view];
    return view;
}


- (void)addSingleBarWithHeight:(CGFloat)height
                         typeIndex:(NSUInteger)typeIndex
                       barGrayView:(UIView *)barGrayView
{
    NSMutableArray *singleBarStore = self.barStore.lastObject;
    UIView *lastView = singleBarStore.lastObject;
    UIView *currentView = [UIView new];
    currentView.backgroundColor = self.colorStore[typeIndex];
    [singleBarStore addObject:currentView];
    
    //添加约束
    [barGrayView addSubview:currentView];
    
    [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(barGrayView.width, height));
        make.left.equalTo(barGrayView.mas_left);
        
        if (typeIndex == 0) {
            make.bottom.equalTo(barGrayView.mas_bottom).offset(0);
        }else
        {
            make.bottom.equalTo(lastView.mas_top);
        }
        
    }];
    
    

}



- (void)addincomeLabel:(CGFloat)barIncome
           barGrayView:(UIView *)barGrayView
         lastSingleBar:(UIView *)lastSingleBar
{
    //1.创建
    UILabel *label = [[UILabel alloc]init];
    label.textColor = MAIN_COLOR;
    label.font = FONT(12);
    label.numberOfLines = 2;
    //收入%.2f元
    NSString *type = [NSString stringWithFormat:@"%@\n%@%@",self.brefixStr,self.floatType,self.suffixStr];
    label.text = [NSString stringWithFormat:type,barIncome];
    label.textAlignment = NSTextAlignmentCenter;
    [self.incomeLabelStore addObject:label];
    
    [barGrayView addSubview:label];
    
    //添加约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(self.singleWidth, 35));
        make.centerX.equalTo(barGrayView.mas_centerX);
        make.bottom.equalTo(lastSingleBar.mas_top).offset(-10);
    }];
//    label.backgroundColor = [UIColor blueColor];
//    
//    //裁剪超出barGrayView视图区域之外的
//    label.layer.masksToBounds = YES;
//    label.clipsToBounds = YES;
    
    
}

- (void)addButtonByIndex:(NSUInteger)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(1+(self.singleWidth +1)*index, 0, self.singleWidth, self.backGrayView.height+1);
    button.tag = BARCHART_BASE_TAG + index;
    [button addTarget:self action:@selector(selectForDetial:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonStore addObject:button];
    [self.backGrayView addSubview:button];
}

#pragma mark- Action

- (void)selectForDetial:(UIButton *)button
{
    self.selectIndex = button.tag - BARCHART_BASE_TAG;
    
    if (self.selectCallback) {
        self.selectCallback(self.selectIndex);
    }
}
@end






















