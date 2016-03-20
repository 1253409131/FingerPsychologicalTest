//
//  StartTextView.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "StartTextView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface StartTextView ()
//保存上一个图片底部的高度
{
    CGFloat _previousImageBottom;
    CGFloat _lastLabelBottom;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *starTextScrollerView;
@end

@implementation StartTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自定义视图
        [self configView];
    }
    return self;
}

#pragma mark -------- 自定义视图
- (void)configView{
    [self addSubview:self.starTextScrollerView];
    [self.starTextScrollerView addSubview:self.imageView];
    
    
}

#pragma mark ------------- setDataDic
//在set方法中赋值
- (void)setDataDic:(NSDictionary *)dataDic{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]] placeholderImage:nil];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
