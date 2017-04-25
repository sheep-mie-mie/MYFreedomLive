//
//  UIImageView+MY_UIImageView.h
//  MYFreedomLive
//
//  Created by ifly on 2017/4/25.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MY_UIImageView)

/**
 播放GIF

 @param images 动画图片
 */
- (void)playGifAnimation:(NSArray *)images;


/**
 停止动画
 */
- (void)stopGifAnimation;


@end
