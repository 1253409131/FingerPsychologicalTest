//
//  NewTableViewCell.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
#import "StarTextViewController.h"
@interface NewTableViewCell : UITableViewCell
@property (nonatomic, strong) NewModel *newsModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageNew;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *viewnumNew;

@property (weak, nonatomic) IBOutlet UILabel *commwetnumNew;

@end
