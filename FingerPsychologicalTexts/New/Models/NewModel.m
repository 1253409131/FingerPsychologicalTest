//
//  NewModel.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewModel.h"

@implementation NewModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.image = dict[@"cover"];
        self.title = dict[@"title"];
        self.viewnum = dict[@"viewnum"];
        self.commentnum = dict[@"commentnum"];
        self.content = dict[@"content"];
        self.aId = dict[@"id"];
        
    }
    
    return self;
}
@end
