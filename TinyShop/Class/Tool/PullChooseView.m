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
        [self setUp];
    }
    return self;
}

- (void)setUp{
    _maxWidth = 0;
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    _contentView = [[UIView alloc]init];
    _contentView.layer.cornerRadius = 5;
    _contentView.layer.masksToBounds = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    [self makeButtons];
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pull"];
    _contentView.frame = CGRectMake(0, 0, _maxWidth + 20, 45 + _items.count);
    [self makeCenter];
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

- (void)makeButtons{
    NSInteger index = 1000;
    for (NSString *title in _items) {
        if (_maxWidth - 20 < [title getStringWidth]) {
            _maxWidth = [title getStringWidth] + 20;
        }
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5 + (index - 1000) * 40, [title getStringWidth] + 20, 40)];
        btn.tag = index;
        [btn setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:title forState:UIControlStateNormal];
        [_contentView addSubview:btn];
        index++;
    }
    
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
        _pointA.x = x - 10;
        _pointB.x = x;
        _pointC.x = x + 10;
    }else{
        x = SCREEN_W - 20 - fw / 2;
        if (sx < 40) {
            _pointA.x = x + fw / 2 - 20;
            _pointB.x = x + fw / 2 - 15;
            _pointC.x = x + fw / 2;
        }else{
            _pointA.x = sx - 15;
            _pointB.x = sx;
            _pointC.x = sx + 15;
        }
    }
    if (x < fw / 2 + 20) {
        x = fw / 2 + 20;
        _pointA.x = x - fw / 2 + 5;
        _pointB.x = x - fw / 2 + 20;
        _pointC.x = x - fw / 2 + 35;
    }
    
    if ((SCREEN_H - sy) > fh + 60) {
        y = sy + 40 + fh / 2;
        _pointA.y = y - fh / 2 - 8;
        _pointB.y = y - fh / 2 - 16;
        _pointC.y = y - fh / 2 - 8;
    }else{
        y = sy - 40 - fh / 2;
        _pointA.y = y + fh / 2 + 8;
        _pointB.y = y + fh / 2 + 16;
        _pointC.y = y + fh / 2 + 8;
    }
    
    if (y < fh / 2 + 20) {
        y = fh / 2 + 20;
    }
    _contentView.center = CGPointMake(x, y);
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
