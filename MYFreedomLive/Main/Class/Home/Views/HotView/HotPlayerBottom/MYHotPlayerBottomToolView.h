//
//  MYHotPlayerBottomToolView.h
//  MYFreedomLive
//
//  Created by ifly on 2017/4/13.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYHotPlayerBottomToolView : UIView



/**
 创建底部工具栏视图

 @param frame 视图大小
 @param tools 工具栏数组
 @return      工具栏视图
 */
//- (instancetype)initWithFrame:(CGRect)frame withBoomTools:(NSArray *)tools;


/**
 点击工具栏Block
 */
@property (nonatomic, copy  ) void(^clickToolBottomBlock)(NSInteger tapNum);



@end
