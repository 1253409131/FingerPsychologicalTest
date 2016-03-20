//
//  Header.h
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PressButtonTypeLove = 1,
    PressButtonTypeCharacter,
    PressButtonTypePower,
    PressButtonTypeMember,
    PressButtonTypeMajor,
    PressButtonTypeLikePlay,
    
} PressButtonType;




//最新：
#define kNew @"http://bapi.xinli001.com/ceshi/ceshis.json/?category_id=0&rows=10&key=3a4b2a12539a916c040d069ae8ac8310&offset=0&rmd=-1"


//最热：
#define kHot @"http://bapi.xinli001.com/ceshi/host_ceshi_list.json/?rows=10&offset=0"

//发现：
#define kDiscover @"http://bapi.xinli001.com/ceshi/day_ceshi_list.json/?rows=4&offset=0"

//发现：
//图片：
//http://image.xinli001.com/20151125/154823jf0ex0r5jhaytvt0.jpg
//发现->爱情测试
#define kLove @"http://bapi.xinli001.com/ceshi/ceshis.json/?rows=10&key=3a4b2a12539a916c040d069ae8ac8310&offset=0&rmd=-1"

////发现->性格测试
//#define kCharacter @"http://bapi.xinli001.com/ceshi/ceshis.json/?category_id=2&rows=10&key=3a4b2a12539a916c040d069ae8ac8310&offset=0&rmd=-1"
//
////发现->能力测试
//#define kPower @"http://bapi.xinli001.com/ceshi/ceshis.json/?category_id=3&rows=10&key=3a4b2a12539a916c040d069ae8ac8310&offset=0&rmd=-1"
////发现->会员测试
//#define kMember @"http://bapi.xinli001.com/ceshi/ceshis.json/?category_id=4&rows=10&key=3a4b2a12539a916c040d069ae8ac8310&offset=0&rmd=-1"
//
////发现->专业测试
//#define kMajor @"http://bapi.xinli001.com/ceshi/ceshis.json/?category_id=5&rows=10&key=3a4b2a12539a916c040d069ae8ac8310&offset=0&rmd=-1"

//发现->好玩应用（空）
//编辑推荐：4个：
//http://bapi.xinli001.com/ceshi/day_ceshi_list.json/?rows=4&offset=0
//1.你是小王子里的谁？
//http://bapi.xinli001.com/ceshi/questions.json/?key=3a4b2a12539a916c040d069ae8ac8310&ceshi_id=900
//2.测是什么主导了你的大脑？
//http://bapi.xinli001.com/ceshi/questions.json/?key=3a4b2a12539a916c040d069ae8ac8310&ceshi_id=99897417
//3.测测你的人际魅力低多少
//http://bapi.xinli001.com/ceshi/questions.json/?key=3a4b2a12539a916c040d069ae8ac8310&ceshi_id=99897376
//4.测你恋爱是有多投入？
//http://bapi.xinli001.com/ceshi/questions.json/?key=3a4b2a12539a916c040d069ae8ac8310&ceshi_id=99897392

//测试问题
#define kTest @"http://bapi.xinli001.com/ceshi/questions.json/?key=3a4b2a12539a916c040d069ae8ac8310"

//http://bapi.xinli001.com/ceshi/questions.json/?key=3a4b2a12539a916c040d069ae8ac8310&ceshi_id=1836
//http://bapi.xinli001.com/ceshi/questions.json/?key=3a4b2a12539a916c040d069ae8ac8310&ceshi_id=99897351


//测试结果
#define kResult @"http://bapi.xinli001.com/ceshi/result.json/"

//bmob
#define kBmobAppkey @"51cbc991eb4693953aa76cb7330c5c4c"









#endif /* Header_h */
