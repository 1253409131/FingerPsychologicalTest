//
//  TestModel.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

@property (nonatomic, copy) NSString *title;   //测试问题
@property (nonatomic, copy) NSString *ceshi_id;//测试Id
@property (nonatomic, copy) NSString *choicesId;
@property (nonatomic, copy) NSString *firstChoices; //测试第一个选项
@property (nonatomic, copy) NSString *firstId;//第一个选项的Id
@property (nonatomic, copy) NSString *secondChoices;//第二个选项
@property (nonatomic, copy) NSString *secondId;//第二个选项的Id
@property (nonatomic, copy) NSString *thirdChoices;//第三个选项
@property (nonatomic, copy) NSString *thirdId;//第三个选项的Id
@property (nonatomic, copy) NSString *forthChoices;//第四个选项

- (instancetype)initWithContentDictionary:(NSDictionary *)dic;

@end
