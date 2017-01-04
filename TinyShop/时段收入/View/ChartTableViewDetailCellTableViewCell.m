//
//  ChartTableViewDetailCellTableViewCell.m
//  TinyShop
//
//  Created by rimi on 2016/12/28.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ChartTableViewDetailCellTableViewCell.h"

@interface ChartTableViewDetailCellTableViewCell()

/** back layer **/
@property(nonatomic,strong)CAShapeLayer *backLayer;
/** top Line **/
@property(nonatomic,strong)UIView *topLine;
/** bottom Line **/
@property(nonatomic,strong)UIView *bottomLine;

@end

@implementation ChartTableViewDetailCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.height / 2)];
    CGFloat value = self.value / self.sumValue;
    if (self.sumValue == 0) {
        value = 0;
    }
    CGFloat w = self.width * value;
    [path addLineToPoint:CGPointMake(w, self.height / 2)];
    self.backLayer.path = path.CGPath;
    self.backLayer.lineWidth = 35;
    self.backLayer.strokeColor = self.color.CGColor;
}

- (void)setValue:(CGFloat)value{
    _value = value;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    self.topLine.backgroundColor = self.color;
    self.bottomLine.backgroundColor = self.color;
}

#pragma mark - 懒加载

- (CAShapeLayer *)backLayer{
    if (!_backLayer) {
        _backLayer = [CAShapeLayer new];
        [self.layer insertSublayer:_backLayer atIndex:0];
    }
    return _backLayer;
}

- (UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 12.5, self.width, 1)];
        [self.contentView addSubview:_topLine];
    }
    return _topLine;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 12.5, self.width, 1)];
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.width * 0.7, self.height)];
        _titleLabel.textColor = [UIColor hexColor:@"919191"];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 120, 0, 100, self.height)];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.textColor = [UIColor hexColor:@"919191"];
        [self.contentView addSubview:_valueLabel];
    }
    return _valueLabel;
}

@end
