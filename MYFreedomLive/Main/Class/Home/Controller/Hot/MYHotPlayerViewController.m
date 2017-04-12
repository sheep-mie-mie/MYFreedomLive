//
//  MYHotPlayerViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerViewController.h"

@interface MYHotPlayerViewController ()
/** 
 全部主播数据源
 */
@property (nonatomic, strong) NSMutableArray <MYHotPlayerInfoDataListModel *> *allHotPlayerInfoArr;
/**
 当前播放
 */
@property (nonatomic, strong) MYHotPlayerInfoDataListModel *currentPlayerInfoData;

@end

@implementation MYHotPlayerViewController

- (instancetype)initWithHotDataArr:(NSMutableArray<MYHotPlayerInfoDataListModel *> *)hotDataArr hotModel:(MYHotPlayerInfoDataListModel *)hotModel {
    if (self = [super init]) {
        self.allHotPlayerInfoArr   = hotDataArr;
        self.currentPlayerInfoData = hotModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildHotPlayerViewState];
}


/**
 设置播放页面状态
 */
- (void)buildHotPlayerViewState {
    
    
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ==============//懒加载\\==============
- (NSMutableArray<MYHotPlayerInfoDataListModel *> *)allHotPlayerInfoArr {
    if (!_allHotPlayerInfoArr) {
        _allHotPlayerInfoArr = [NSMutableArray new];
    }
    return _allHotPlayerInfoArr;
}




@end
