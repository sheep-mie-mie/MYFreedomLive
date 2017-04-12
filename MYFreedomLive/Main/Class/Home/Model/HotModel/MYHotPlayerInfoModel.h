//
//  MYHotPlayerInfoModel.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/23.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MYHotPlayerInfoDataModel;


@interface MYHotPlayerInfoModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy  ) NSString *msg;
@property (nonatomic, strong) MYHotPlayerInfoDataModel *data;
@end


@interface MYHotPlayerInfoDataModel : NSObject
@property (nonatomic, assign) NSInteger counts;
@property (nonatomic, strong) NSArray *list;
@end


@interface MYHotPlayerInfoDataListModel : NSObject
@property (nonatomic, assign) NSInteger pos;
@property (nonatomic, assign) NSInteger allnum;
@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger serverid;
@property (nonatomic, assign) NSInteger starlevel;
@property (nonatomic, assign) NSInteger isSign;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, assign) NSInteger useridx;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, assign) NSInteger curexp;
@property (nonatomic, copy  ) NSString *gps;
@property (nonatomic, copy  ) NSString *flv;
@property (nonatomic, copy  ) NSString *familyName;
@property (nonatomic, copy  ) NSString *nation;
@property (nonatomic, copy  ) NSString *nationFlag;
@property (nonatomic, copy  ) NSString *userId;
@property (nonatomic, copy  ) NSString *myname;
@property (nonatomic, copy  ) NSString *signatures;
@property (nonatomic, copy  ) NSString *smallpic;
@property (nonatomic, copy  ) NSString *bigpic;
@end








