//
//  UIView+MY_View.h
//  MYFreedomLive
//
//  Created by ifly on 2017/4/12.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MY_View)


/**
 获取第一响应者
 */
@property (nonatomic, strong, readonly) UIViewController *viewController;


/**
 设置镂空中间的视图

 @param centerFrame 中间镂空的框架
 */
- (void)setHollowWithCenterFrame:(CGRect)centerFrame;


/**
 获取屏幕图片

 @return UIImage的对象
 */
- (UIImage *)imageFromSelfView;


/**
 设置高度一般的圆弧
 */
- (void)maskVIewToBoundsHalfHeight;


@end
