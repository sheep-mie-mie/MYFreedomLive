//
//  UIView+MY_View.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/12.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "UIView+MY_View.h"

@implementation UIView (MY_View)
/**
 获取第一响应者
 */
- (UIViewController *)viewController {
    
    // 查询responder 直到viewController
    UIResponder *responder = self;
    do {
        responder = responder.nextResponder;
        
    } while (![responder isKindOfClass:[UIViewController class]]);
    
    return (UIViewController *)responder;
}


/**
 设置中间镂空的视图
 */
- (void)setHollowWithCenterFrame:(CGRect)centerFrame {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:[UIBezierPath bezierPathWithRect:self.frame]];
    [path appendPath:[UIBezierPath bezierPathWithRect:centerFrame].bezierPathByReversingPath];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path  = path.CGPath;
    self.layer.mask = maskLayer;
}


/**
 获取屏幕图片
 */
- (UIImage *)imageFromSelfView {
    return [self imageFromViewWithFrame:self.frame];
}

- (UIImage *)imageFromViewWithFrame:(CGRect)frame {
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(frame);
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/**
 设置高度一般的圆弧
 */
- (void)maskVIewToBoundsHalfHeight {
    self.layer.cornerRadius  = CGRectGetHeight(self.bounds) * 0.5;
    self.layer.masksToBounds = YES;
}






@end
