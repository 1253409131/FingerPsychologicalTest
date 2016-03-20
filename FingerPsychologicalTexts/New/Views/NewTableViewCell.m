//
//  NewTableViewCell.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation NewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

#pragma mark ----------- NewModel
- (void)setNewsModel:(NewModel *)newsModel{
    //图片
    [self.imageNew sd_setImageWithURL:[NSURL URLWithString:newsModel.image] placeholderImage:nil];
    
    //标题
    self.titleLable.text = newsModel.title;
    //测试人数
    self.viewnumNew.text = [NSString stringWithFormat:@"%@人测过",newsModel.viewnum];
    //评论人数
    self.commwetnumNew.text = [NSString stringWithFormat:@"%@评论",newsModel.commentnum];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
