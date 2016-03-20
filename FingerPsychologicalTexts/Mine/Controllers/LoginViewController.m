//
//  LoginViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+Common.h"
#import <BmobSDK/Bmob.h>
#import "PrefixHeader.pch"
#import "ProgressHUD.h"
#import "NewViewController.h"
@interface LoginViewController ()<UITextFieldDelegate,BmobEventDelegate>
@property (nonatomic, strong) UITextField *emailTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    [self showBackButtonWithImage:@"back"];
    self.title = @"用户登录";
    //密文显示：
    self.passwordTF.secureTextEntry = YES;
    [self.view addSubview:self.emailTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginBtn];
    
}

#pragma mark ---------- Lazyloading

- (UITextField *)emailTF{
    if (_emailTF == nil) {
        self.emailTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 84, kWidth-20, 66)];
        self.emailTF.placeholder = @"邮箱";
        self.emailTF.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1.0];
        self.emailTF.backgroundColor = [UIColor whiteColor];
        //圆角
        self.emailTF.layer.cornerRadius = 5;
    }
    return _emailTF;
}


- (UITextField *)passwordTF{
    if (_passwordTF == nil) {
        self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 155, kWidth-20, 66)];
        self.passwordTF.placeholder = @"密码";
        self.passwordTF.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1.0];
        self.passwordTF.backgroundColor = [UIColor whiteColor];
        self.passwordTF.layer.cornerRadius = 5;
    }
    return _passwordTF;
}

- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginBtn.frame = CGRectMake(10, 300, kWidth-20, 44);
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginBtn.backgroundColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
        self.loginBtn.layer.cornerRadius = 5;
        [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)loginAction{
    [BmobUser loginWithUsernameInBackground:self.emailTF.text password:self.passwordTF.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            QJZLog(@"user = %@",user);
            [ProgressHUD showSuccess:@"登陆成功"];
        }else{
            [ProgressHUD showError:@"登录失败"];
        }
    }];
    
    NewViewController *newVC = [[NewViewController alloc] init];
    [self.navigationController pushViewController:newVC animated:YES];
}

#pragma mark ------------ UITextFieldDelegate
//点击右下角回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
//点击空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
