//
//  LoveTableViewCell.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoveModel.h"
#import "StarTextViewController.h"
@interface LoveTableViewCell : UITableViewCell
@property (nonatomic, strong) LoveModel *loveModel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *viewnumLable;
@property (weak, nonatomic) IBOutlet UILabel *commentnumLable;

@end
