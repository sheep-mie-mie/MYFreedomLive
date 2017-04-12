//
//  MYBasicViewController.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYBasicViewController : UIViewController

@property (nonatomic, retain) MBProgressHUD *hud;

/**
 添加加载框
 */
- (void)addHud;

/**
 添加加载框

 @param message 提示语
 */
- (void)addHudWithMessage:(NSString *)message;

/**
 移除加载框
 */
- (void)removeHud;

@end
