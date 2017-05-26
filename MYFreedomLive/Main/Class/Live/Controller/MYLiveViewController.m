//
//  MYLiveViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/22.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYLiveViewController.h"
#import "LFLiveKit.h"
#import "MBProgressHUD+MJ.h"

#define kBtnClose     1000
#define kBtnBeautiful 1001
#define kBtnLive      1002
#define kBtnCamera    1003


@interface MYLiveViewController ()<LFLiveSessionDelegate>
/**关闭按钮*/
@property (nonatomic, strong) UIButton *btnClose;
/**相机按钮*/
@property (nonatomic, strong) UIButton *btnCamera;
/**美颜按钮*/
@property (nonatomic, strong) UIButton *btnBeautiful;
/**直播按钮*/
@property (nonatomic, strong) UIButton *btnLive;
/**状态*/
@property (nonatomic, strong) UILabel *labelStatus;
/**RYMP网址*/
@property (nonatomic, copy  ) NSString *rtmpUrl;
/**直播相关*/
@property (nonatomic, strong) LFLiveSession *session;
/**直播界面*/
@property (nonatomic, strong) UIView *viewLivePre;

@end

@implementation MYLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置页面布局
    [self buildUpThisViewState];
    
}


/**
 设置页面状态
 */
- (void)buildUpThisViewState {
    MYWEAKSELF;
    CGFloat margin = 10.f * AutoSizeScaleX;
    CGFloat size   = 36.f * AutoSizeScaleX;
    
    // 直播界面
    [self.view insertSubview:self.viewLivePre atIndex:0];
    
    // 关闭按钮
    self.btnClose = [self createButtonWithImage:@"talk_close_40x40" Tag:kBtnClose];
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-margin);
        make.top.mas_equalTo(margin * 2.5);
        make.width.height.mas_equalTo(size);
    }];
    // 相机
    self.btnCamera = [self createButtonWithImage:@"camera_change_40x40" Tag:kBtnCamera];
    [self.btnCamera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(weakSelf.btnClose);
        make.centerY.mas_equalTo(weakSelf.btnClose.mas_centerY);
        make.right.mas_equalTo(weakSelf.btnClose.mas_left).offset(-margin);
    }];
    // 美颜
    self.btnBeautiful = [self createButtonWithImage:@"icon_beautifulface_19x19" Tag:kBtnBeautiful];
    [self.btnBeautiful setTitle:@"智能美颜已开启" forState:UIControlStateNormal];
    [self.btnBeautiful setTitle:@"智能美颜已关闭" forState:UIControlStateSelected];
    [self.btnBeautiful setImage:ImageNamed(@"icon_beautifulface_19x19") forState:UIControlStateSelected];
    [self.btnBeautiful setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 5.f, 0.f, 0.f)];
    [self.btnBeautiful setImageEdgeInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, 5.f)];
    self.btnBeautiful.titleLabel.font = [UIFont my_BoldSystemFontOfSize:16.f];
    self.btnBeautiful.backgroundColor = SXRGBAColor(216.f, 216.f, 216.f, 216.f);
    self.btnBeautiful.layer.masksToBounds = YES;
    self.btnBeautiful.layer.cornerRadius  = 30.f * AutoSizeScaleX / 2;
    [self.btnBeautiful mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.btnClose);
        make.height.mas_equalTo(30.f * AutoSizeScaleX);
        make.width.mas_equalTo(160.f * AutoSizeScaleX);
        make.left.mas_equalTo(margin);
    }];
    // 状态
    self.labelStatus = [UILabel new];
    self.labelStatus.font = [UIFont my_FontWithName:@"Courier-Bold" size:14.f];
    self.labelStatus.text = @"未知状态";
    self.labelStatus.textColor = [UIColor lightGrayColor];
    self.labelStatus.textAlignment = NSTextAlignmentCenter;
    self.labelStatus.numberOfLines = 0;
    [self.view addSubview:self.labelStatus];
    [self.labelStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.btnBeautiful.mas_bottom).offset(margin * 2);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.height.mas_equalTo(24.f * AutoSizeScaleX);
        make.width.mas_equalTo(weakSelf.view.mas_width);
    }];
    // 直播
    self.btnLive = [self createButtonWithImage:@"" Tag:kBtnLive];
    [self.btnLive setTitle:@"开始直播" forState:UIControlStateNormal];
    [self.btnLive setTitle:@"结束直播" forState:UIControlStateSelected];
    self.btnLive.titleLabel.font = [UIFont my_FontWithName:@"Courier-Bold" size:18.f];
    self.btnLive.backgroundColor = SXRGBAColor(199.f, 61.f, 116.f, 1.0f);
    self.btnLive.layer.masksToBounds = YES;
    self.btnLive.layer.cornerRadius = size / 2;
    [self.btnLive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-size);
        make.height.mas_equalTo(size);
        make.width.mas_equalTo(weakSelf.view.mas_width).offset(-36);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
    }];
    
    // 默认开启前置摄像头
    self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    
}


