//
//  LoveModel.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoveModel : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *viewnum;
@property (nonatomic, copy) NSString *commentnum;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *category;
@property (nonatomic ,copy) NSString *loveId;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
