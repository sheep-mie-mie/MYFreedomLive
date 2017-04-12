//
//  MYHotPlayerInfoModel.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/23.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerInfoModel.h"

@implementation MYHotPlayerInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":@"MYHotPlayerInfoDataModel"};
}
@end

@implementation MYHotPlayerInfoDataModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"MYHotPlayerInfoDataListModel"};
}
@end

@implementation MYHotPlayerInfoDataListModel



@end