- (void)btnClickAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case kBtnClose: // 关闭
            [self dismissViewControllerAnimated:MASAttributeCenterYWithinMargins completion:nil];
            break;
        case kBtnBeautiful: // 美颜
            if (![self judgeCameraIsValue]) return;
            sender.selected = !sender.selected;
            // 默认是开启了美颜相机的功能
            self.session.beautyFace = !self.session.beautyFace;
            break;
        case kBtnLive: // 直播
            if (![self judgeCameraIsValue]) return;
            self.btnLive.selected = !self.btnLive.selected;
            if (self.btnLive.selected) {
                // 开始直播
                LFLiveStreamInfo *info = [LFLiveStreamInfo new];
                // 设置IP地址
                info.url = @"rtmp://192.168.3.93:1935/rtmplive/room";
                self.rtmpUrl = info.url;
                [self.session startLive:info];
            } else {
                // 结束直播
                [self.session stopLive];
                self.labelStatus.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: %@", self.rtmpUrl];
            }
        case kBtnCamera: // 相机
            if (![self judgeCameraIsValue]) return;
            sender.selected = !sender.selected;
            if (sender.selected) {
                self.session.captureDevicePosition = AVCaptureDevicePositionBack;
            } else {
                self.session.captureDevicePosition = AVCaptureDevicePositionFront;
            }
            break;
        default:
            break;
    }
}

#pragma mark ==============//LFLiveSessionDelegate\\==============
- (void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state {
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接错误";
            break;
        default:
            break;
    }
    self.labelStatus.text = [NSString stringWithFormat:@"状态:%@\nRTMP: %@", tempStatus, self.rtmpUrl];
}




#pragma mark ==============//判断是否可以使用\\==============
- (BOOL)judgeCameraIsValue {
    // 真机或者模拟器
    if ([[MYUIDeveice deveiceVersion] isEqualToString:@"iPhoneSimulator"]) {
        
        [MBProgressHUD showAlertMessage:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
        return NO;
    }
    // 判断是否有摄像头权限
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authorizationStatus == AVAuthorizationStatusRestricted || authorizationStatus == AVAuthorizationStatusDenied) {
        
        [MBProgressHUD showAlertMessage:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
        return NO;
    }
    // 开启麦克风权限
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                return YES;
            } else {
                [MBProgressHUD showAlertMessage:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                return NO;
            }
        }];
    }
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIButton *)createButtonWithImage:(NSString *)image Tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    if (![MYGlobalManager isNilValue:image]) {
        [btn setImage:ImageNamed(image) forState:UIControlStateNormal];
    }
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}

- (LFLiveSession *)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2] liveType:LFLiveRTMP];
        
        /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(720, 1280);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration liveType:LFLiveRTMP];
         */
        _session.delegate = self;
        _session.running  = true;
        _session.preView  = self.viewLivePre;
    }
    return _session;
}


- (UIView *)viewLivePre {
    if (!_viewLivePre) {
        _viewLivePre = [[UIView alloc] initWithFrame:self.view.bounds];
        _viewLivePre.backgroundColor = [UIColor clearColor];
    }
    return _viewLivePre;
}




@end
