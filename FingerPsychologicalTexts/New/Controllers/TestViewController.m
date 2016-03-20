//
//  TestViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "TestViewController.h"
#import "StarTextViewController.h"
#import "PrefixHeader.pch"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIViewController+Common.h"
#import "Header.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "TestModel.h"
#import "ResultViewController.h"
#import "ZMYNetManager.h"
#import "Reachability.h"
#import "TestModel.h"
@interface TestViewController ()
{
    NSInteger currentNum;
    CGFloat a;
    NSInteger btncount;
}
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UIScrollView *textScrollView;
@property (nonatomic, strong) UILabel *viewnumLable;
@property (nonatomic, strong) UILabel *commentnumLable;
@property (nonatomic, strong) UIProgressView *testProgressView;//进度条
//监控选择按钮进度
@property(nonatomic, retain) NSTimer *timer;
@property (nonatomic, strong) UILabel *jinduLable;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, strong) NSMutableArray *choicesArray;//选择按钮
@property (nonatomic, strong) NSMutableArray *choicesIdArray;//选择项的Id;
@property (nonatomic, strong) NSMutableArray *ceshiIdArray;//选择项的Id;
@property (nonatomic, strong) NSMutableArray *qinArray;//选择项的Id;
@end
@implementation TestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    a = 0.1;
    btncount = 0;
    [self loadData];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    [self showBackButtonWithImage:@"back"];
    [self.view addSubview:self.textScrollView];
    [self.textScrollView addSubview:self.viewnumLable];
    [self.textScrollView addSubview:self.commentnumLable];
    //添加进度条
    [self.textScrollView addSubview:self.testProgressView];
    [self.textScrollView addSubview:self.jinduLable];
    [self.textScrollView addSubview:self.titleLable];
    
    currentNum = 0;
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
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@&ceshi_id=%@",kTest,self.testId];
    QJZLog(@"----------%@",url);
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QJZLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QJZLog(@"responseObject = %@",responseObject);
        NSDictionary *dic = responseObject;
        NSArray *dataArray = dic[@"data"];
        for (NSDictionary *dict in dataArray) {
            NSArray *array = dict[@"choices"];
            [self.choicesArray addObject:array];
            TestModel *testModel = [[TestModel alloc] initWithContentDictionary:dict];
            QJZLog(@"array = %ld",(unsigned long) array.count);
            NSMutableArray *ceshiarray = [NSMutableArray new];
            for (NSDictionary *dicct in array) {
                NSString *idstring = dicct[@"id"];
                [ceshiarray addObject:idstring];
                QJZLog(@"%@", self.choicesIdArray);
            }
            [self.choicesIdArray addObject:ceshiarray];
            [self.testArray addObject:testModel];
            for (int i = 0; i < self.choicesArray.count; i++) {
                if ([self.choicesArray[i] count] < 3) {
                    [self.textScrollView addSubview:self.btn1];
                    [self.textScrollView addSubview:self.btn2];
                    
                }else{
                    [self.textScrollView addSubview:self.btn1];
                    [self.textScrollView addSubview:self.btn2];
                    [self.textScrollView addSubview:self.btn3];
                }
            }
        }
        //得到数据之后重新给界面控件添加值
        [self configViewWithTestModel:self.testArray[currentNum]];
        QJZLog(@"self.choicesIdArray =======%@", self.choicesIdArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QJZLog(@"error = %@",error);
    }];
}
- (void)configViewWithTestModel:(TestModel *)testModel {
    self.titleLable.text = testModel.title;
    [self.btn1 setTitle:testModel.firstChoices forState:UIControlStateNormal];
    [self.btn2 setTitle:testModel.secondChoices forState:UIControlStateNormal];
    if (![testModel.thirdChoices isEqualToString:testModel.secondChoices]) {
        [self.btn3 setTitle:testModel.thirdChoices forState:UIControlStateNormal];
    }
}
#pragma mark ---------- Lazy loading 
//可以滑动
- (UIScrollView *)textScrollView{
    if (_textScrollView == nil) {
        self.textScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        self.textScrollView.contentSize = CGSizeMake(kWidth, kHeight-64);
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
//用NSTimer监控进度
- (NSTimer *)timer{
    if (_timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(selectBtn:) userInfo:nil repeats:YES];
    }
    return _timer;
}
//进度：
- (UILabel *)jinduLable{
    if (_jinduLable == nil) {
        self.jinduLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, kWidth/4, 44)];
        self.jinduLable.text = @"进度:";
        self.jinduLable.font = [UIFont systemFontOfSize:14.0];
        self.jinduLable.textColor = [UIColor grayColor];
    }
    return _jinduLable;
}
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, kWidth - 20, 100)];
        self.titleLable.backgroundColor = [UIColor whiteColor];
        self.titleLable.numberOfLines = 0;
        self.titleLable.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLable;
}
#pragma mark ---------- 3个btn
- (UIButton *)btn1{
    if (_btn1 == nil) {
        self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn1.frame = CGRectMake(10, 245, kWidth - 20, 44);
        self.btn1.backgroundColor = [UIColor whiteColor];
        self.btn1.layer.cornerRadius = 5;
        [self.btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.btn1 setTitle:@"btn1" forState:UIControlStateNormal];
        self.btn1.font = [UIFont systemFontOfSize:15.0];
        [self.btn1 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btn1.tag = 1;
    }
    return _btn1;
}
- (UIButton *)btn2{
    if (_btn2 == nil) {
        self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2.frame = CGRectMake(10, 290, kWidth - 20, 44);
        self.btn2.backgroundColor = [UIColor whiteColor];
        self.btn2.layer.cornerRadius = 5;
        [self.btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.btn2.font = [UIFont systemFontOfSize:15.0];
        [self.btn2 setTitle:@"btn2" forState:UIControlStateNormal];
        [self.btn2 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btn2.tag = 2;
    }
    return _btn2;
}
- (UIButton *)btn3{
    if (_btn3 == nil) {
        self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn3.frame = CGRectMake(10, 335, kWidth - 20, 44);
        self.btn3.backgroundColor = [UIColor whiteColor];
        self.btn3.layer.cornerRadius = 5;
        [self.btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.btn3 setTitle:@"btn3" forState:UIControlStateNormal];
        self.btn3.font = [UIFont systemFontOfSize:15.0];
        [self.btn3 addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.btn3.tag = 3;
    }
    return _btn3;
}
- (NSMutableArray *)testArray{
    if (_testArray == nil) {
        self.testArray = [NSMutableArray new];
    }
    return _testArray;
}
//进度条
- (UIProgressView *)testProgressView{
    if (_testProgressView == nil) {
        //创建进度条实例
        self.testProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        //设置进度条大小
        self.testProgressView.frame = CGRectMake(120, 88, kWidth-130, 44);
        //设置进度条进度的颜色
        self.testProgressView.progressTintColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
    }
    return _testProgressView;
}
- (void)selectBtn:(UIButton *)btn{
    if (btncount < self.choicesIdArray.count) {
        self.qinArray = self.choicesIdArray[btncount];
        ;
    }
       switch (btn.tag) {
        case 1:
        {
            //不管点哪个按钮,创建一个全局的变量记录当前是第几个测试，默认是0
            if (currentNum < self.testArray.count - 1) {
                currentNum += 1;
                //设置进度
                if (self.testArray.count == 0) {
                    a = currentNum / 1;
                }else{
                    a = (float)currentNum / self.testArray.count;
                }
                [self.ceshiIdArray addObject:self.qinArray[0]];
                self.jinduLable.text = [NSString stringWithFormat:@"进度: %ld/%ld",(long)currentNum,(unsigned long)self.testArray.count];
                [self configViewWithTestModel:self.testArray[currentNum]];
            }else{
                [self submitBtn];
            }
        }
            break;
        case 2:
        {
            //不管点哪个按钮,创建一个全局的变量记录当前是第几个测试，默认是0
            if (currentNum < self.testArray.count - 1) {
                currentNum += 1;
                //设置进度
                if (self.testArray.count == 0) {
                    a = currentNum / 1;
                }else{
                    a = (float)currentNum / self.testArray.count;
                }
                [self.ceshiIdArray addObject:self.qinArray[1]];
                self.jinduLable.text = [NSString stringWithFormat:@"进度: %ld/%ld",(long)currentNum,(unsigned long)self.testArray.count];
                [self configViewWithTestModel:self.testArray[currentNum]];
            }else{
                [self submitBtn];
            }
        }
            break;
        case 3:{
            //不管点哪个按钮,创建一个全局的变量记录当前是第几个测试，默认是0
            if (currentNum < self.testArray.count - 1) {
                currentNum += 1;
                //设置进度
                if (self.testArray.count == 0) {
                    a = currentNum / 1;
                }else{
                    a = (float)currentNum / self.testArray.count;
                }
                [self.ceshiIdArray addObject:self.qinArray[2]];
                self.jinduLable.text = [NSString stringWithFormat:@"进度: %ld/%ld",(long)currentNum,(unsigned long)self.testArray.count];
                [self configViewWithTestModel:self.testArray[currentNum]];
                
            }else{
                [self submitBtn];
            }
        }
            break;
        default:
            break;
    }
    self.testProgressView.progress = a;
    btncount++;
}
//选择按钮数组
- (NSMutableArray *)choicesArray{
    if ( _choicesArray == nil) {
        self.choicesArray = [NSMutableArray new];
    }
    return _choicesArray;
}
//提交按钮
- (void)submitBtn{
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    for (int i = 0; i < self.choicesArray.count; i++) {
        if ([self.choicesArray[i] count] < 3) {
            submitBtn.frame = CGRectMake(kWidth-75, kWidth+18, 44, 40);
        }else{
           submitBtn.frame = CGRectMake(kWidth-75, kWidth+63, 44, 40);
        }
    }
        submitBtn.backgroundColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(result) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.cornerRadius = 5;
        submitBtn.font = [UIFont systemFontOfSize:14.0];
        [self.textScrollView addSubview:submitBtn];
}
- (void)result{
    ResultViewController *resultVC = [[ResultViewController alloc] init];
    //给测试结果页面设置标题
    resultVC.title = self.title;
    resultVC.viewnum = self.viewnum;
    resultVC.commentnum = self.commentnum;
    resultVC.testId = self.testId;
    resultVC.choicesIdArray = self.ceshiIdArray;
    QJZLog(@"self.ceshiIdArray = %@", self.ceshiIdArray);
    [self.navigationController pushViewController:resultVC animated:YES];
}
//选择项的Id
- (NSMutableArray *)choicesIdArray{
    if (_choicesIdArray == nil) {
        self.choicesIdArray = [NSMutableArray new];
    }
    return _choicesIdArray;
}
- (NSMutableArray *)ceshiIdArray{
    
    if (_ceshiIdArray == nil) {
        self.ceshiIdArray = [NSMutableArray new];
    }
    return _ceshiIdArray;
}
- (NSMutableArray *)qinArray{
    if (_qinArray == nil) {
        self.qinArray = [NSMutableArray alloc];
    }
    return _qinArray;
}
//当页面将要出现的时候隐藏tabBar
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
