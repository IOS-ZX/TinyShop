//
//  LoginViewController.m
//  TinyShop
//
//  Created by 曹晓东 on 2016/12/21.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

/** logo **/
@property(nonatomic,strong)UIImageView    *logoImageView;

/** 店铺label **/
@property(nonatomic,strong)UILabel    *storeLabel;

/** 店铺输入框 **/
@property(nonatomic,strong)UITextField    *storeTextField;

/** 店铺线条 **/
@property(nonatomic,strong)UIView    *storeView;

/** 工号label **/
@property(nonatomic,strong)UILabel    *numberLabel;

/** 工号输入框 **/
@property(nonatomic,strong)UITextField    *numberTextField;

/** 工号线条 **/
@property(nonatomic,strong)UIView    *numView;

/** 密码label **/
@property(nonatomic,strong)UILabel     *pwdLabel;

/** 密码输入框 **/
@property(nonatomic,strong)UITextField    *pwdTextField;

/** 密码线条 **/
@property(nonatomic,strong)UIImageView    *pwdImageView;

/** 可见button **/
@property(nonatomic,strong)UIButton    *visibleBtn;

/** 记住密码Label **/
@property(nonatomic,strong)UILabel    *rememberLabel;

/** 记住密码Btn **/
@property(nonatomic,strong)UIButton    *rememberBtn;

/** 登录btn **/
@property(nonatomic,strong)UIButton    *loginBtn;

@end

@implementation LoginViewController

- (void)initializeDataSource
{
    
}


- (void)initilizeInterface
{
    // ------logo约束
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.308, SCREEN_W * 0.25));
        make.top.equalTo(self.view.mas_top).offset(SCREEN_W * 0.32);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    // ------店铺label约束
    [self.storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.157, 20));
        make.left.equalTo(self.view.mas_left).offset(SCREEN_W * 0.1285);
        make.top.equalTo(self.view.mas_top).offset(SCREEN_W * 0.75);
    }];
    
    // ------店铺输入框约束
    [self.storeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeLabel.mas_right).offset(5);
        make.top.equalTo(self.view.mas_top).offset(SCREEN_W * 0.75);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.575, 20));
        
    }];
    
    // ------店铺线条约束
    [self.storeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.857, 1));
        make.left.equalTo(self.view.mas_left).offset(SCREEN_W * 0.071);
        make.top.equalTo(self.storeLabel.mas_bottom).offset(SCREEN_W * 0.0214);
    }];
    
    // ------工号约束
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.157, 20));
        make.left.equalTo(self.view.mas_left).offset(SCREEN_W * 0.1285);
        make.top.equalTo(self.storeView.mas_bottom).offset(SCREEN_W * 0.0964);
    }];
    
    // ------工号输入框
    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.storeLabel.mas_right).offset(5);
        make.top.equalTo(self.storeView.mas_bottom).offset(SCREEN_W * 0.0964);
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.575, 20));
    }];
    
    // ------工号线条
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.857, 1));
        make.left.equalTo(self.view.mas_left).offset(SCREEN_W * 0.071);
        make.top.equalTo(self.numberTextField.mas_bottom).offset(SCREEN_W * 0.0214);
    }];
    
}

#pragma mark -- 懒加载
-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView  = [[UIImageView alloc] initWithFrame:CGRectZero];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        
        [self.view addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initilizeInterface];

}

-(UILabel *)storeLabel
{
    if (!_storeLabel) {
        _storeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _storeLabel.text = @"店铺:";
        _storeLabel.font = [UIFont systemFontOfSize:23];
        _storeLabel.textColor = [UIColor colorWithRed:229/255.0 green:60/255.0 blue:53/255.0 alpha:1];
//        _storeLabel.backgroundColor = [UIColor orangeColor];
        
        
        [self.view addSubview:_storeLabel];
    }
    return _storeLabel;
}

-(UITextField *)storeTextField
{
    if (!_storeTextField) {
        _storeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _storeTextField.borderStyle = UITextBorderStyleNone;
        _storeTextField.clearButtonMode = UITextFieldViewModeAlways;
        _storeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _storeTextField.font = [UIFont systemFontOfSize:20];
        _storeTextField.textColor = [UIColor colorWithRed:229/255.0 green:60/255.0 blue:53/255.0 alpha:1];
//        _storeTextField.rightViewMode = UITextFieldViewModeAlways;
//        _storeTextField.rightView = self.loginBtn;
        [self.view addSubview:_storeTextField];
    }
    return _storeTextField;
}

-(UIView *)storeView
{
    if (!_storeView) {
        _storeView = [[UIView alloc] initWithFrame:CGRectZero];
        _storeView.backgroundColor = [UIColor colorWithRed:229/255.0 green:60/255.0 blue:53/255.0 alpha:1];
        
        [self.view addSubview:_storeView];
    }
    return _storeView;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.text = @"工号:";
        _numberLabel.font = [UIFont systemFontOfSize:23];
        _numberLabel.textColor = [UIColor colorWithRed:229/255.0 green:60/255.0 blue:53/255.0 alpha:1];
        
        [self.view addSubview:_numberLabel];
    }
    return _numberLabel;
}

-(UITextField *)numberTextField
{
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _numberTextField.borderStyle = UITextBorderStyleNone;
        _numberTextField.clearButtonMode = UITextFieldViewModeAlways;
        _numberTextField.secureTextEntry = YES;
        _numberTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _numberTextField.textColor = [UIColor colorWithRed:229/255.0 green:60/255.0 blue:53/255.0 alpha:1];
        
        [self.view addSubview:_numberTextField];
    }
    return _numberTextField;
}

-(UIView *)numView
{
    if (!_numView) {
        _numView = [[UIView alloc] initWithFrame:CGRectZero];
        _numView.backgroundColor = [UIColor colorWithRed:229/255.0 green:60/255.0 blue:53/255.0 alpha:1];
        
        [self.view addSubview:_numView];
    }
    return _numView;
}






@end
