//
//  SettingViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "UIViewController+Common.h"
#import "PrefixHeader.pch"
#import "ProgressHUD.h"
#import <MessageUI/MessageUI.h>
@interface SettingViewController ()<MFMailComposeViewControllerDelegate>
@property (nonatomic,strong) UIButton *aBtn;
@property (nonatomic,strong) UIButton *ideaBtn;

@end
@implementation SettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    [self showBackButtonWithImage:@"back"];
    self.title = @"设置";
    [self.view addSubview:self.aBtn];
    [self.view addSubview:self.ideaBtn];
 
}
#pragma mark ---------- Lazyloading
- (UIButton *)aBtn{
    if (_aBtn == nil) {
        self.aBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.aBtn.frame = CGRectMake(10, 100, kWidth-20, 44);
        [self.aBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.aBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.aBtn.backgroundColor = [UIColor whiteColor];
        self.aBtn.layer.cornerRadius = 5;
        [self.aBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.aBtn.tag = 1;
    }
    return _aBtn;
}
- (UIButton *)ideaBtn{
    if (_ideaBtn == nil) {
        self.ideaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ideaBtn.frame = CGRectMake(10, 150, kWidth-20, 44);
        [self.ideaBtn setTitle:@"反馈意见" forState:UIControlStateNormal];
        [self.ideaBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.ideaBtn.backgroundColor = [UIColor whiteColor];
        self.ideaBtn.layer.cornerRadius = 5;
        [self.ideaBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.ideaBtn.tag = 2;
    }
    return _ideaBtn;
}

//分别点击三个按钮实现的方法
- (void)threeBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            break;
        case 2:{
            //发送邮件
            [self sendEmail];
        }
            break;
            
        default:
            break;
    }
}

//发送邮件
- (void)sendEmail{
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    if (mailClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
            //初始化发送邮件类对象
            MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
            //设置代理
            mailVC.mailComposeDelegate = self;
            //设置主题
            [mailVC setSubject:@"用户反馈"];
            //设置收件人
            NSArray *receive = [NSArray arrayWithObjects:@"1253409131@qq.com", nil];
            [mailVC setToRecipients:receive];
            //设置发送内容
            NSString *text = @"请留下您宝贵的意见";
            [mailVC setMessageBody:text isHTML:NO];
            //推出视图
            [self presentViewController:mailVC animated:YES completion:nil];
        }else{
            QJZLog(@"未配置邮箱账号");
        }
        
    }else{
        QJZLog(@"当前设备不能发送");
    }
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
