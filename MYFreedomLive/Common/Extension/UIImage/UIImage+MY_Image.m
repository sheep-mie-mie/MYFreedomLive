//
//  UIImage+MY_Image.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/12.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "UIImage+MY_Image.h"
#import <Accelerate/Accelerate.h>
#if __has_include(<GPUImage/GPUImage.h>)
#import <GPUImage/GPUImage.h>
#else
#import "GPUImage.h"
#endif


@implementation UIImage (MY_Image)

/**
 添加模糊效果
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    // 模糊度越界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    // 从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    // 设置从CGImage获取对象的属性
    inBuffer.width    = CGImageGetWidth(img);
    inBuffer.height   = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data     = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if (pixelBuffer == NULL) {
        NSLog(@"No Pixelbuffer");
    }
    
    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(img);
    outBuffer.height   = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"Error Form Convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef  = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/**
 使用GPUImage设置模糊效果
 */
+ (UIImage *)blurryView:(UIView *)view blurRadiusInPixels:(CGFloat)blur {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *capteredScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    GPUImageiOSBlurFilter *blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = blur;
    return [blurFilter imageByFilteringImage:capteredScreen];
}

/**
 使用GPUImage设置模糊效果
 */
+ (UIImage *)blurryImage:(UIImage *)image blurRadiusInPixels:(CGFloat)blur {
    GPUImageiOSBlurFilter *blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = blur;
    return [blurFilter imageByFilteringImage:image];
}

/**
 生成圆角边框图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    // 设置边框宽度
    CGFloat imgWidth = originImage.size.width;
    // 计算外圆的尺寸
    CGFloat ovalWidth = imgWidth + 2 * borderWidth;
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    // 画一个大的圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWidth, ovalWidth)];
    [borderColor set];
    [path fill];
    // 设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imgWidth, imgWidth)];
    [clipPath addClip];
    // 绘制图片
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    // 从上下文中获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;
}



@end
