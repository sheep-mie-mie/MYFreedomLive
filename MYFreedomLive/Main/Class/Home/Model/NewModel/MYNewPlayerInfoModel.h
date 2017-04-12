//
//  MYNewPlayerInfoModel.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/28.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MYNewPlayerInfoDataModel;

@interface MYNewPlayerInfoModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy  ) NSString *msg;
@property (nonatomic, strong) MYNewPlayerInfoDataModel *data;
@end

@interface MYNewPlayerInfoDataModel : NSObject
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, strong) NSArray *list;
@end

@interface MYNewPlayerInfoDataListModel : NSObject
@property (nonatomic, copy  ) NSString *nickname;
@property (nonatomic, copy  ) NSString *photo;
@property (nonatomic, copy  ) NSString *flv;
@property (nonatomic, copy  ) NSString *position;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger starlevel;
@property (nonatomic, assign) NSInteger allnum;
@property (nonatomic, assign) NSInteger listNew;
@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger useridx;
@property (nonatomic, assign) NSInteger serverid;
@property (nonatomic, assign) NSInteger lianMaiStatus;
@property (nonatomic, assign) NSInteger phonetype;
@property (nonatomic, assign) NSInteger isOnline;
@end









