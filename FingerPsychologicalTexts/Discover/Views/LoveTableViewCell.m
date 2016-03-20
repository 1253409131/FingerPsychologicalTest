//
//  LoveTableViewCell.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "LoveTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation LoveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark -------- LoveModel
- (void)setLoveModel:(LoveModel *)loveModel{
    //图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:loveModel.image] placeholderImage:nil];
    //标题
    self.titleLable.text = loveModel.title;
    //测试人数
    self.viewnumLable.text = [NSString stringWithFormat:@"%@人测试",loveModel.viewnum];
    //评论人数
    self.commentnumLable.text = [NSString stringWithFormat:@"%@评论",loveModel.commentnum];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
