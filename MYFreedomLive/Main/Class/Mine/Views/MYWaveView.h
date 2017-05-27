//
//  MYWaveView.h
//  MYFreedomLive
//
//  Created by ifly on 2017/5/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYWaveView : UIImageView


/**
 重写init方法

 @param frame     frame
 @param imageName 图片
 @param icon      头像
 @return          self
 */
- (instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName CenterIcon:(NSString *)icon;


/**
 开始波浪
 */
- (void)startWave;


/**
 结束波浪
 */
- (void)stopWave;


@end
