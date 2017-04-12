//
//  MYBasicCollectionController.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYBasicCollectionController : UICollectionViewController


#pragma mark ==============//EmptyData\\==============

/**
 标题
 */
@property (nonatomic, copy  ) NSString *emptyDataTitle;
/**
 描述
 */
@property (nonatomic, copy  ) NSString *emptyDataDescription;
/**
 点击按钮 标题
 */
@property (nonatomic, copy  ) NSString *emptyDataButtonTitle;
/**
 图片名称
 */
@property (nonatomic, copy  ) NSString *emptyDataImageName;

/**
 正在加载中
 */
- (void)netWork_Loading;
/**
 加载失败
 */
- (void)netWork_Failure;
/**
 无数据加载
 */
- (void)netWork_EmptyData;

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
