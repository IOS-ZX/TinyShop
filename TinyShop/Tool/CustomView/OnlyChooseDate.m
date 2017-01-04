//
//  OnlyChooseDate.m
//  TinyShop
//
//  Created by rimi on 2017/1/4.
//  Copyright © 2017年 CXD. All rights reserved.
//

#import "OnlyChooseDate.h"

@interface OnlyChooseDate()<UIPickerViewDelegate,UIPickerViewDataSource>

/** 选择器 **/
@property(nonatomic,strong)UIPickerView *picker_1;

/** 年选中下标 **/
@property(nonatomic,assign)NSInteger yearIndex;

/** 月选中下标 **/
@property(nonatomic,assign)NSInteger monthIndex;

/** 日选中下标 **/
@property(nonatomic,assign)NSInteger dayIndex;

/** 确定按钮 **/
@property(nonatomic,strong)UIButton *chooseBtn;

/** contentView **/
@property(nonatomic,strong)UIView *content;

/** line **/
@property(nonatomic,strong)UIView *bottomLine;

@end

@implementation OnlyChooseDate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.hidden = YES;
        [self setUpUI];
    }
    return self;
}

#pragma mark - picker dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger num = 0;
    if (component == 0) {
        num = 5;
    }else if(component == 1){
        num = [self getMonth].count;
    }else{
        NSString *year = [self getYears][self.yearIndex];
        NSString *month = [self getMonth][self.monthIndex];
        num = [self getDay:year month:month].count;
    }
    return num;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * complateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.width / 3, 30)];
    complateLabel.backgroundColor = [UIColor clearColor];
    complateLabel.textColor = [UIColor hexColor:@"919191"];
    complateLabel.textAlignment = NSTextAlignmentCenter;
    complateLabel.font = [UIFont systemFontOfSize:18];
    if (component == 0) {
        complateLabel.text = [NSString stringWithFormat:@"%@年",[self getYears][row]];
    }else if(component == 1){
        complateLabel.text = [NSString stringWithFormat:@"%@月",[self getMonth][row]];
    }else{
        complateLabel.text = [NSString stringWithFormat:@"%@日",[self getDay:[self getYears][self.yearIndex] month:[self getMonth][self.monthIndex]][row]];
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
}

#pragma mark - 自定义方法

// 设置布局
- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width).offset(-40);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.45);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [self.picker_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.content.mas_width);
        make.height.equalTo(weakSelf.content.mas_height).offset(-80);
        make.bottom.equalTo(weakSelf.content.mas_bottom);
        make.centerX.equalTo(weakSelf.content.mas_centerX);
    }];
    
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(weakSelf.picker_1.mas_top).offset(-20);
        make.centerX.equalTo(weakSelf.content.mas_centerX);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.content.mas_width);
        make.height.mas_equalTo(1);
        make.left.equalTo(weakSelf.content.mas_left);
        make.bottom.equalTo(weakSelf.picker_1.mas_top);
    }];
}

// 确定
- (void)chooseDate{
    NSString *year = [self getYears][self.yearIndex];
    NSString *month = [self getMonth][self.monthIndex];
    NSString *day = [self getDay:year month:month][self.dayIndex];
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    self.hidden = YES;
    if (self.delegate) {
        [self.delegate chooseDatesOnlyForDate:date];
    }
}

// 获取年
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

// 获取月
- (NSArray*)getMonth{
    NSInteger sum = 13;
    NSString *year = [self getYears][self.yearIndex];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    NSString *nowYear = [formatter stringFromDate:date];
    if ([year integerValue] == [nowYear integerValue]) {
        [formatter setDateFormat:@"MM"];
        sum = [[formatter stringFromDate:date]integerValue] + 1;
    }
    NSMutableArray *month = [NSMutableArray array];
    for (NSInteger index = 1; index < sum; index++) {
        [month addObject:[NSString stringWithFormat:@"%ld",index]];
    }
    return month;
}

// 获取天数
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
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    NSString *nowYear = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MM"];
    NSString *nowMonth = [formatter stringFromDate:date];
    if ([year integerValue] == [nowYear integerValue] && [month integerValue] == [nowMonth integerValue]) {
        [formatter setDateFormat:@"dd"];
        sum = [[formatter stringFromDate:date]integerValue];
    }
    for (NSInteger index = 0; index < sum; index++) {
        [day addObject:[NSString stringWithFormat:@"%ld",index + 1]];
    }
    return day;
}

// 判断是否是闰年
- (BOOL)isLeap:(NSString*)year{
    BOOL isLeap = NO;
    NSInteger years = [year integerValue];
    if ((years % 4 == 0 && years % 400 != 0) || years % 400 == 0) {
        isLeap = YES;
    }
    return isLeap;
}


#pragma mark - 懒加载

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

- (UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton new];
        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"确----定背景框"] forState:UIControlStateNormal];
        [_chooseBtn setTitle:@"确\t定" forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventTouchUpInside];
        [self.content addSubview:_chooseBtn];
    }
    return _chooseBtn;
}

- (UIView *)content{
    if (!_content) {
        _content = [UIView new];
        _content.backgroundColor = [UIColor whiteColor];
        [self addSubview:_content];
    }
    return _content;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor hexColor:@"f1f2f3"];
        [self.content addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
