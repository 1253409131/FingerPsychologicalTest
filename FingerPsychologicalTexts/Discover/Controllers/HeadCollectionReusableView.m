//
//  HeadCollectionReusableView.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "HeadCollectionReusableView.h"
#import "PrefixHeader.pch"
#import "LoveViewController.h"
#import "CharacterViewController.h"
#import "PowerViewController.h"
#import "MemmberViewController.h"
#import "MajorViewController.h"
#import "LikePlayViewController.h"

@implementation HeadCollectionReusableView
//你可以写一个代理，当点击这五个按钮的时候执行同一个代理方法，然后给遵循代理的传一个值区分这几个按钮

- (IBAction)loveBtn:(id)sender {
    QJZLog(@"%s",__FUNCTION__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressBtnTypes:)]) {
        [self.delegate pressBtnTypes:PressButtonTypeLove];
    }
}
- (IBAction)characterBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressBtnTypes:)]) {
        [self.delegate pressBtnTypes:PressButtonTypeCharacter];
    }
}
- (IBAction)powerBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressBtnTypes:)]) {
        [self.delegate pressBtnTypes:PressButtonTypePower];
    }
}
- (IBAction)memberBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressBtnTypes:)]) {
        [self.delegate pressBtnTypes:PressButtonTypeMember];
    }
}
- (IBAction)majorBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressBtnTypes:)]) {
        [self.delegate pressBtnTypes:PressButtonTypeMajor];
    }
}



@end
