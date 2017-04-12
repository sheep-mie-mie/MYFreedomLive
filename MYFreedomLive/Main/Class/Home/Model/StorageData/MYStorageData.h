//
//  MYStorageData.h
//  MYFreedomLive
//
//  Created by ifly on 2017/4/12.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYHotPlayerInfoModel.h"

@interface MYStorageData : NSObject

/**
 创建单利

 @return 单利对象
 */
+ (MYStorageData *)shareMYStorageData;

/**
 数据源数组
 */
@property (nonatomic, strong, readonly) NSMutableArray <MYHotPlayerInfoDataListModel *> *allModels;

/**
 保存数据
 */
- (BOOL)saveData:(MYHotPlayerInfoDataListModel *)model;

/**
 删除数据
 */
- (BOOL)deleteData:(MYHotPlayerInfoDataListModel *)model;

/**
 当前model是否已经存在本地
 */
- (BOOL)dataIsExistence:(MYHotPlayerInfoDataListModel *)model;





@end
