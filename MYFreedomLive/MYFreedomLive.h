//
//  MYFreedomLive.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#ifndef MYFreedomLive_h
#define MYFreedomLive_h

/**
 屏幕尺寸
 */
#define MAINSCREEN        [[UIScreen mainScreen] bounds]
#define MAINSCREEN_SIZE   MAINSCREEN.size
#define MAINSCREEN_WIDTH  MAINSCREEN_SIZE.width
#define MAINSCREEN_HEIGHT MAINSCREEN_SIZE.height

/**
 屏蔽比例 -- Iphone4S除外
 */
#define AutoSizeScaleX          [[UIScreen mainScreen] bounds].size.width/375.0
#define AutoSizeScaleY          [[UIScreen mainScreen] bounds].size.height/667.0
/**
 数据本地储存
 */
#define DEFAULTS                [NSUserDefaults standardUserDefaults]
/**
 storyBoard
 */
#define UISTORYBOARD(a)         [UIStoryboard storyboardWithName:a bundle:nil]

/**
 imageNamed
 */
#define ImageNamed(a)           [UIImage imageNamed:a]
/**
 随机色
 */
#define RandColor RandColorNum(255.0f)
#define RandColorNum(a) SXRGBAColor(arc4random_uniform(a), arc4random_uniform(a), arc4random_uniform(a), 1.0)
//主颜色
#define MainSelectColor SXRGBAColor(223.f, 91.f, 147.f, 1.0f)
#define MainNormalColor SXRGBAColor(240.f, 240.f, 240.f, 1.0f)


/**
 手机系统
 */
#define IOS [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS4  ( IOS <  5.0)
#define IOS7  ( IOS >= 7.0)
#define IOS8  ( IOS >= 8.0)
#define IOS9  ( IOS >= 9.0)
#define IOS10 ( IOS >= 10.0)




/**
 项目打包上线都不会打印日志，因此可放心。
 */
#ifdef DEBUG
#define GEdwardLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define GEdwardLog(s, ... )
#endif












#endif /* MYFreedomLive_h */
