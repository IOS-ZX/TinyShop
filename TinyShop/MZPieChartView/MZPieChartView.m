//
//  MZPieChartView.m
//  MZPieChartView
//
//  Created by MrZhao on 16/11/16.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import "MZPieChartView.h"
#define ZFDecimalColor(r, g, b, a) [UIColor colorWithRed:r green:g blue:b alpha:a]

@interface MZPieChartView()<CAAnimationDelegate>

#pragma mark-  Property

/** The start angle array of all pie slices */

@property (nonatomic,strong) NSMutableArray *startAngleStore;

/** The percent array of all pie slices */

@property (nonatomic, strong) NSMutableArray *percentStore;

/** The percent text label array of all pie slices */

@property (nonatomic,strong) NSMutableArray *labelStore;

/** The shapelayer array of all pie slices */

@property (nonatomic,strong) NSMutableArray *shapeLayerStore;

/** When the percent of a pie slice < hiddenPercent，do not show the percent text of the pie slice. select the pie slice, line(lineLayer) points to percent text label in a blank area. */

@property (nonatomic,strong) CAShapeLayer *lineLayer;

/** Pie chart center text label */

@property (nonatomic,strong) UILabel *textLabel;

/** Pie chart center text label */

@property (nonatomic,strong) UILabel *valueLabel;

/** The radius of pie chart */

@property (nonatomic, assign) CGFloat radius;

/** The width of a pie slice */

@property (nonatomic, assign) CGFloat lineWidth;

/** The width of a selection pie slice */

@property (nonatomic, assign) CGFloat selectLineWidth;

/**  The center of a pie chart.
 
 Default is center of the MZPieChartView */

@property (nonatomic, assign) CGPoint pieChartCenter;

@end


@implementation MZPieChartView

#pragma mark- LifeCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.animationDuration = 0.75;
        self.selectIndex = -1;
        self.animation = YES;
    }
    return self;
}

#pragma mark- Getter
- (NSMutableArray *)percentStore
{
    if (!_percentStore) {
        _percentStore = [[NSMutableArray alloc]init];
    }
    return _percentStore;
}
- (NSMutableArray *)startAngleStore
{
    if (!_startAngleStore) {
        _startAngleStore = [[NSMutableArray alloc]init];
    }
    return _startAngleStore;
}

- (NSMutableArray *)labelStore
{
    if (!_labelStore) {
        _labelStore = [[NSMutableArray alloc]init];
    }
    return _labelStore;
}
- (NSMutableArray *)shapeLayerStore
{
    if (!_shapeLayerStore) {
        _shapeLayerStore = [[NSMutableArray alloc]init];
    }
    return _shapeLayerStore;
}

-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.adjustsFontSizeToFitWidth = YES;
    }
    _textLabel.font = self.fontColorSet.centerTextFont;
    _textLabel.textColor = self.fontColorSet.centerTextColor;
    return _textLabel;
}

-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    _valueLabel.font = self.fontColorSet.centerValueFont;
    _valueLabel.textColor = self.fontColorSet.centerValueColor;
    return _valueLabel;
}
- (MZPieChartSet *)set
{
    if (!_set) {
        _set = [[MZPieChartSet alloc]init];
    }
    return _set;
}

- (MZPieChartFontColorSet *)fontColorSet
{
    if (!_fontColorSet) {
        _fontColorSet = [[MZPieChartFontColorSet alloc]init];
    }
    return _fontColorSet;
}

#pragma mark-  Select Or Deselect

-(void)selectOne:(NSUInteger)index
{
    if (index >= self.dataSet.valueStore.count || index < 0) {
        return;
    }
    [self setSelectIndex_x:index formOut:YES];
}
- (void)deselectAll
{
    if (self.selectIndex == -1) {
        return;
    }
    [self setSelectIndex_x:self.selectIndex formOut:YES];
}

#pragma mark-  Storke

