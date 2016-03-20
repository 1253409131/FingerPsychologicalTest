//
//  RegisterViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "RegisterViewController.h"
#import "PrefixHeader.pch"
#import "UIViewController+Common.h"
#import <BmobSDK/Bmob.h>
#import "ProgressHUD.h"
@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTF;//昵称
@property (nonatomic, strong) UITextField *emailTF;//邮箱
@property (nonatomic, strong) UITextField *passwordTF;//密码
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    [self showBackButtonWithImage:@"back"];
    //密文显示：
    self.passwordTF.secureTextEntry = YES;
    self.title = @"用户注册";
    [self.view addSubview:self.nameTF];
    [self.view addSubview:self.emailTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginBtn];
    
}

#pragma mark ---------- Lazyloading
- (UITextField *)nameTF{
    if (_nameTF == nil) {
        self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 84, kWidth-20, 60)];
        self.nameTF.placeholder = @"昵称";
        self.nameTF.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1.0];
        self.nameTF.backgroundColor = [UIColor whiteColor];
        self.nameTF.layer.cornerRadius = 5;
    }
    return _nameTF;
}
- (UITextField *)emailTF{
    if (_emailTF == nil) {
        self.emailTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, kWidth-20, 60)];
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
        self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 206, kWidth-20, 60)];
        self.passwordTF.placeholder = @"密码";
        self.passwordTF.textColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1.0];
        self.passwordTF.backgroundColor = [UIColor whiteColor];
        //圆角
        self.passwordTF.layer.cornerRadius = 5;
    }
    return _passwordTF;
}


- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginBtn.frame = CGRectMake(10, 350, kWidth-20, 44);
        [self.loginBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginBtn.backgroundColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
        self.loginBtn.layer.cornerRadius = 5;
        [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)login{
    QJZLog(@"注册");
    
    [ProgressHUD show:@"正在为您注册"];
    BmobUser *bUser = [[BmobUser alloc] init];
    
    [bUser setUsername:self.nameTF.text];
    [bUser setEmail:self.emailTF.text];
    [bUser setPassword:self.passwordTF.text];
    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"注册成功"];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜你" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                QJZLog(@"确定");
            }];
            UIAlertAction *candel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                QJZLog(@"取消");
            }];
            [alert addAction:action];
            [alert addAction:candel];
            [self presentViewController:alert animated:YES completion:nil];
                    }else{
            [ProgressHUD showError:@"注册失败"];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"很遗憾" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                QJZLog(@"确定");
            }];
            UIAlertAction *candel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                QJZLog(@"取消");
            }];
            [alert addAction:action];
            [alert addAction:candel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];

}

#pragma mark ------------ UITextFieldDelegate
//点击右下角回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
