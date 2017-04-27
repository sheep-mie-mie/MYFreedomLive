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
#import "MYHotPlayerCatEarView.h"

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
@property (nonatomic, strong) MYHotPlayerCatEarView *viewCatEar;
/**直播开始前的占位图片*/
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
    [self playFlv:currentPlayerInfoData.flv placeHolderUrl:currentPlayerInfoData.bigpic];
    DTLog(@"%@",currentPlayerInfoData.myname);
    [self setAllHotPlayerInfoArr:self.allHotPlayerInfoArr];
}

#pragma mark ==============//private method\\==============
- (void)playFlv:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl {
    DTLog(@"%@",flv);
    __weak typeof(self)WeakSelf = self;
    if (self.ijkMoviePlayer) {
        [self.view insertSubview:self.imvStartPlaceHolder aboveSubview:self.ijkMoviePlayer.view];
        if (self.viewCatEar) {
            [self.viewCatEar removeFromSuperview];
            self.viewCatEar = nil;
        }
        [self.ijkMoviePlayer shutdown];
        [self.ijkMoviePlayer.view removeFromSuperview];
        self.ijkMoviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    // 如果切换主播 取消之前的动画
#warning ====Don`t finish this function
//    if (self.) {
//        <#statements#>
//    }
    // 加载视图
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:placeHolderUrl] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [WeakSelf showGifLoading:nil inView:WeakSelf.imvStartPlaceHolder];
                WeakSelf.imvStartPlaceHolder.image = [UIImage blurryImage:image withBlurLevel:0.8f];
            });
        }
    }];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率(fps)可以改 确认非标准帧率会导致音画不同步 所以只能设定为15或者29.97
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // vol 设置音量大小 256为标准音量 要设置成两倍音量时则输入512 以此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
    moviePlayer.view.frame = self.view.bounds;
    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放 必须设置为no 防止自动播放 才能更好的控制直播状态
    moviePlayer.shouldAutoplay = NO;
    [self.view insertSubview:moviePlayer.view atIndex:0];
    // 准备播放
    [moviePlayer prepareToPlay];
    self.ijkMoviePlayer = moviePlayer;
    // 设置监听
    [self loadCreateObserver];
#warning Don`t finish this function 
    //显示 工会其他直播和类似主播
    //[moviePlayer.view bringSubviewToFront:self];
    
    
    
}

/**
 设置监听
 */
- (void)loadCreateObserver {
    [self.ijkMoviePlayer play];
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.ijkMoviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.ijkMoviePlayer];
}

#pragma mark ==============//notify method\\==============
/**播放状态改变*/
- (void)stateDidChange {
    MYWEAKSELF;
    if ((self.ijkMoviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.ijkMoviePlayer.isPlaying) {
            [self hideGifLoading];
            [self.ijkMoviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.imvStartPlaceHolder) {
                    [self.imvStartPlaceHolder removeFromSuperview];
                    self.imvStartPlaceHolder = nil;
#warning Don`t Finish
                    //[weakSelf.ijkMoviePlayer.view addSubview:weakSe];
                    // 显示猫耳朵
                    weakSelf.viewCatEar.hidden = NO;
                }
            });
        }
    } else if (self.ijkMoviePlayer.loadState & IJKMPMovieLoadStateStalled) {
        // 网络不佳 自动暂停状态
        [self showGifLoading:nil inView:self.ijkMoviePlayer.view];
    }
    // 如果网络不好 断开后恢复 也要去掉加载
    if (self.gifView.isAnimating) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf hideGifLoading];
        });
    }
}

/**播放完成*/
- (void)didFinish {
    MYWEAKSELF;
    DTLog(@"加载状态...%ld...%ld",self.ijkMoviePlayer.loadState, self.ijkMoviePlayer.playbackState);
    // 因为网速 或者其他原因导致直播停止 也要显示GIF
    if (self.ijkMoviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.gifView) {
        [self showGifLoading:nil inView:self.ijkMoviePlayer.view];
        return;
    }
    // 方法 1.重新获取直播地址 服务器控制是否有地址返回 2.用户Http请求改地址 若请求成功表示直播未结束 否则结束
    
    [MYNetwork getLiveUrl:self.currentPlayerInfoData.flv Success:^(id returnData) {
        DTLog(@"下一个直播:%@",JSON_STRING_WITH_OBJ(returnData));
    } Failure:^(NSError *err) {
        [weakSelf.ijkMoviePlayer shutdown];
        [weakSelf.ijkMoviePlayer.view removeFromSuperview];
        weakSelf.ijkMoviePlayer = nil;
#warning Don`t Finish
//        weakSelf.
    } ShowView:nil];
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
