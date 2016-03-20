//
//  StartTextTableViewCell.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *viewnumLable;
@property (weak, nonatomic) IBOutlet UILabel *commentnumlable;
@property (weak, nonatomic) IBOutlet UIImageView *imageLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIButton *textBtn;

@property (nonatomic, strong) NSDictionary *dataDic;


@end
