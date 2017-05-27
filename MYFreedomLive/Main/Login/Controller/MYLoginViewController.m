//
//  MYLoginViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/5/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYLoginViewController.h"
#import "MYBasicTabBarController.h"
#import "AppDelegate.h"

@interface MYLoginViewController ()
/**播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *ijkPlayer;
/**登录按钮*/
@property (nonatomic, strong) UIButton *btnLogin;
/**蒙版视图*/
@property (nonatomic, strong) UIImageView *coverView;

@end

@implementation MYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUpThisViewState];
}

/**
 设置页面状态
 */
- (void)buildUpThisViewState {
    MYWEAKSELF;
    
    // 背景播放
    [self.view addSubview:self.ijkPlayer.view];
    [self.ijkPlayer.view addSubview:self.coverView];
    // 登录
    [self.view addSubview:self.btnLogin];
    self.btnLogin.layer.cornerRadius = 40.f * AutoSizeScaleX / 2;
    [self.btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.view.mas_width).offset(-80.f * AutoSizeScaleX);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.height.mas_equalTo(40.f * AutoSizeScaleX);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-60.f * AutoSizeScaleX);
    }];
    
    
    [self notificationOfPlayer];
}

- (void)notificationOfPlayer {
    // 监听是否播放完
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

- (void)stateDidChange {
    if ((self.ijkPlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.ijkPlayer.isPlaying) {
            [self.view insertSubview:self.coverView atIndex:0];
            [self.ijkPlayer play];
        }
    }
}

- (void)didFinish {
    // 播放完之后 继续重播
    [self.ijkPlayer play];
}


- (void)btnLoginClickAction {
    
    MYBasicTabBarController *basicTableBar = [MYBasicTabBarController shareMainTabBar];
    [AppDelegate shareAppDelegate].window.rootViewController = basicTableBar;
}


#pragma mark ==============//懒加载\\==============
- (UIButton *)btnLogin {
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.backgroundColor = [UIColor clearColor];
        _btnLogin.layer.masksToBounds = YES;
        _btnLogin.titleLabel.font = [UIFont my_SystemFontOfSize:18.f];
        [_btnLogin setTitle:@"快速登录" forState:UIControlStateNormal];
        _btnLogin.layer.borderWidth = 1.f;
        _btnLogin.layer.borderColor = SXRGBAColor(214.f, 41.f, 117.f, 1).CGColor;
        [_btnLogin setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_btnLogin addTarget:self action:@selector(btnLoginClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
}

- (IJKFFMoviePlayerController *)ijkPlayer {
    if (!_ijkPlayer) {
        NSString *path = arc4random_uniform(2) ? @"login_video" : @"loginmovie";
        _ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"] withOptions:[IJKFFOptions optionsByDefault]];
        _ijkPlayer.view.frame = self.view.frame;
        _ijkPlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
        _ijkPlayer.shouldAutoplay = NO;
        [_ijkPlayer prepareToPlay];
    }
    return _ijkPlayer;
}

- (UIImageView *)coverView {
    if (!_coverView) {
        _coverView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _coverView.image = ImageNamed(@"LaunchImage");
    }
    return _coverView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
