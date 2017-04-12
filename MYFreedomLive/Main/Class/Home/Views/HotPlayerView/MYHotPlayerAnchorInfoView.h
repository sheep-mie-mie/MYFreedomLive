//
//  MYHotPlayerAnchorInfoView.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/29.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYHotPlayerInfoModel.h"

@interface MYHotPlayerAnchorInfoView : UIView


/**
 重写init方法

 @param frame 大小
 @param hotDataArr 全部主播
 @param hotModel 当前主播
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withHotDataArr:(NSMutableArray <MYHotPlayerInfoDataListModel *> *)hotDataArr hotModel:(MYHotPlayerInfoDataListModel *)hotModel;


/**
 全部主播数据源
 */
@property (nonatomic, strong) NSMutableArray <MYHotPlayerInfoDataListModel *> *allHotPlayerInfoArr;
/**
 当前播放
 */
@property (nonatomic, strong) MYHotPlayerInfoDataListModel *currentPlayerInfoData;



@end
