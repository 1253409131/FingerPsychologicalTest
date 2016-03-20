//
//  ResultViewController.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (nonatomic, copy) NSString *viewnum;
@property (nonatomic, copy) NSString *commentnum;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *testId;
@property (nonatomic, copy) NSMutableArray *choicesIdArray;
@end
