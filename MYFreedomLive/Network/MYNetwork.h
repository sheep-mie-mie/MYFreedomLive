//
//  MYNetwork.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/22.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYNetwork : NSObject

/**1
 HotView加载AD启动页

 @param success 成功
 @param failure 失败
 @param showView 加载页
 */
+ (void)getHotViewADInfoSuccess:(SuccessBlock)success
                        failure:(FailureBlock)failure
                       showView:(UIView *)showView;


/**2
 HotView直播人员信息
 
 @param page 第几页
 @param success 成功
 @param failure 失败
 @param showView 加载页
 */
+ (void)getHotViewPlayerInfoWithPage:(NSInteger)page
                             Success:(SuccessBlock)success
                            failure:(FailureBlock)failure
                           showView:(UIView *)showView;


/**3
 NewView直播人员信息

 @param page 第几页
 @param success 成功
 @param failure 失败
 @param showView 加载页
 */
+ (void)getNewViewPlayerInfoWithPage:(NSInteger)page
                             Success:(SuccessBlock)success
                             failure:(FailureBlock)failure
                            showView:(UIView *)showView;

/**4
 直播加载下一段视频

 @param url      视频网址
 @param success  成功
 @param failure  失败
 @param showView 加载
 */
+ (void)getLiveUrl:(NSString *)url
           Success:(SuccessBlock)success
           Failure:(FailureBlock)failure
          ShowView:(UIView *)showView;







@end
