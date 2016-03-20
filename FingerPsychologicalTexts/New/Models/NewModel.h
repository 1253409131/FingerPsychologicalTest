//
//  NewModel.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewModel : NSObject
@property (nonatomic, copy) NSString *image;//图片
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *viewnum;//测试人数
@property (nonatomic, copy) NSString *commentnum;//评论人数
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *aId;


- (instancetype)initWithDictionary:(NSDictionary *)dict;





@end
