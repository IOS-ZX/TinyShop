//
//  ChooseDateView.m
//  TinyShop
//
//  Created by rimi on 2016/12/29.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ChooseDateView.h"

@interface ChooseDateView()<UIPickerViewDelegate,UIPickerViewDataSource>

/** contentView **/
@property(nonatomic,strong)UIView *content;

/** 关闭按钮 **/
@property(nonatomic,strong)UIButton *close;

/** titleLabel **/
@property(nonatomic,strong)UILabel *title;

/** 按钮数组 **/
@property(nonatomic,strong)NSMutableArray *btns;

/** 确定 **/
@property(nonatomic,strong)UIButton *choose;

/** 顶部line **/
@property(nonatomic,strong)UIView *topLine;

/** 中间分割线 **/
@property(nonatomic,strong)UIView *centerLine;

/** 选择器 **/
@property(nonatomic,strong)UIPickerView *picker_1;

/** picker 列数 **/
@property(nonatomic,assign)NSInteger Component;

/** 类型 **/
@property(nonatomic,assign)RequestQueryType type;

/** day **/
@property(nonatomic,strong)NSArray *day;

/** 选中年下标 **/
@property(nonatomic,assign)NSInteger yearIndex;

/** 选中月下标 **/
@property(nonatomic,assign)NSInteger monthIndex;

/** 选中日下标 **/
@property(nonatomic,assign)NSInteger dayIndex;

/** 第一列 **/
@property(nonatomic,assign)NSInteger select_1;

/** 第二列 **/
@property(nonatomic,assign)NSInteger select_2;


@end

@implementation ChooseDateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.yearIndex = 0;
        self.monthIndex = 0;
        self.Component = 1;
        [self setUpUI];
    }
    return self;
}

#pragma mark - picker dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.Component > 3) {
        return 3;
    }
    return self.Component;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger num = 0;
    switch (self.type) {
        case year:
            num = 5;
            break;
        case month:
            if (component == 0) {
                num = 5;
            }else{
                num = 12;
            }
            break;
        case week:
            if (component == 0) {
                num = 5;
            }else{
                num = 52;
            }
            break;
        case day:
            if (component == 0) {
                num = 5;
            }else if(component == 1){
                num = 12;
            }else{
                NSString *year = [self getYears][self.yearIndex];
                NSString *month = [self getMonth][self.monthIndex];
                num = [self getDay:year month:month].count;
            }
            break;
    }
    return num;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * complateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.width / self.Component, 30)];
    complateLabel.backgroundColor = [UIColor clearColor];
    complateLabel.textColor = [UIColor hexColor:@"919191"];
    complateLabel.textAlignment = NSTextAlignmentCenter;
    complateLabel.font = [UIFont systemFontOfSize:18];
    
    switch (self.type) {
        case year:
            complateLabel.text = [NSString stringWithFormat:@"%@年",[self getYears][row]];
            break;
        case month:
            if (component == 0) {
                complateLabel.text = [NSString stringWithFormat:@"%@年",[self getYears][row]];
            }else{
                complateLabel.text = [NSString stringWithFormat:@"%@月",[self getMonth][row]];
            }
            break;
        case week:
            if (component == 0) {
                complateLabel.text = [NSString stringWithFormat:@"%@年",[self getYears][row]];
            }else{
                complateLabel.text = [NSString stringWithFormat:@"%@周",[self getWeek][row]];
            }
            break;
        case day:
            if (component == 0) {
                complateLabel.text = [NSString stringWithFormat:@"%@年",[self getYears][row]];
            }else if(component == 1){
                complateLabel.text = [NSString stringWithFormat:@"%@月",[self getMonth][row]];
            }else{
                complateLabel.text = [NSString stringWithFormat:@"%@日",[self getDay:[self getYears][self.yearIndex] month:[self getMonth][self.monthIndex]][row]];
            }
            break;
    }
    
    
    ((UIView *)[self.picker_1.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    ((UIView *)[self.picker_1.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    return complateLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UIView *view = [pickerView viewForRow:row forComponent:component];
    UILabel *label = (UILabel *)view;
    label.textColor = [UIColor redColor];
    if (self.type == day) {
        if (component == 0) {
            //刷新第二列、第三列
            self.yearIndex = row;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
        }else if(component == 1){
            //刷新第三列
            self.monthIndex = row;
            [pickerView reloadComponent:2];
        }else{
            self.dayIndex = row;
        }
    }else{
        if (component == 0) {
            self.select_1 = row;
        }else{
            self.select_2 = row;
        }
    }
}

- (NSArray*)getYears{
    NSMutableArray *year = [NSMutableArray array];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    NSInteger nowYear = [[formatter stringFromDate:date] integerValue];
    NSInteger toYear = nowYear - 5;
    for (; nowYear > toYear; nowYear --) {
        [year addObject:[NSString stringWithFormat:@"%ld",nowYear]];
    }
    return year;
}

- (NSArray*)getMonth{
    NSMutableArray *month = [NSMutableArray array];
    for (NSInteger index = 1; index < 13; index++) {
        [month addObject:[NSString stringWithFormat:@"%ld",index]];
    }
    return month;
}

- (NSArray*)getDay:(NSString*)year month:(NSString*)month{
    NSMutableArray *day = [NSMutableArray array];
    BOOL isLeap = [self isLeap:year];
    NSInteger sum = 0;
    switch ([month integerValue]) {
        case 11:
        case 9:
        case 6:
        case 4:
            sum = 30;
            break;
        case 2:
            if (isLeap) {
                sum = 29;
            }else{
                sum = 28;
            }
            break;
        default:
            sum = 31;
            break;
    }
    for (NSInteger index = 0; index < sum; index++) {
        [day addObject:[NSString stringWithFormat:@"%ld",index + 1]];
    }
    return day;
}

- (NSArray*)getWeek{
    NSMutableArray *week = [NSMutableArray array];
    for (NSInteger index = 0; index < 52; index ++) {
        [week addObject:[NSString stringWithFormat:@"%ld",index + 1]];
    }
    return week;
}

- (BOOL)isLeap:(NSString*)year{
    BOOL isLeap = NO;
    NSInteger years = [year integerValue];
    if ((years % 4 == 0 && years % 400 != 0) || years % 400 == 0) {
        isLeap = YES;
    }
    return isLeap;
}


#pragma mark - 自定义方法

- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width).offset(-40);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.8);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [self.close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.equalTo(weakSelf.content.mas_top).offset(10);
        make.right.equalTo(weakSelf.content.mas_right).offset(-20);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.content.mas_width);
        make.height.mas_equalTo(1);
        make.centerX.equalTo(weakSelf.content.mas_centerX);
        make.top.equalTo(weakSelf.close.mas_bottom).offset(10);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(40);
        make.top.equalTo(weakSelf.topLine.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.content.mas_left).offset(30);
    }];
    [self.picker_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.content.mas_width);
        make.height.equalTo(weakSelf.content.mas_height).multipliedBy(0.4);
        make.bottom.equalTo(weakSelf.content.mas_bottom);
        make.left.equalTo(weakSelf.content.mas_left);
    }];
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(weakSelf.topLine);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(weakSelf.picker_1.mas_top).offset(-10);
    }];
    
    [self.choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.content).multipliedBy(0.7);
        make.centerX.equalTo(weakSelf.content.mas_centerX);
        make.bottom.equalTo(weakSelf.centerLine.mas_top).offset(-20);
        make.height.mas_equalTo(40);
    }];
    [self makeTypeBtns];
}

