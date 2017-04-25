
//
//  UIImageView+MY_UIImageView.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/25.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "UIImageView+MY_UIImageView.h"

@implementation UIImageView (MY_UIImageView)

/**
 播放GIF
 */
- (void)playGifAnimation:(NSArray *)images {
    if (!images.count) return;
    // 动画图片数组
    self.animationImages = images;
    // 执行一次动画所需时长
    self.animationDuration = 0.5;
    // 动画重复次数 设置成0 无限循环
    self.animationRepeatCount = 0;
    // 开始动画
    [self startAnimating];
}

/**
 停止动画
 */
- (void)stopGifAnimation {
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}






@end
