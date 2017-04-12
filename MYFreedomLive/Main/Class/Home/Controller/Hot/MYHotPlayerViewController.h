//
//  MYHotPlayerViewController.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYBasicViewController.h"
#import "MYHotPlayerInfoModel.h"

@interface MYHotPlayerViewController : MYBasicViewController


/**
 重写init方法

 @param hotDataArr 全部主播数据源
 @param hotModel 当前观看主播数据源
 @return self
 */
- (instancetype)initWithHotDataArr:(NSMutableArray <MYHotPlayerInfoDataListModel *> *)hotDataArr hotModel:(MYHotPlayerInfoDataListModel *)hotModel;


@end
