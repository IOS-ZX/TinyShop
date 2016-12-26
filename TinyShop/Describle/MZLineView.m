//
//  MZLineView.m
//  TinyShop_x
//
//  Created by MrZhao on 16/12/23.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import "MZLineView.h"
#import "UIView+Addtions.h"
#import "GrayWhiteView.h"
#import "ColorDefine.h"
#import "ZFCirque.h"

#define POINT_BASE_TAG 1000

@interface MZLineView()
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
//point button数组
@property(nonatomic, strong) NSMutableArray *pointButtonStore;
//point circle数组
@property(nonatomic, strong) NSMutableArray *circleStore;
//线数组
@property(nonatomic, strong) NSMutableArray *lineLayerStore;
//收入高度
@property(nonatomic, assign) CGFloat incomeHeight;
//浮点位数 @"%.2f"
@property(nonatomic, copy) NSString *floatType;
@end

@implementation MZLineView

#pragma mark- LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.singleWidth = 60;
        self.bottomMargin = 20;
        self.incomeTopMargin = 60;
        self.incomeBottomMargin= 80;
        self.labelTransform = CGAffineTransformIdentity;
        self.selectIndex = -1;
        self.brefixStr = @"收入";
        self.suffixStr = @"";
        self.floatNumber = 0;
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
        _backGrayView = [[GrayWhiteView alloc]initWithFrame:CGRectMake(0, 0, self.scrollview.contentSize.width, self.scrollview.height-self.bottomMargin) singleWidth:self.singleWidth count:self.titleStore.count];
    }
    return _backGrayView;
}
-(UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 156/2, 63/2.5)];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"弹框按钮"] forState:UIControlStateNormal];
        _selectButton.highlighted = NO;
        [_selectButton setTitle:@"饼状分析图" forState:UIControlStateNormal];
        _selectButton.titleLabel.font = FONT(12);
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectDetial) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _selectButton;
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
-(NSMutableArray *)pointButtonStore
{
    if (!_pointButtonStore) {
        _pointButtonStore = [NSMutableArray array];
    }
    return _pointButtonStore;
}
-(NSMutableArray *)lineLayerStore
{
    if (!_lineLayerStore) {
        _lineLayerStore = [NSMutableArray array];
    }
    return _lineLayerStore;
}
-(NSMutableArray *)circleStore
{
    if (!_circleStore) {
        _circleStore = [NSMutableArray array];
    }
    return _circleStore;
}
#pragma mark- Setter
-(void)setFloatNumber:(NSUInteger)floatNumber
{
    _floatNumber = floatNumber;
    self.floatType = [NSString stringWithFormat:@"%%.%luf",self.floatNumber];
}

#pragma mark- calculate
- (void)calculate
{
    self.sumValue = 0;
    self.maxValue = 0;
    [self.incomeStore enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.maxValue < obj.floatValue) {
            self.maxValue = obj.floatValue;
        }
        self.sumValue += obj.floatValue;
    }];
    
    self.incomeHeight = self.backGrayView.height - self.incomeTopMargin -self.incomeBottomMargin;
}
- (CGPoint)pointByIndex:(NSUInteger)idx value:(CGFloat)value
{
    CGFloat centerX = 1+(self.singleWidth+1)*(idx+0.5);
    CGFloat centerY = 0;
    if (self.maxValue == 0) {
        centerY = self.incomeTopMargin + self.incomeHeight;
    }else{
        centerY = self.incomeTopMargin + self.incomeHeight * (1 - value/self.maxValue);
    }
    return CGPointMake(centerX, centerY);
    
}
#pragma mark- Storke

- (void)storkePath
{
    [self calculate];
    [self addSubview:self.topLabel];
    [self addSubview:self.scrollview];
    [self.scrollview addSubview:self.backGrayView];
    [self addTitleLabels];
    [self createPointsAndLines];
}

- (void)addTitleLabels
{
    for (int i = 0; i < self.titleStore.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(1+(self.singleWidth+1)*i-10, self.backGrayView.height-30, self.singleWidth+20, 25)];
        label.text = self.titleStore[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(14);
        label.transform = self.labelTransform;
        [self.scrollview addSubview:label];
        [self.titleLabelStore addObject:label];
    }
}

- (void)createPointsAndLines
{
   
    [self.incomeStore enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       //1、划线
        if (idx != self.incomeStore.count - 1) {
            //不是最后一个
            CGPoint startpoint = [self pointByIndex:idx value:obj.floatValue];
            CGPoint endPoint = [self pointByIndex:idx + 1 value:[self.incomeStore[idx + 1] floatValue]];
            
            //调用
            [self addLayerByStart:startpoint end:endPoint];
            
        }
        //2、添加动画小圈圈
        CGPoint currentCenter = [self pointByIndex:idx value:obj.floatValue];
        NSUInteger tag = POINT_BASE_TAG * 2 + idx;
        
        [self addCircleAnimation:currentCenter tag:tag];
        
        //3、添加button
        [self addButton:currentCenter tag:POINT_BASE_TAG + idx];
        
        //4、添加income label
        CGFloat sum = 0;
        if (idx == 0) {
            sum += [self.incomeStore[idx + 1] floatValue];
        }else if(idx == self.incomeStore.count -1)
        {
            sum += [self.incomeStore[idx -1] floatValue];
        }else
        {
            sum += [self.incomeStore[idx + 1] floatValue];
            sum += [self.incomeStore[idx -1] floatValue];
        }
        CGPoint labelCenter = currentCenter;
        if (sum / 2.0 > obj.floatValue) {
            labelCenter.y += 25;
        }else
        {
            labelCenter.y -= 30;
        }
        [self addIcomeLabel:labelCenter idx:idx];
        
    }];
}

