//
//  AppDelegate.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "AppDelegate.h"
#import "MYPlusButtonSubClass.h"
#import "MYLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 使用第三方配置
    [self buildUpThreeInfoOption:launchOptions];
    // 主界面配置
    [self buildUpRootWindowLayout];
    
    return YES;
}


/**
 设置三方库配置

 @param launchOptions launchOptions
 */
- (void)buildUpThreeInfoOption:(NSDictionary *)launchOptions {
    
    // 网络状态
    [GDHNetworkingObject StartMonitoringNetworkStatus:^(GDHNetworkStatus status) {
        if (status == GDHNetworkStatusNotReachable) {
            SHOW_ALERT(@"网络连接断开,请检查网络");
        }
    }];
    [GDHNetworkingObject updateBaseUrl:@""];
    [GDHNetworkingObject enableInterfaceDebug:YES];
    [GDHNetworkingObject setTimeout:15];
    // 配置请求和响应类型 如果不支持json 请配置plainText
    [GDHNetworkingObject configRequestType:GDHRequestTypeJSON
                              responseType:GDHResponseTypeJSON
                       shouldAutoEncodeUrl:YES
                   callbackOnCancelRequest:NO];
    // 设置GET POST请求都缓存
    [GDHNetworkingObject cacheGetRequest:YES shoulCachePost:YES];
    // 设置缓存路劲
    [GDHNetworkingObject updateBaseCacheDocuments:@""];
    
    // IQKeyboardManager键盘
    IQKeyboardManager *keyboard = [IQKeyboardManager sharedManager];
    // 防止上滑过度,离得太远
    keyboard.preventShowingBottomBlankSpace = NO;
    // 控制整个功能是否开启
    keyboard.enable = YES;
    // 控制点击背景是否收起
    keyboard.shouldResignOnTouchOutside = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义
    keyboard.shouldToolbarUsesTextFieldTintColor = YES;
    // 多个输入框时 可以通过点击toolbar上的前后建实现移动光标输入
    keyboard.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    // 控制是否显示键盘上的工具条
    keyboard.enableAutoToolbar = YES;
    // 是否显示占位符
    keyboard.shouldShowTextFieldPlaceholder = YES;
    // 设置占位符字体大小
    keyboard.placeholderFont = [UIFont my_SystemFontOfSize:16.f];
    // 输入框距离键盘的距离
    keyboard.keyboardDistanceFromTextField = 12.f * AutoSizeScaleY;
    
}


/**
 设置主窗口
 */
- (void)buildUpRootWindowLayout {
    self.window = [[UIWindow alloc] initWithFrame:MAINSCREEN];
    self.window.backgroundColor = RandColor;
    [self.window makeKeyAndVisible];
    
    [MYPlusButtonSubClass registerPlusButton];
    
    MYLoginViewController *loginVC = [MYLoginViewController new];
    self.window.rootViewController = loginVC;
    
//    self.tabBar = [MYBasicTabBarController shareMainTabBar];
//    [self.window setRootViewController:self.tabBar];
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/**
 获取AppDelegate对象
 
 @return AppDelegate对象
 */
+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}



@end
