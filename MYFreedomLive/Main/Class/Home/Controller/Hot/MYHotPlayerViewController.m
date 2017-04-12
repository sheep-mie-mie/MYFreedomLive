//
//  MYHotPlayerViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerViewController.h"
#import "MYHotPlayerAnchorInfoView.h"

@interface MYHotPlayerViewController ()
/** 
 全部主播数据源
 */
@property (nonatomic, strong) NSMutableArray <MYHotPlayerInfoDataListModel *> *allHotPlayerInfoArr;
/**
 当前播放
 */
@property (nonatomic, strong) MYHotPlayerInfoDataListModel *currentPlayerInfoData;

/**
 顶视图
 */
@property (nonatomic, strong) MYHotPlayerAnchorInfoView *playerAncher;

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
    
    [self.view addSubview:self.playerAncher];
    
}





#pragma mark ==============//重写Setter方法\\==============
@synthesize allHotPlayerInfoArr = _allHotPlayerInfoArr;
- (void)setAllHotPlayerInfoArr:(NSMutableArray<MYHotPlayerInfoDataListModel *> *)allHotPlayerInfoArr {
    if (allHotPlayerInfoArr == nil) {
        return;
    }
    _allHotPlayerInfoArr = allHotPlayerInfoArr;
    
}

@synthesize currentPlayerInfoData = _currentPlayerInfoData;
- (void)setCurrentPlayerInfoData:(MYHotPlayerInfoDataListModel *)currentPlayerInfoData {
    if (currentPlayerInfoData == nil) {
        return;
    }
    _currentPlayerInfoData = currentPlayerInfoData;
    
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

- (MYHotPlayerAnchorInfoView *)playerAncher {
    if (!_playerAncher) {
        _playerAncher = [[MYHotPlayerAnchorInfoView alloc] initWithFrame:CGRectMake(0, 20, MAINSCREEN_WIDTH, 180.f * AutoSizeScaleY) withHotDataArr:self.allHotPlayerInfoArr hotModel:self.currentPlayerInfoData];
        
        
    }
    return _playerAncher;
}


@end
