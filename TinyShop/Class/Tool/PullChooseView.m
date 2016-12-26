//
//  PullChooseView.m
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "PullChooseView.h"

@interface PullChooseView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PullChooseView

- (instancetype)initWithItems:(NSArray *)items{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _items = items;
        _maxWidth = 0;
        [self maxWidth];
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    _contentView = [[UIView alloc]init];
    _contentView.layer.cornerRadius = 5;
    _contentView.layer.masksToBounds = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = self.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pull"];
    _contentView.frame = CGRectMake(0, 0, _maxWidth + 20, 45 * _items.count);
    _tableView.frame = _contentView.frame;
    [self makeCenter];
}

- (void)maxWidth{
    for (NSString *item in _items) {
        if (_maxWidth < [item getStringWidth]) {
            _maxWidth = [item getStringWidth];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pull" forIndexPath:indexPath];
    cell.textLabel.text = _items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self hiddenView];
    [self.delegate pullChooseViewItemClick:indexPath.row];
}

- (void)makeCenter{
    CGFloat sy = _centerPoint.y;
    CGFloat sx = _centerPoint.x;
    CGFloat fw = _contentView.frame.size.width;
    CGFloat fh = _contentView.frame.size.width;
    CGFloat y = 0;
    CGFloat x = 0;
    if ((SCREEN_W - sx) > (fw / 2 + 20)) {
        x = sx;
        _pointA.x = x - 15;
        _pointB.x = x;
        _pointC.x = x + 15;
    }else{
        x = SCREEN_W - 20 - fw / 2;
        if (sx < 40) {
            _pointA.x = x + fw / 2 - 25;
            _pointB.x = x + fw / 2 - 20;
            _pointC.x = x + fw / 2;
        }else{
            _pointA.x = sx - 20;
            _pointB.x = sx;
            _pointC.x = sx + 20;
        }
    }
    if (x < fw / 2 + 20) {
        x = fw / 2 + 20;
        _pointA.x = x - fw / 2 + 10;
        _pointB.x = x - fw / 2 + 25;
        _pointC.x = x - fw / 2 + 40;
    }
    
    if ((SCREEN_H - sy) > fh + 60) {
        y = sy + 40 + fh / 2;
        _pointA.y = y - fh / 2 - 10;
        _pointB.y = y - fh / 2 - 25;
        _pointC.y = y - fh / 2 - 10;
    }else{
        y = sy - 40 - fh / 2;
        _pointA.y = y + fh / 2 + 10;
        _pointB.y = y + fh / 2 + 25;
        _pointC.y = y + fh / 2 + 10;
    }
    
    _contentView.center = CGPointMake(x, y);
    _tableView.center = _contentView.center;
    _triangleColor = self.backgroundColor;
    [self setNeedsDisplay];
}

- (void)showView:(UIViewController *)controller{
    [self makeCenter];
    if (!self.superview) {
        [controller.view addSubview:self];
    }else{
        self.hidden = NO;
    }
}

- (void)hiddenView{
    if (self.superview) {
        self.hidden = YES;
    }
}

-(void)setTriangleColor:(UIColor *)triangleColor
{
    _triangleColor = triangleColor;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(_contentView.frame, point)) {
        [self hiddenView];
    }
}

-(void)drawRect:(CGRect)rect
{
    // ------绘制路径
    UIBezierPath *path = [[UIBezierPath alloc]init];
    // ------设置颜色
    [_contentView.backgroundColor set];
    
    // ------绘制三角形
    //-------------绘制三角形------------
    //
    //                 B
    //                /\
    //               /  \
    //              /    \
    //             /______\
    //            A        C
    path.lineWidth = 1;
    //设置起点 A
    [path moveToPoint:_pointA];
    //添加一根线到某点 B
    [path addLineToPoint:_pointB];
    //添加一根线到某点 C
    [path addLineToPoint:_pointC];
    //关闭路径
//    [path closePath];
    //填充 （把颜色填充进去
    [path fill];
}

@end
