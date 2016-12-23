//
//  LoginViewController.m
//  TinyShop
//
//  Created by 曹晓东 on 2016/12/21.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginControl.h"


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
@property(nonatomic,strong)UIView    *pwdView;

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
        make.size.mas_equalTo(CGSizeMake(SCREEN_W * 0.857, 2));
        make.left.equalTo(self.view.mas_left).offset(SCREEN_W * 0.071);
        make.top.equalTo(self.numberTextField.mas_bottom).offset(SCREEN_W * 0.0214);
    }];
    // 密码label
    [self.pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.numberLabel);
        make.left.equalTo(self.numberLabel.mas_left);
        make.top.equalTo(self.numberTextField.mas_bottom).offset(SCREEN_W * 0.0964);
    }];
    // 密码输入
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.numberTextField);
        make.left.equalTo(self.numberTextField.mas_left);
        make.top.equalTo(self.numberTextField.mas_bottom).offset(SCREEN_W * 0.0964);
    }];
    //底部线条
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.numView);
        make.left.equalTo(self.numView.mas_left);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(SCREEN_W * 0.0214);
    }];
    //记住密码按钮
    [self.rememberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 30));
        make.right.equalTo(self.pwdTextField.mas_right);
        make.top.equalTo(self.pwdView.mas_bottom).offset(15);
    }];
    //记住密码lebel
    [self.rememberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.equalTo(self.rememberBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.rememberBtn.mas_centerY);
    }];
    //登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.numView.mas_width);
        make.height.mas_equalTo(50);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.rememberLabel.mas_bottom).offset(30);
    }];
}

- (void)showPassword:(UIButton *)sender{
    self.pwdTextField.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

- (void)rememberPwd:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)login:(UIButton *)sender{
    [self loginInfo];
    NSDictionary *parameters = @{@"shop_account":self.storeTextField.text,@"user_account":self.numberTextField.text,@"user_password":self.pwdTextField.text};
    [LoginControl userLogin:parameters response:^(id result, NSError *error) {
        if (error) {
            
        }else{
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
        }
    }];
}

- (void)loginInfo{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (self.rememberBtn.selected) {
        [ud setObject:self.storeTextField.text forKey:@"shop_account"];
        [ud setObject:self.numberTextField.text forKey:@"user_account"];
        [ud setObject:self.pwdTextField.text forKey:@"user_password"];
        [ud setObject:@1 forKey:@"isRemember"];
    }else{
        [ud setObject:NULL forKey:@"shop_account"];
        [ud setObject:NULL forKey:@"user_account"];
        [ud setObject:NULL forKey:@"user_password"];
        [ud setObject:@0 forKey:@"isRemember"];
    }
}

- (void)readLoginInfo{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [ud objectForKey:@"isRemember"];
    if (num.integerValue == 1) {
        self.storeTextField.text = [ud objectForKey:@"shop_account"];
        self.numberTextField.text = [ud objectForKey:@"user_account"];
        self.pwdTextField.text = [ud objectForKey:@"user_password"];
        self.rememberBtn.selected = YES;
    }
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
    [self readLoginInfo];

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

- (UILabel *)pwdLabel{
    if (!_pwdLabel) {
        _pwdLabel = [UILabel new];
        _pwdLabel.font = self.numberLabel.font;
        _pwdLabel.textColor = self.numberLabel.textColor;
        _pwdLabel.text = @"密码:";
        [self.view addSubview:_pwdLabel];
    }
    return _pwdLabel;
}

- (UIButton *)visibleBtn{
    if (!_visibleBtn) {
        _visibleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
        [_visibleBtn setImage:[UIImage imageNamed:@"隐藏密码图标"] forState:UIControlStateNormal];
        [_visibleBtn setImage:[UIImage imageNamed:@"显示密码图标"] forState:UIControlStateSelected];
        [_visibleBtn addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _visibleBtn;
}

- (UITextField *)pwdTextField{
    if (!_pwdTextField) {
        _pwdTextField = [UITextField new];
        _pwdTextField.rightViewMode = UITextFieldViewModeAlways;
        _pwdTextField.rightView = self.visibleBtn;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.textColor = self.numberTextField.textColor;
        [self.view addSubview:_pwdTextField];
    }
    return _pwdTextField;
}


- (UIView *)pwdView{
    if (!_pwdView) {
        _pwdView = [UIView new];
        _pwdView.backgroundColor = self.numView.backgroundColor;
        [self.view addSubview:_pwdView];
    }
    return _pwdView;
}

- (UILabel *)rememberLabel{
    if (!_rememberLabel) {
        _rememberLabel = [UILabel new];
        _rememberLabel.text = @"记住密码";
        _rememberLabel.textColor = [UIColor grayColor];
        _rememberLabel.font = [UIFont systemFontOfSize:16];
        _rememberLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_rememberLabel];
    }
    return _rememberLabel;
}

- (UIButton *)rememberBtn{
    if (!_rememberBtn) {
        _rememberBtn = [UIButton new];
        [_rememberBtn setImage:[UIImage imageNamed:@"记住密码框"] forState:UIControlStateNormal];
        [_rememberBtn setImage:[UIImage imageNamed:@"记住密码"] forState:UIControlStateSelected];
        [_rememberBtn addTarget:self action:@selector(rememberPwd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_rememberBtn];
    }
    return _rememberBtn;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        [_loginBtn setImage:[UIImage imageNamed:@"登录按钮-"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

@end