- (void)removeAllData{
    [self.shapeLayerStore enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    [self.startAngleStore removeAllObjects];
    [self.shapeLayerStore removeAllObjects];
    [self.labelStore removeAllObjects];
}

-(void)stroke
{
    //删除所有数据
    [self removeAllData];
    
    //初始化数据
    [self initDatas];
    
    //计算
    [self caculate];
    
    //添加 饼状图layer 和 比例文本
    [self addPieSlicesAndPercentLabel];
    
    //添加中心点 文本和值
    [self addCenterTextAndValueLabel];
    
    if (self.animation) {
         [self addAnimationlayer];
    }
}


/** Init data */

- (void)initDatas
{
    CGFloat min = MIN(self.width, self.height);
    
    self.pieChartCenter = CGPointMake(self.width/2, self.height/2);
    self.radius = min * self.set.radiusPercent;
    self.lineWidth = min * self.set.lineWidthPercent;
    self.selectLineWidth = min * self.set.selectLineWidthPercent;
    
    self.textLabel.bounds = CGRectMake(0, 0, self.radius*1.6, 25);
    self.textLabel.center = CGPointMake(self.width/2, self.height/2+10);
    self.valueLabel.bounds = CGRectMake(0, 0, self.radius*1.6, 15);
    self.valueLabel.center = CGPointMake(self.width/2, self.height/2-5);
}

- (void)caculate
{
    // check data
    if (self.dataSet == nil || self.dataSet.valueStore.count == 0) {
        return;
    }
    if (self.dataSet.valueStore.count != self.dataSet.textStore.count
        || self.dataSet.textStore.count != self.dataSet.colorStore.count
        ) {
        return;
    }
    
    //caculate sum value
    __block CGFloat sumValue = 0;
    [self.dataSet.valueStore enumerateObjectsUsingBlock:^(NSString * value, NSUInteger idx, BOOL * stop) {
        sumValue += value.floatValue;
    }];
    
    //if sumValue = 0 return
    
    if (sumValue < pow(0.1, 6)) {
        return;
    }
    
    //get percent of all pie slice
    __block CGFloat startAngle = self.set.startAngle;
    //(500,500)
    [self.dataSet.valueStore enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *  stop) {
        CGFloat percent = obj.floatValue/sumValue;
        [self.percentStore addObject:@(percent)];
        [self.startAngleStore addObject:@(startAngle)];//-90,90
        startAngle += M_PI * 2 * percent;//90
    }];
    [self.startAngleStore addObject:@(startAngle)];//-90 90 270
    
    self.dataSet.sumValue = [NSString stringWithFormat:[self.set piechartValueFormat],sumValue];
}

//添加扇形图和 比例文本
- (void)addPieSlicesAndPercentLabel
{
    [self.dataSet.valueStore enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *  stop) {
        //1、添加扇形shapeLayer
        [self addShapeLayerByIndex:idx];
        //2、添加比例文本
        [self addPercentLabelByIndex:idx];
    }];
}

- (void)addCenterTextAndValueLabel
{
    self.textLabel.text = self.dataSet.text;
    [self addSubview:self.textLabel];
    
    self.valueLabel.text = self.dataSet.sumValue;
    [self addSubview:self.valueLabel];
}

- (void)addAnimationlayer
{
    // self.layer.mask
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:self.pieChartCenter radius:self.radius startAngle:self.set.startAngle endAngle:2 * M_PI + self.set.startAngle clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.strokeColor = ZFDecimalColor(0.97, 0.97, 0.97, 1).CGColor;
    shapeLayer.lineWidth = self.lineWidth + 2;
    //设置layer的mask之后  mask上alpha为1的区域，才会被显示，alpha为0的地方不显示
    self.layer.mask = shapeLayer;
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"strokeEnd";
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @1;
    basicAnimation.delegate = self;
    basicAnimation.duration = self.animationDuration;
    //动画结束之后是否需要移除
    basicAnimation.removedOnCompletion = NO;
    //动画结束 以动画之后的状态填充
    basicAnimation.fillMode = kCAFillModeBackwards;
    [shapeLayer addAnimation:basicAnimation forKey:@"111"];
}
#pragma mark- Animation Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.layer.mask removeAllAnimations];
    self.layer.mask = nil;
}

