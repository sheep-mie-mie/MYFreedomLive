//
//  AppDelegate.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/**
 工具栏
 */
@property (nonatomic, strong) MYBasicTabBarController *tabBar;


/**
 获取AppDelegate对象

 @return AppDelegate对象
 */
+ (AppDelegate *)shareAppDelegate;


@end

