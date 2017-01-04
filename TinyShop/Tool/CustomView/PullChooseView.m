//
//  PullChooseView.m
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "PullChooseView.h"

@interface PullChooseView()<UITableViewDelegate,UITableViewDataSource>

/** contentView **/
@property(nonatomic,strong)UIImageView *contentView;
/** maxWidth **/
@property(nonatomic,assign)CGFloat maxWidth;
/** tableView **/
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PullChooseView

- (instancetype)initWithItems:(NSArray *)items{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.items = items;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [self makeCenter];
    __weak typeof(self) weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(18);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(5);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-5);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-5);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pull" forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    cell.textLabel.textColor = [UIColor hexColor:@"919191"];
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
    }else{
        x = SCREEN_W - 20 - fw / 2;
    }
    if (x < fw / 2 + 20) {
        x = fw / 2 + 20;
    }
    
    if ((SCREEN_H - sy) > fh + 60) {
        y = sy + 40 + fh / 2;
    }else{
        y = sy - 40 - fh / 2;
    }
    
    self.contentView.center = CGPointMake(x, y);
    self.tableView.center = _contentView.center;
    self.triangleColor = self.backgroundColor;
}

- (void)showView{
    [self makeCenter];
    [self.tableView reloadData];
    if (!self.superview) {
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:self];
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
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(_contentView.frame, point)) {
        [self hiddenView];
    }
}

- (void)setItems:(NSArray *)items{
    _items = items;
}

#pragma mark - 懒加载

- (CGFloat)maxWidth{
    for (NSString *item in _items) {
        if (_maxWidth < [item getStringWidth]) {
            _maxWidth = [item getStringWidth];
        }
    }
    return _maxWidth;
}

- (UIImageView *)contentView{
    if (!_contentView) {
        _contentView = [[UIImageView alloc]init];
        _contentView.image = [UIImage imageNamed:@"多边形-1"];
        _contentView.frame = CGRectMake(0, 0, self.maxWidth + 50, 45 * self.items.count + 20);
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pull"];
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