#pragma mark- General
- (CGPoint)pointByRadius:(CGFloat)radius angle:(CGFloat)angle
{
    //sin a = y / r
    //cos a = x / r
    CGFloat y = radius * sin(angle) + self.pieChartCenter.y;
    CGFloat x = radius * cos(angle) + self.pieChartCenter.x;
    return  CGPointMake(x, y);
}
#pragma mark- ShapeLayer & PercentLabel
- (UILabel *)percentLabelByIndex:(NSInteger)index
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 15)];
    NSString *percenTitle = [NSString stringWithFormat:@"%.0f%%",((NSNumber *)self.percentStore[index]).floatValue * 100];
    label.textColor = self.fontColorSet.percentTextColor;
    label.font = self.fontColorSet.percentTextFont;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = percenTitle;
    //Do.添加中心点
    CGFloat startAngle = [self.startAngleStore[index] floatValue];
    CGFloat endAngle = [self.startAngleStore[index + 1] floatValue];
    CGFloat angle = (startAngle + endAngle) / 2;
    label.center = [self pointByRadius:self.radius angle:angle];
    
    return label;
}

- (void)addShapeLayerByIndex:(NSInteger )index
{
    CAShapeLayer *layer = [self shapeLayerByIndex:index];
    [self.layer addSublayer:layer];
    [self.shapeLayerStore addObject:layer];
}
- (void)addPercentLabelByIndex:(NSInteger)index
{
    UILabel *label = [self percentLabelByIndex:index];
    [self addSubview:label];
    [self.labelStore addObject:label];
    //如果对应比例小于最小比例  则不显示
    if ([self.percentStore[index] floatValue] < self.set.hiddenPercent) {
        label.hidden = YES;
        label.font = self.fontColorSet.hiddenPercentTextFont;
        label.textColor = self.fontColorSet.hiddenPercentTextColor;
    }
}

- (CAShapeLayer *)shapeLayerByIndex:(NSInteger)index
{
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
 
    shaperLayer.path = [self shapLayerPathByIndex:index];
    shaperLayer.strokeColor = [self.dataSet.colorStore[index] CGColor];
    //线宽
    shaperLayer.lineWidth = self.lineWidth;
    //填充颜色
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    
    return shaperLayer;
}

- (CGPathRef)shapLayerPathByIndex:(NSInteger)index
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    //开始角度
    CGFloat startAngle = [self.startAngleStore[index] floatValue];
    //结束角度
    CGFloat endAngle = [self.startAngleStore[index + 1] floatValue];
    
    [bezierPath addArcWithCenter:self.pieChartCenter radius:self.radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    return bezierPath.CGPath;
}

#pragma mark- Touche

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    CGFloat dis_x = point.x - self.pieChartCenter.x;
    CGFloat dis_y = point.y - self.pieChartCenter.y;
    //触碰点到圆心的距离
    CGFloat radius_x = sqrt(pow(dis_x, 2) + pow(dis_y, 2));
    //判断触碰点是否在圆环内
    if (radius_x < self.radius - self.selectLineWidth / 2 || radius_x > self.radius + self.selectLineWidth / 2) {
        return;
    }
    //2、根据点找到对应的夹角
    CGFloat angle = atan2(dis_y, dis_x);
    if (dis_x <= 0 && dis_y <= 0) {
        angle += M_PI * 2;
    }
    NSInteger index = [self findIndexByAngle:angle];
    if (index == -1) {
        //没有找到
        return;
    }
    [self setSelectIndex_x:index formOut:NO];
}

//点击了某个layer区域
- (void)setSelectIndex_x:(NSInteger)index formOut:(BOOL)outSign{
    if (self.selectIndex != -1) {
        //之前有一个layer被选中，现在改成被选中状态
        //1、layer 改成为选中状态
        [self selectOrNotLayer:self.selectIndex];
        //2、比例文本和线的隐藏
        [self showOrHiddenMinPercentLabel:self.selectIndex showOrHidden:YES];
        //3、中心点 值和收入 变成总收入和饼状图title
        self.textLabel.text = self.dataSet.text;
        self.valueLabel.text = self.dataSet.sumValue;
    }
    if (self.selectIndex == index) {
        //重复选中
        //整个饼状图处于未选中
        self.selectIndex = -1;
        
        //如果来自内部用户点击，则进行回调，说明饼状图处于未选中状态
        if (!outSign) {
            self.deselect();
        }
        return;
    }
    
    //3、将现在选中的layer 变成选中状态
    //1、选中layer
    [self selectOrNotLayer:index];
//    //2、显示比例文本和线
    [self showOrHiddenMinPercentLabel:index showOrHidden:NO];
    //3、中心点收入和title 改变成选中的对应layer的数据
    self.valueLabel.text = [NSString stringWithFormat:[self.set piechartValueFormat],[self.dataSet.valueStore[index] floatValue]];
    self.textLabel.text = self.dataSet.textStore[index];
    self.selectIndex = index;
}

