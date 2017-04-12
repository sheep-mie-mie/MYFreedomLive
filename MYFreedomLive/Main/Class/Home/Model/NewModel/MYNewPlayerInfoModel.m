//
//  MYNewPlayerInfoModel.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/28.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYNewPlayerInfoModel.h"

@implementation MYNewPlayerInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":@"MYNewPlayerInfoDataModel"};
}
@end

@implementation MYNewPlayerInfoDataModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"MYNewPlayerInfoDataListModel"};
}
@end

@implementation MYNewPlayerInfoDataListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"listNew":@"new"};
}
@end




