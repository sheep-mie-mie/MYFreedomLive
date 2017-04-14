//
//  MYHotPlayerUserInfoView.h
//  MYFreedomLive
//
//  Created by ifly on 2017/4/13.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYHotPlayerInfoModel.h"

@interface MYHotPlayerUserInfoView : UIView

/**
 展示当前点击的主播信息

 @param currentModel 当前主播数据源
 @param view         显示信息界面
 */
- (void)showCurrentUserModel:(MYHotPlayerInfoDataListModel *)currentModel
                      toView:(UIView *)view;

/**
 所有主播的数据源
 */
@property (nonatomic, strong) NSArray <MYHotPlayerInfoDataListModel *>* allModels;

/**
 选中block
 */
@property (nonatomic, copy  ) void(^clickUserInfoSelectBlock)();

/**
 删除block
 */
@property (nonatomic, copy  ) void(^clickUserInfoDelectBlock)();




@end
