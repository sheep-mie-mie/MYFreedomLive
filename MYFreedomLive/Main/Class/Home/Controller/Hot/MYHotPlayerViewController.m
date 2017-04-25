//
//  MYHotPlayerViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerViewController.h"
#import "MYHotPlayerAnchorInfoView.h"
#import "MYHotPlayerUserInfoView.h"

@interface MYHotPlayerViewController ()
/**全部主播数据源*/
@property (nonatomic, strong) NSMutableArray <MYHotPlayerInfoDataListModel *> *allHotPlayerInfoArr;
/**当前播放*/
@property (nonatomic, strong) MYHotPlayerInfoDataListModel *currentPlayerInfoData;
/**顶视图*/
@property (nonatomic, strong) MYHotPlayerAnchorInfoView *playerAncher;
/**用户信息*/
@property (nonatomic, strong) MYHotPlayerUserInfoView *playerUserInfo;
/**同一类型的主播*/
@property (nonatomic, strong) <#name#> *<#name#>;
@property (nonatomic, strong) UIImageView *imvStartPlaceHolder;
/**直播播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *ijkMoviePlayer;

@end

@implementation MYHotPlayerViewController

- (instancetype)initWithHotDataArr:(NSMutableArray<MYHotPlayerInfoDataListModel *> *)hotDataArr hotModel:(MYHotPlayerInfoDataListModel *)hotModel {
    if (self = [super init]) {
        self.allHotPlayerInfoArr   = hotDataArr;
        self.currentPlayerInfoData = hotModel;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.ijkMoviePlayer) {
        [self.ijkMoviePlayer pause];
        [self.ijkMoviePlayer stop];
        [self.ijkMoviePlayer shutdown];
        [self.ijkMoviePlayer.view removeFromSuperview];
        self.ijkMoviePlayer = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    if (currentPlayerInfoData == nil) return;
    _currentPlayerInfoData = currentPlayerInfoData;
    
}

#pragma mark ==============//private method\\==============
- (void)playFlv:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl {
    DTLog(@"%@",flv);
    __weak typeof(self)WeakSelf = self;
    if (self.ijkMoviePlayer) {
        [self.view insertSubview:self.imvStartPlaceHolder aboveSubview:self.ijkMoviePlayer.view];
        if (self.) {
            <#statements#>
        }
        
    }
    
    
    
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

- (MYHotPlayerAnchorInfoView *)playerAncher { // 顶部视图
    if (!_playerAncher) {
        MYWEAKSELF;
        _playerAncher = [[MYHotPlayerAnchorInfoView alloc] initWithFrame:CGRectMake(0, 20, MAINSCREEN_WIDTH, 180.f * AutoSizeScaleY) withHotDataArr:self.allHotPlayerInfoArr hotModel:self.currentPlayerInfoData];
        _playerAncher.clickPlayerPicClick = ^(MYHotPlayerInfoDataListModel *model) {
            [weakSelf.playerUserInfo showCurrentUserModel:weakSelf.currentPlayerInfoData toView:weakSelf.view];
            weakSelf.playerUserInfo.clickUserInfoSelectBlock = ^() {
                weakSelf.currentPlayerInfoData = model;
            };
        };
    }
    return _playerAncher;
}

- (MYHotPlayerUserInfoView *)playerUserInfo { // 用户信息
    if (!_playerUserInfo) {
        _playerUserInfo = [[MYHotPlayerUserInfoView alloc] initWithFrame:self.view.bounds];
    }
    return _playerUserInfo;
}

- (UIImageView *)imvStartPlaceHolder {
    if (!_imvStartPlaceHolder) {
        _imvStartPlaceHolder = [UIImageView new];
        _imvStartPlaceHolder.frame = self.view.bounds;
        _imvStartPlaceHolder.image = ImageNamed(@"profile_user_414x414");
        [self.view addSubview:_imvStartPlaceHolder];
        [self showGifLoading:nil inView:_imvStartPlaceHolder];
        [_imvStartPlaceHolder layoutIfNeeded];
    }
    return _imvStartPlaceHolder;
}






@end
