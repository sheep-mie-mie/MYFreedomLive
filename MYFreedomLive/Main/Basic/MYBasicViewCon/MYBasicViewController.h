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


/**
 Gif 加载状态
 */
@property (nonatomic, weak) UIImageView * gifView;

/**
 显示Gif加载动画

 @param images gif动画图片数组 不传 默认自带
 @param view   显示在哪个View上 不传默认是 view
 */
- (void)showGifLoading:(NSArray *)images inView:(UIView *)view;

/**
 隐藏动画
 */
- (void)hideGifLoading;

/**
 判断数组是否为空

 @param array 数组
 @return      YES / NO
 */
- (BOOL)isNotEmpty:(NSArray *)array;













@end
