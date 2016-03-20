//
//  AppDelegate.m
//  FingerPsychologicalTexts
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "AppDelegate.h"
#import "NewViewController.h"
#import "HotViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"
#import <BmobSDK/Bmob.h>
#import "PrefixHeader.pch"
#import "Header.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [Bmob registerWithAppKey:kBmobAppkey];
    
    //UITableBarController
    UITabBarController *tableBarVC = [[UITabBarController alloc] init];
    //创建被tabBarVC管理的试图控制器
    
    
    //最新
    UIStoryboard *newStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
    UINavigationController *newNav = newStoryBoard.instantiateInitialViewController;
    newNav.tabBarItem.image = [UIImage imageNamed:@"latestImage1"];
    UIImage *newImage = [UIImage imageNamed:@"latestImage2"];
    newNav.title = @"最新";
    //tabBar设置选中的图片按照原始状态显示
    newNav.tabBarItem.selectedImage = [newImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //调整tabBar图片显示位置：按照上，下，左，右的顺序
    newNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //最热
    UIStoryboard *hotStoryBoard = [UIStoryboard storyboardWithName:@"HotStoryboard" bundle:nil];
    UINavigationController *hotNav = hotStoryBoard.instantiateInitialViewController;
    hotNav.tabBarItem.image = [UIImage imageNamed:@"hotestImage1"];
    UIImage *hotImage = [UIImage imageNamed:@"hotestImage2"];
    hotNav.title = @"最热";
    //tabBar设置选中的图片按照原始状态显示
    hotNav.tabBarItem.selectedImage = [hotImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //调整tabBar图片显示位置：按照上，下，左，右的顺序
    hotNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //发现
    UIStoryboard *discoverStoryBoard = [UIStoryboard storyboardWithName:@"DiscoverStoryboard" bundle:nil];
    UINavigationController *discoverNav = discoverStoryBoard.instantiateInitialViewController;
    discoverNav.tabBarItem.image = [UIImage imageNamed:@"findImage1"];
    UIImage *discoverImage = [UIImage imageNamed:@"findImage2"];
    discoverNav.title = @"发现";
    //tabBar设置选中的图片按照原始状态显示
    discoverNav.tabBarItem.selectedImage = [discoverImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //调整tabBar图片显示位置：按照上，下，左，右的顺序
    discoverNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    //我的
    UIStoryboard *mineStoryBoard = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    UINavigationController *mineNav = mineStoryBoard.instantiateInitialViewController;
    mineNav.tabBarItem.image = [UIImage imageNamed:@"myImage1"];
    UIImage *mineImage = [UIImage imageNamed:@"myImage2"];
    mineNav.title = @"我的";
    //tabBar设置选中的图片按照原始状态显示
    mineNav.tabBarItem.selectedImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //调整tabBar图片显示位置：按照上，下，左，右的顺序
    mineNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    tableBarVC.tabBar.barTintColor = [UIColor whiteColor];
    [UITabBar appearance].tintColor = [UIColor colorWithRed:57/255.0 green:190/255.0 blue:112/255.0 alpha:1.0];
    
    //添加被管理的视图控制器
    tableBarVC.viewControllers = @[newNav,hotNav,discoverNav,mineNav];
    self.window.rootViewController = tableBarVC;
    
    
    
    

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
