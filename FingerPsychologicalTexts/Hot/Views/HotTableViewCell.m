//
//  HotTableViewCell.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "HotTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark --------- HotModel
- (void)setHotModel:(HotModel *)hotModel{
    //图片
    [self.hotImage sd_setImageWithURL:[NSURL URLWithString:hotModel.image] placeholderImage:nil];
    //标题
    self.hotTitleLable.text = hotModel.title;
    //测试人数
    self.viewnumLable.text = [NSString stringWithFormat:@"%@人测过",hotModel.viewnum];
    //评论人数
    self.commentLable.text = [NSString stringWithFormat:@"%@评论",hotModel.commentnum];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
