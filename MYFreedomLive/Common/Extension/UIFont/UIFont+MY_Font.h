//
//  UIFont+MY_Font.h
//  MY_Rebirth
//
//  Created by ifly on 2017/2/15.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (MY_Font)

/**1
 字体 字号
 @param fontName 字体名称
 @param fontSize 字号
 @return 字体字号
 */
+ (UIFont *)my_FontWithName:(NSString *)fontName size:(CGFloat)fontSize;


/**2
 系统默认字体
 @param fontSize 字号
 @return 字号
 */
+ (UIFont *)my_SystemFontOfSize:(CGFloat)fontSize;


/**3
 粗体
 @param fontSize 字号
 @return 字号
 */
+ (UIFont *)my_BoldSystemFontOfSize:(CGFloat)fontSize;


/**4
 斜体
 @param fontSize 字号
 @return 字号
 */
+ (UIFont *)my_ItalicSystemFontOfSize:(CGFloat)fontSize;


@end
