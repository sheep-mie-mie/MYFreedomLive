//
//  UIFont+MY_Font.m
//  MY_Rebirth
//
//  Created by ifly on 2017/2/15.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "UIFont+MY_Font.h"

@implementation UIFont (MY_Font)
/**
 字体 字号
 */
+ (UIFont *)my_FontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    return [UIFont fontWithName:fontName size:fontSize * AutoSizeScaleX];
}

/**
 系统默认字体
 */
+ (UIFont *)my_SystemFontOfSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize * AutoSizeScaleX];
}

/**
 粗体
 */
+ (UIFont *)my_BoldSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:fontSize * AutoSizeScaleX];
}

/**
 斜体
 */
+ (UIFont *)my_ItalicSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont italicSystemFontOfSize:fontSize * AutoSizeScaleX];
}


@end
