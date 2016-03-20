//
//  TestModel.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "TestModel.h"
@implementation TestModel

- (instancetype)initWithContentDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.ceshi_id = dic[@"ceshi_id"];
        NSArray *choicesArray = dic[@"choices"];
        if (choicesArray.count >= 1) {
            NSDictionary *dict1 = choicesArray[0];
            self.firstChoices = dict1[@"title"];
            self.firstId = dict1[@"id"];
        }
        if (choicesArray.count >= 2) {
            NSDictionary *dict2 = choicesArray[1];
            self.secondChoices = dict2[@"title"];
            self.secondId = dict2[@"id"];
        }
        if (choicesArray.count >= 3) {
            NSDictionary *dict3 = choicesArray[2];
            self.thirdChoices = dict3[@"title"];
            self.thirdId = dict3[@"id"];
        }    
    }
    return self;
}

@end
