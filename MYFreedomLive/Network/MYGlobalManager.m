//
//  MYGlobalManager.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/22.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYGlobalManager.h"

@implementation MYGlobalManager


/**
 创建单利
 */
+ (MYGlobalManager *)shareMYGlobManager {
    static MYGlobalManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MYGlobalManager alloc] init];
    });
    return manager;
}

/**
 返回字符串大小
 */
+ (CGSize)stringSizeWithString:(NSString *)string
                withWidthLimit:(CGFloat)width
                      withFont:(UIFont *)font {
    
    CGSize maxSize = CGSizeMake(width, 2000);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    CGSize realSize = [string boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return realSize;
}


// 判断字符串是否为空
+ (BOOL)isNilValue:(NSString *)value {
    if (value == nil || value.length <= 0 || [value isEqualToString:@""] || [value isEqualToString:@"(null)"]) {
        return YES;
    } else {
        return NO;
    }
}
























@end
