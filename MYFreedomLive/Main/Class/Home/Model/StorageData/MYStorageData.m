//
//  MYStorageData.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/12.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYStorageData.h"

#define MYFreedDealDataPlist [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MYFreedDealData.plist"]

@interface MYStorageData ()
/**
 数据源数组
 */
@property (nonatomic, strong, readwrite) NSMutableArray <MYHotPlayerInfoDataListModel *>* allModels;

@property (nonatomic, strong) NSMutableArray *array;
@end


@implementation MYStorageData

/**
 单利
 */
+ (MYStorageData *)shareMYStorageData {
    static dispatch_once_t onceToken;
    static MYStorageData *myStorageData;
    dispatch_once(&onceToken, ^{
        myStorageData = [[MYStorageData alloc] init];
    });
    return myStorageData;
}

- (BOOL)dataIsExistence:(MYHotPlayerInfoDataListModel *)model {
    BOOL isExistence = false;
    for (MYHotPlayerInfoDataListModel *obj in [MYStorageData shareMYStorageData].allModels) {
        if ([obj.flv isEqualToString:model.flv]) {
            isExistence = true;
            break;
        }
    }
    return isExistence;
}

- (NSArray <MYHotPlayerInfoDataListModel *>*)DictionaryConversionModel:(NSArray *)items {
    NSMutableArray <MYHotPlayerInfoDataListModel *> *models = [NSMutableArray new];
    for (id item in items) {
        [models addObject:[MYHotPlayerInfoDataListModel mj_objectWithKeyValues:item]];
    }
    return models.copy;
}

/**
 保存数据
 */
- (BOOL)saveData:(MYHotPlayerInfoDataListModel *)model {
    [self.array removeObject:[model mj_JSONObject]];
    [self.array insertObject:[model mj_JSONObject] atIndex:0];
    [self.allModels removeObject:model];
    [self.allModels insertObject:model atIndex:0];
    return [NSKeyedArchiver archiveRootObject:self.array toFile:MYFreedDealDataPlist];
}

/**
 删除数据
 */
- (BOOL)deleteData:(MYHotPlayerInfoDataListModel *)model {
    if ([[MYStorageData shareMYStorageData] dataIsExistence:model]) {
        [self.allModels removeObject:model];
        [self.array removeObject:[model mj_JSONObject]];
    }
    return [NSKeyedArchiver archiveRootObject:self.array toFile:MYFreedDealDataPlist];
}

#pragma mark ==============//Setter / Getter\\==============
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSKeyedUnarchiver unarchiveObjectWithFile:MYFreedDealDataPlist];
        if (_array == nil) {
            _array = [NSMutableArray new];
        }
    }
    return _array;
}

- (NSMutableArray<MYHotPlayerInfoDataListModel *> *)allModels {
    if (!_allModels) {
        _allModels = [[MYStorageData shareMYStorageData] DictionaryConversionModel:self.array].mutableCopy;
        if (_allModels == nil) {
            _allModels = [NSMutableArray new];
        }
    }
    return _allModels;
}






@end
