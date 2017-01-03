//
//  ZFCirque.m
//  ZFChartView
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZFCirque.h"

@interface ZFCirque()
<
CAAnimationDelegate
>

/** 半径 */
@property (nonatomic, assign) CGFloat radius;
/** 线宽 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 动画时间 */
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, strong) CAShapeLayer * shapeLayer;
@property (nonatomic, strong) CAShapeLayer * shapeLayerOut;
@end

@implementation ZFCirque

/**
 *  初始化默认变量
 */
- (void)commonInit{
    _radius = 8;
    _lineWidth = 2;
    _animationDuration = 0.5f;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];// 5 = _radius + _lineWidth
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Cirque(圆环)

/**
 *  填充
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)fill{
    UIBezierPath * bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:_radius startAngle:M_PI * -0.5 endAngle:M_PI * 1.5 clockwise:YES];
    return bezier;
}

/**
 *  CAShapeLayer
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)shapeLayer{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = _cirqueColor.CGColor;
    layer.lineWidth = _lineWidth;
    layer.path = [self fill].CGPath;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    self.shapeLayer = layer;
    
    CABasicAnimation * animation = [self animation];
    [layer addAnimation:animation forKey:nil];
    
    return layer;
}
- (UIBezierPath *)fillOut{
    UIBezierPath * bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:_radius+1 startAngle:M_PI * -0.5 endAngle:M_PI * 1.5 clockwise:YES];
    return bezier;
}
- (CAShapeLayer *)shapeLayerOut{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 1;
    layer.path = [self fillOut].CGPath;
    layer.strokeColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
    self.shapeLayerOut = layer;
    
    CABasicAnimation * animation = [self animation];
    [layer addAnimation:animation forKey:nil];
    
    return layer;
}

#pragma mark - 动画

/**
 *  填充动画过程
 *
 *  @return CABasicAnimation
 */
- (CABasicAnimation *)animation{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = _animationDuration;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = @(0.f);
    fillAnimation.toValue = @(1.f);
    return fillAnimation;
}

/**
 *  清除之前所有subLayers
 */
- (void)removeAllSubLayers{
    NSArray * subLayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in subLayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

#pragma mark - public method

/**
 *  重绘
 */
- (void)strokePath{
    
    [self removeAllSubLayers];
    [self.layer addSublayer:[self shapeLayerOut]];
    [self.layer addSublayer:[self shapeLayer]];
}

#pragma mark - 重写setter,getter方法

- (void)setCirqueColor:(UIColor *)cirqueColor{
    _cirqueColor = cirqueColor;
    self.shapeLayer.strokeColor = _cirqueColor.CGColor;
}



@end
