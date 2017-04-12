//
//  MYGlobalManager.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/22.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络

 @param returnData 返回数据
 */
typedef void(^SuccessBlock)(id returnData);
typedef void(^FailureBlock)(NSError *err);






@interface MYGlobalManager : NSObject


/**
 创建单利

 @return 单利对象
 */
+ (MYGlobalManager *)shareMYGlobManager;


/**
 返回字符串大小

 @param string 字符串
 @param width  最大宽度
 @param font   字号
 @return       字符串大小
 */
+ (CGSize)stringSizeWithString:(NSString *)string
                withWidthLimit:(CGFloat)width
                      withFont:(UIFont *)font;




























@end
