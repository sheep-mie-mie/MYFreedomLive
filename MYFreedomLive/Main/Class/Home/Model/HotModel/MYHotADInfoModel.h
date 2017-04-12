//
//  MYHotADInfoModel.h
//  MYFreedomLive
//
//  Created by ifly on 2017/3/22.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MYHotADInfoModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy  ) NSString *msg;
@property (nonatomic, strong) NSArray *data;
@end


@interface MYHotADInfoDetailModel : NSObject
@property (nonatomic, assign) NSInteger lrCurrent;
@property (nonatomic, assign) NSInteger serverid;
@property (nonatomic, assign) NSInteger useridx;
@property (nonatomic, assign) NSInteger hiddenVer;
@property (nonatomic, assign) NSInteger cutTime;
@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger orderid;
@property (nonatomic, copy  ) NSString *myname;
@property (nonatomic, copy  ) NSString *signatures;
@property (nonatomic, copy  ) NSString *smallpic;
@property (nonatomic, copy  ) NSString *bigpic;
@property (nonatomic, copy  ) NSString *gps;
@property (nonatomic, copy  ) NSString *flv;
@property (nonatomic, copy  ) NSString *adsmallpic;
@property (nonatomic, copy  ) NSString *contents;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *imageUrl;
@property (nonatomic, copy  ) NSString *link;
@property (nonatomic, copy  ) NSString *addTime;
@end




