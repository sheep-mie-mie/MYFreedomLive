//
//  UIImage+MY_Image.h
//  MYFreedomLive
//
//  Created by ifly on 2017/4/12.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MY_Image)

/**
 加模糊效果

 @param imge 图片
 @param blur 模糊度
 @return     加模糊效果的图片
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;


/**
 使用GPUImage

 @param view 确定Frame的view
 @param blur 模糊度 最大12
 @return     返回一张添加模糊效果图
 */
+ (UIImage *)blurryView:(UIView *)view blurRadiusInPixels:(CGFloat)blur;


/**
 使用GPUImage设置模糊效果

 @param image 传入Image
 @param blur  模糊度 最大12
 @return      返回一个模糊效果图
 */
+ (UIImage *)blurryImage:(UIImage *)image blurRadiusInPixels:(CGFloat)blur;


/**
 生成圆角图片

 @param originImage 原始图片
 @param borderColor 边框颜色
 @param borderWidth 变宽宽度
 @return            圆形边框图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;















@end
