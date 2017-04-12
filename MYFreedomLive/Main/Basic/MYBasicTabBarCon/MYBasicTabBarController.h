//
//  MYBasicTabBarController.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <CYLTabBarController/CYLTabBarController.h>

@interface MYBasicTabBarController : CYLTabBarController


/**
 创建单利

 @return 单利对象
 */
+ (MYBasicTabBarController *)shareMainTabBar;


/**
 退出登录时 销毁单利
 */
+ (void)tabBarDestructSingleton;




@end
