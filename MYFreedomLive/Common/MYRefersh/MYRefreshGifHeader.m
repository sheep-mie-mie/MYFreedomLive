//
//  MYRefreshGifHeader.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/24.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYRefreshGifHeader.h"

@implementation MYRefreshGifHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare {
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i<= 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"refresh%zd",i];
        UIImage *image = ImageNamed(imageName);
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}


@end
