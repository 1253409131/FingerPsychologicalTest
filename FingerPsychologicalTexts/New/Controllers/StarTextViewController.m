//
//  StarTextViewController.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "StarTextViewController.h"
#import "NewViewController.h"
#import "NewModel.h"
#import "NewTableViewCell.h"
#import "PrefixHeader.pch"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TestViewController.h"
#import "UIViewController+Common.h"
@interface StarTextViewController ()
@property (nonatomic, strong) UIScrollView *startScrollView;

@property (nonatomic, strong) UILabel *viewnumLable;//测试人数
@property (nonatomic, strong) UILabel *commentnumLable;//评论人数
@property (nonatomic, strong) UIImageView *imageView;//图片
@property (nonatomic, strong) UILabel *contentLable;//内容
@property (nonatomic, strong) UIButton *btn;//测试按钮
@property (nonatomic, strong) UILabel *aLable;//提示
@end

@implementation StarTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self showBackButtonWithImage:@"back"];

    [self.view addSubview:self.startScrollView];
    [self.startScrollView addSubview:self.viewnumLable];
    [self.startScrollView addSubview:self.commentnumLable];
    [self.startScrollView addSubview:self.imageView];
    [self.startScrollView addSubview:self.contentLable];
    [self.startScrollView addSubview:self.btn];
    [self.startScrollView addSubview:self.aLable];
    
}

#pragma mark ----------- Lazy loadign
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
//图片
- (UIImageView *)imageView{
    if (_imageView == nil) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 44, kWidth-20, kWidth-165)];
        self.imageView.backgroundColor = [UIColor cyanColor];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.image] placeholderImage:nil];
    }
    return _imageView;
}
//内容
- (UILabel *)contentLable{
    if (_contentLable == nil) {
        self.contentLable = [[UILabel alloc] initWithFrame:CGRectMake(10, kWidth-121, kWidth-20, kWidth-200)];
        self.contentLable.text = self.content;
        self.contentLable.numberOfLines = 0;
        self.contentLable.font = [UIFont systemFontOfSize:15.0];
        self.contentLable.textColor = [UIColor  grayColor];
    }
    return _contentLable;
}
//点击 开始测试 按钮
- (UIButton *)btn{
    if (_btn == nil) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(kWidth/3, kWidth+60, kWidth/3, 44);
        self.btn.backgroundColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
        [self.btn setTitle:@"开始测试" forState:UIControlStateNormal];
        self.btn.layer.cornerRadius = 5;
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(textBegin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (UILabel *)aLable{
    if (_aLable == nil) {
        self.aLable = [[UILabel alloc] initWithFrame:CGRectMake(0, kWidth+100, kWidth, 44)];
        self.aLable.textAlignment = NSTextAlignmentCenter;
        self.aLable.text = @"此测试仅供娱乐，不做专业指导";
        self.aLable.font = [UIFont systemFontOfSize:13.0];
        self.aLable.textColor = [UIColor  grayColor];
    }
    return _aLable;
}
//可以滑动效果
- (UIScrollView *)startScrollView{
    if (_startScrollView == nil) {
        self.startScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        //只有设置了contentSize才有滑动的效果
        self.startScrollView.contentSize = CGSizeMake(kWidth, kHeight-64);
    }
    return _startScrollView;
}

//点击按钮开始测试
- (void)textBegin:(UIButton *)btn{
    TestViewController *testVC = [[TestViewController alloc] init];
    
    //给测试结果页面设置标题
    testVC.title = self.title;
    testVC.viewnum = self.viewnum;
    testVC.commentnum = self.commentnum;
    testVC.testId = self.startId;
 
    [self.navigationController pushViewController:testVC animated:YES];
    
    
    QJZLog(@"开始测试");
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
