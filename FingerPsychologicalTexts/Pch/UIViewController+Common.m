//
//  UIViewController+Common.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)


//导航栏添加返回按钮
- (void)showBackButtonWithImage:(NSString *)imageName{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//清扫手势
- (void)swipebackAction{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:recognizer];
    
}
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