- (void)chooseDate{
    self.hidden = YES;
    NSString *result;
    switch (self.type) {
        case year:
            result = [self getYears][self.select_1];
            break;
        case month:
            result = [NSString stringWithFormat:@"%@-%@",[self getYears][self.select_1],[self getMonth][self.select_2]];
            break;
        case week:
            result = [NSString stringWithFormat:@"%@,%@",[self getYears][self.select_1],[self getWeek][self.select_2]];
            break;
        case day:
        {
            NSString *years = [self getYears][self.yearIndex];
            NSString *months = [self getMonth][self.monthIndex];
            NSString *days = [self getDay:years month:months][self.dayIndex];
            result = [NSString stringWithFormat:@"%@-%@-%@",years,months,days];
        }
            break;
    }
    if (self.dates) {
        self.dates(self.type,result);
    }
}

- (void)makeTypeBtns{
    NSArray *titles = [NSArray arrayWithObjects:@"按年",@"按月",@"按周",@"按日", nil];
    [self layoutIfNeeded];
    CGFloat w = (self.content.width - 90) / 4;
    for (NSInteger index = 0; index < 4; index ++) {
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-未选",titles[index]]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-选中",titles[index]]] forState:UIControlStateSelected];
        btn.tag = 2000 + index;
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(30 + index * (w + 10), self.title.frame.origin.y + 60, w, w + 10);
        [self.content addSubview:btn];
        [self.btns addObject:btn];
    }
    [self typeClick:self.btns[0]];
}

- (void)typeClick:(UIButton*)sender{
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }];
    switch (sender.tag - 2000) {
        case 0:
            //按年
            self.Component = 1;
            self.type = year;
            break;
        case 1:
            //按月
            self.Component = 2;
            self.type = month;
            break;
        case 2:
            //按周
            self.Component = 2;
            self.type = week;
            break;
        case 3:
            //按日
            self.Component = 3;
            self.type = day;
            break;
        default:
            break;
    }
    [self.picker_1 reloadAllComponents];
}

- (void)closeClick{
    self.hidden = YES;
}

#pragma mark - 懒加载

- (UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor redColor];
        _title.text = @"选择查询方式";
        [self.content addSubview:_title];
    }
    return _title;
}

- (UIView *)content{
    if (!_content) {
        _content = [UIView new];
        _content.backgroundColor = [UIColor whiteColor];
        [self addSubview:_content];
    }
    return _content;
}

- (UIButton *)close{
    if (!_close) {
        _close = [UIButton new];
        [_close setImage:[UIImage imageNamed:@"关闭icon"] forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [self.content addSubview:_close];
    }
    return _close;
}

- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (UIButton *)choose{
    if (!_choose) {
        _choose = [UIButton new];
        [_choose setBackgroundImage:[UIImage imageNamed:@"确----定背景框"] forState:UIControlStateNormal];
        [_choose setTitle:@"确\t定" forState:UIControlStateNormal];
        [_choose addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
        [self.content addSubview:_choose];
    }
    return _choose;
}

- (UIView *)topLine{
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = [UIColor hexColor:@"f1f2f3"];
        [self.content addSubview:_topLine];
    }
    return _topLine;
}

- (UIView *)centerLine {
    if (!_centerLine) {
        _centerLine = [UIView new];
        _centerLine.backgroundColor = [UIColor hexColor:@"f1f2f3"];
        [self.content addSubview:_centerLine];
    }
    return _centerLine;
}

- (UIPickerView *)picker_1{
    if (!_picker_1) {
        _picker_1 = [UIPickerView new];
        _picker_1.delegate = self;
        _picker_1.dataSource = self;
        _picker_1.showsSelectionIndicator = NO;
        [self.content addSubview:_picker_1];
    }
    return _picker_1;
}

@end
