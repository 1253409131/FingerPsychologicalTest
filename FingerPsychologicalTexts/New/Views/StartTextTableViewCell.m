//
//  StartTextTableViewCell.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "StartTextTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PrefixHeader.pch"
@interface StartTextTableViewCell ()
//保存上一个图片的底部的高度
{
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *starTextScrollView;



@end
@implementation StartTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.starTextScrollView.contentSize = CGSizeMake(kWidth, 500);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
