//
//  MYNetwork.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/22.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYNetwork.h"

@implementation MYNetwork

/**1
 HotView启动页
 */
+ (void)getHotViewADInfoSuccess:(SuccessBlock)success
                        failure:(FailureBlock)failure
                       showView:(UIView *)showView {
    
    NSString *url = @"http://live.9158.com/Living/GetAD";
    [GDHNetworkingManager getRequstWithURL:url params:@{} successBlock:^(id returnData) {
        success(returnData);
    } failureBlock:^(NSError *error) {
        failure(error);
    } progress:^(int64_t bytesRead, int64_t totalBytesRead, int64_t totalBytesExpectedToRead) {
        
    } refreshCache:YES showView:showView];
}

/**2
 HotView直播人员信息
 */
+ (void)getHotViewPlayerInfoWithPage:(NSInteger)page
                             Success:(SuccessBlock)success
                             failure:(FailureBlock)failure
                            showView:(UIView *)showView {
    
    NSString *url = @"http://live.9158.com/Fans/GetHotLive";
    [GDHNetworkingManager getRequstWithURL:url params:@{@"page":@(page)} successBlock:^(id returnData) {
        success(returnData);
    } failureBlock:^(NSError *error) {
        failure(error);
    } progress:^(int64_t bytesRead, int64_t totalBytesRead, int64_t totalBytesExpectedToRead) {
        
    } refreshCache:YES showView:showView];
}

/**3
 NewView直播人员信息
 */
+ (void)getNewViewPlayerInfoWithPage:(NSInteger)page
                             Success:(SuccessBlock)success
                             failure:(FailureBlock)failure
                            showView:(UIView *)showView {
    
    NSString *url = @"http://live.9158.com/Room/GetNewRoomOnline";
    [GDHNetworkingManager getRequstWithURL:url params:@{@"page":@(page)} successBlock:^(id returnData) {
        success(returnData);
    } failureBlock:^(NSError *error) {
        failure(error);
    } progress:^(int64_t bytesRead, int64_t totalBytesRead, int64_t totalBytesExpectedToRead) {
        
    } refreshCache:YES showView:showView];
}


/**4
 直播加载下一段视频
 */
+ (void)getLiveUrl:(NSString *)url
           Success:(SuccessBlock)success
           Failure:(FailureBlock)failure
          ShowView:(UIView *)showView {
    [GDHNetworkingManager getRequstWithURL:url params:nil successBlock:^(id returnData) {
        success(returnData);
    } failureBlock:^(NSError *error) {
        failure(error);
    } progress:^(int64_t bytesRead, int64_t totalBytesRead, int64_t totalBytesExpectedToRead) {
        
    } refreshCache:YES showView:showView];
}




















@end
