//
//  HotTableViewCell.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
@interface HotTableViewCell : UITableViewCell
@property (nonatomic, strong) HotModel *hotModel;
@property (weak, nonatomic) IBOutlet UIImageView *hotImage;
@property (weak, nonatomic) IBOutlet UILabel *hotTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *viewnumLable;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;

@end
