//
//  ResultViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "ResultViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "UIViewController+Common.h"
#import "Header.h"
#import "PrefixHeader.pch"
#import "ZMYNetManager.h"
#import "Reachability.h"
@interface ResultViewController ()
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UIScrollView *textScrollView;
@property (nonatomic, strong) UILabel *viewnumLable;
@property (nonatomic, strong) UILabel *commentnumLable;
@property (nonatomic, strong) UILabel *resultLable;
@property (nonatomic, strong) UIWebView *contentWeb;
@property (nonatomic, strong) NSMutableArray *allIdArray;
@property (nonatomic, strong) NSMutableDictionary *choicesDic;
@property(nonatomic, strong) NSString *idsrting;
@end
@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    [self showBackButtonWithImage:@"back"];
    [self.view addSubview:self.textScrollView];
    [self.textScrollView addSubview:self.viewnumLable];
    [self.textScrollView addSubview:self.commentnumLable];
    [self.textScrollView addSubview:self.resultLable];
    [self.textScrollView addSubview:self.contentWeb];
    QJZLog(@"self.choicesIdArray = %@", self.choicesIdArray);
    [self.choicesDic setValue:@"key" forKey:@"3a4b2a12539a916c040d069ae8ac8310"];
     [self.choicesDic setValue:@"ceshi_id" forKey:self.testId];
    for (int i = 0; i < self.choicesIdArray.count
         ; i++) {
        [self.choicesDic setValue:@"choice" forKey:self.choicesIdArray[i]];
    }
    QJZLog(@"%@", self.choicesDic);
    [self loadData];
}
- (void)loadData{
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QJZLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QJZLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html; charset=utf-8"];
    [sessionManager POST:kResult parameters:self.choicesDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        QJZLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
}
#pragma mark ---------- Lazy loading
//可以滑动
- (UIScrollView *)textScrollView{
    if (_textScrollView == nil) {
        self.textScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        self.textScrollView.contentSize = CGSizeMake(kWidth, kHeight - 64);
    }
    return _textScrollView;
}
- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        self.titleArray = [NSMutableArray new];
    }
    return _titleArray;
}
//测试人数
- (UILabel *)viewnumLable{
    if (_viewnumLable == nil) {
        self.viewnumLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 110, 44)];
        self.viewnumLable.text = [NSString stringWithFormat:@"%@人测过",self.viewnum];
        self.viewnumLable.font = [UIFont systemFontOfSize:14.0];
        self.viewnumLable.textColor = [UIColor  grayColor];
    }
    return _viewnumLable;
}
//评论人数
- (UILabel *)commentnumLable{
    if (_commentnumLable == nil) {
        self.commentnumLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 70, 44)];
        self.commentnumLable.text = [NSString stringWithFormat:@"%@评论",self.commentnum];
        self.commentnumLable.font = [UIFont systemFontOfSize:14.0];
        self.commentnumLable.textColor = [UIColor  grayColor];
    }
    return _commentnumLable;
}
- (UILabel *)resultLable{
    if (_resultLable == nil) {
        self.resultLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, kWidth-20, 44)];
        self.resultLable.backgroundColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
        self.resultLable.text = @"我的结果：";
        self.resultLable.textColor = [UIColor whiteColor];
        self.resultLable.textAlignment = UITextAlignmentLeft;
        self.resultLable.font = [UIFont systemFontOfSize:14.0];
    }
    return _resultLable;
}

-(UIWebView *)contentWeb {
    if (_contentWeb == nil) {
        self.contentWeb = [[UIWebView alloc] initWithFrame:CGRectMake(10, 105, kWidth-20, kHeight-64)];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.xinli001.com/ceshi/"]];
        [self.contentWeb loadRequest:request];
    }
    return _contentWeb;
}

- (NSMutableArray *)allIdArray{
    if (_allIdArray == nil) {
        self.allIdArray = [NSMutableArray new];
    }
    return _allIdArray;
}
- (NSMutableDictionary *)choicesDic{
    if (_choicesDic == nil) {
        self.choicesDic = [NSMutableDictionary new];
    }
    return _choicesDic;
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