-(void)addIcomeLabel:(CGPoint)center idx:(NSInteger)idx
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(center.x - self.singleWidth/2, center.y - 20, self.singleWidth, 40)];
    label.font = FONT(12);
    label.textColor = MAIN_COLOR;
    label.numberOfLines = 2;
    //收入\n%0.2f元
    NSString *type = [NSString stringWithFormat:@"%@\n%@%@",self.brefixStr,self.floatType,self.suffixStr];
    label.text = [NSString stringWithFormat:type,[self.incomeStore[idx] floatValue]];
    label.textAlignment = NSTextAlignmentCenter;
    [self.backGrayView addSubview:label];
    [self.incomeLabelStore addObject:label];
}

- (void)addLayerByStart:(CGPoint)startPoint end:(CGPoint)endPoint
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    //移动到起点
    [bezierPath moveToPoint:startPoint];
    //划线
    [bezierPath addLineToPoint:endPoint];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = bezierPath.CGPath;
    //线宽
    layer.lineWidth = 3;
    //线条颜色
    layer.strokeColor = [MAIN_COLOR CGColor];
    //
    [self.backGrayView.layer addSublayer:layer];
    [self.lineLayerStore addObject:layer];
    
    
}


-(void)addCircleAnimation:(CGPoint)center tag:(NSUInteger)tag
{
    ZFCirque *cirque = [[ZFCirque alloc] initWithFrame:CGRectMake(center.x - 10, center.y - 10, 20, 20)];
    cirque.cirqueColor = MAIN_COLOR;
    cirque.tag = tag;
    [cirque strokePath];
    
    [self.backGrayView addSubview:cirque];
    [self.circleStore addObject:cirque];
    
    
}

-(void)addButton:(CGPoint)center tag:(NSUInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(center.x - 17, center.y - 17, 34, 34);
    button.tag = tag;
    [button addTarget:self action:@selector(selectpoint:) forControlEvents:UIControlEventTouchUpInside];
    [self.backGrayView addSubview:button];
    [self.pointButtonStore addObject:button];
    
}


#pragma mark- Action

-(void)selectpoint:(UIButton *)button
{
    NSUInteger currentIndex = button.tag - POINT_BASE_TAG;
    if (self.selectIndex != -1) {
        //之前没有选中 取消选中
        ZFCirque *cirque = [self.backGrayView viewWithTag:self.selectIndex + POINT_BASE_TAG * 2];
        cirque.cirqueColor = MAIN_COLOR;
        [cirque strokePath];
        
    }

    if (self.selectIndex == currentIndex) {
        //重复选中
        self.selectButton.hidden = YES;
        self.selectIndex = -1;
    }else{
        //选中点击的小圆圈
        ZFCirque *cirque = [self.backGrayView viewWithTag:currentIndex + POINT_BASE_TAG * 2];
        cirque.cirqueColor = BLUE_COLOR;
        [cirque strokePath];
        
        self.selectIndex = currentIndex;
        self.selectButton.center = CGPointMake(button.center.x, button.center.y - 25);
        [self.backGrayView addSubview:self.selectButton];
        self.selectButton.hidden = NO;
    }
    
}

- (void)selectDetial
{
    if (self.selectCallback) {
        self.selectCallback(self.selectIndex);
    }
    //取消选中
    [self selectpoint:self.pointButtonStore[self.selectIndex]];
}


@end

@implementation UIImageView (ForScrollView)

- (void)setAlpha:(CGFloat)alpha
{
    if (self.superview.tag == noDisableVerticalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleLeftMargin) {
            if (self.frame.size.width < 10 && self.frame.size.height > self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.height < sc.contentSize.height) {
                    [super setAlpha:1];
                    return;
                }
            }
        }
    }else  if (self.superview.tag == noDisableHorizontalScrollTag ) {
        if (self.frame.size.height < 10 && self.frame.size.height < self.frame.size.width) {
            self.image = [UIImage imageNamed:@"滚动条.png"];
            [super setAlpha:1];
            self.tag = 4555;
            return;
        }
        if (self.tag == 4555) {
            self.image = [UIImage imageNamed:@"滚动条.png"];
            [super setAlpha:1];
            return;
        }
        
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
            if (self.frame.size.height < 10 && self.frame.size.height < self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                self.image = [UIImage imageNamed:@"滚动条.png"];
                
                if (sc.frame.size.width < sc.contentSize.width) {
                    [super setAlpha:1];
                    
                    return;
                }
            }
            
        }
    }
    [super setAlpha:alpha];
}
@end






