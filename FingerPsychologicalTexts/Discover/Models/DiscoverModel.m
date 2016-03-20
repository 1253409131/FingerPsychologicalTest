//
//  DiscoverModel.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.image = dict[@"cover"];
        self.title = dict[@"title"];
        self.viewnum = dict[@"viewnum"];
        self.commentnum = dict[@"commentnum"];
        self.content = dict[@"content"];
        
    }
    return self;
}
@end
