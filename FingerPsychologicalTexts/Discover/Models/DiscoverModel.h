//
//  DiscoverModel.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *viewnum;
@property (nonatomic, copy) NSString *commentnum;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dict;



@end