- (NSInteger)findIndexByAngle:(CGFloat)angle
{
    __block NSInteger index = -1;
    [self.startAngleStore enumerateObjectsUsingBlock:^(NSNumber *  obj, NSUInteger idx, BOOL *  stop) {
        if (angle <= obj.floatValue) {
            index = idx - 1;
            *stop = YES;
        }
    }];
    return index;
}

#pragma mark- SelectOrNotLayer
- (void)selectOrNotLayer:(NSInteger)index
{

    CAShapeLayer *shapeLayer = self.shapeLayerStore[index];
    
    CGFloat width = self.lineWidth;
    CGFloat start = ((NSNumber *)self.startAngleStore[index]).floatValue;
    CGFloat end = ((NSNumber *)self.startAngleStore[index + 1]).floatValue;
    CGFloat percent_x = ((NSNumber *)self.percentStore[index]).floatValue;
    CGFloat radius_x = self.radius;
    
    if (shapeLayer.lineWidth < self.selectLineWidth) {
        //现在为未选中，要改成选中状态
        radius_x = self.radius - self.lineWidth / 2 + self.selectLineWidth / 2;
        width = self.selectLineWidth;
        if (!(percent_x == 100 && [self.dataSet.valueStore[index] floatValue] == [self.dataSet.sumValue floatValue])) {
            percent_x /= 1.2;
            if (percent_x > 0.07) {
                percent_x = 0.07;
            }
            start += percent_x;
            end -= percent_x;
        }
        self.selectOne(index);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.pieChartCenter radius:radius_x startAngle:start endAngle:end clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = width;
}

- (void)showOrHiddenMinPercentLabel:(NSInteger)index showOrHidden:(BOOL)sign
{
    if ([self.percentStore[index] floatValue] > self.set.hiddenPercent) {
        return;
    }
    
    //显示或隐藏比例文本
    UILabel *label = self.labelStore[index];
    label.hidden = sign;
    //显示和隐藏
    if (sign) {
        //隐藏
        [self.lineLayer removeFromSuperlayer];
    }else{
        //显示line
        self.lineLayer = [self createLineLayerByIndex:index];
        [self.layer addSublayer:self.lineLayer];
    }
}

- (CAShapeLayer *)createLineLayerByIndex:(NSInteger)index
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = ((UIColor *)self.dataSet.colorStore[index]).CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.path = [self linePathByIndex:index];
    
    return shapeLayer;
}

- (CGPathRef)linePathByIndex:(NSInteger)index
{
    
    CGFloat radius_x = self.radius + (self.selectLineWidth - self.lineWidth)/2 + self.selectLineWidth/2;
    
    CGFloat start = ((NSNumber *) self.startAngleStore[index]).floatValue;
    CGFloat end = ((NSNumber *)self.startAngleStore[index + 1]).floatValue;
    CGFloat centerAngle = (start + end) / 2.0;
    
    //
    CGPoint point0 = [self pointByRadius:radius_x angle:centerAngle];
    CGPoint point1 = [self pointByRadius:radius_x + self.radius * 0.13  angle:centerAngle];
    
    CGPoint endPoint = point1;
    CGPoint labelCenter = point1;
    if (centerAngle < M_PI_2) {
        //在右侧显示
        endPoint.x = self.width * 0.9;
        labelCenter.x = self.width * 0.9 + 20;
    }else{
        //在左侧显示
        endPoint.x = self.width * 0.1;
        labelCenter.x = endPoint.x - 20;
    }
    
    //比例文本的位置
    UILabel *label = self.labelStore[index];
    label.center = labelCenter;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:point0];
    [bezierPath addLineToPoint:point1];
    [bezierPath addLineToPoint:endPoint];
    return bezierPath.CGPath;
}

@end
