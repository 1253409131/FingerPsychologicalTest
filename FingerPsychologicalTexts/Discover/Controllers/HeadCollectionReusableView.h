//
//  HeadCollectionReusableView.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"


@protocol PressBtnDelegate <NSObject>

- (void)pressBtnTypes:(PressButtonType)pressBtnType;//定义协议的方法

@end

@interface HeadCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *loverBtn;
@property (weak, nonatomic) IBOutlet UIButton *characterBtn;
@property (weak, nonatomic) IBOutlet UIButton *powerBtn;
@property (weak, nonatomic) IBOutlet UIButton *memberBtn;
@property (weak, nonatomic) IBOutlet UIButton *majorBtn;

@property (nonatomic, retain) id <PressBtnDelegate>delegate;

@end
