//
//  MYHotPlayerAnchorInfoView.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/29.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerAnchorInfoView.h"
#import "MYStorageData.h"
#import "MBProgressHUD.h"

@interface MYHotPlayerAnchorInfoView ()

/**主播信息页面*/
@property (nonatomic, strong) UIView   *anchorTopView;
/**头像*/
@property (nonatomic, strong) UIButton *playerPicBtn;
/**昵称*/
@property (nonatomic, strong) UILabel  *playerNameLabel;
/**观看人数*/
@property (nonatomic, strong) UILabel  *watherNumLabel;
/**房间号*/
@property (nonatomic, strong) UILabel  *roomNumLabel;
/**关注按钮*/
@property (nonatomic, strong) UIButton *attractBtn;
/**礼物Btn*/
@property (nonatomic, strong) UIButton *buttonGift;
/**All主播*/
@property (nonatomic, strong) UIScrollView *scrollViewPreson;
/**定时器*/
@property (nonatomic, strong) NSTimer *timer;
@end



@implementation MYHotPlayerAnchorInfoView

- (instancetype)initWithFrame:(CGRect)frame withHotDataArr:(NSMutableArray<MYHotPlayerInfoDataListModel *> *)hotDataArr hotModel:(MYHotPlayerInfoDataListModel *)hotModel {
    if (self = [super initWithFrame:frame]) {
        [self buildHotPlayerAnchorInfoView];
        self.allHotPlayerInfoArr   = hotDataArr;
        self.currentPlayerInfoData = hotModel;
        
        self.backgroundColor = [UIColor lightGreen];
    }
    return self;
}

/**
 设置播放顶部视图界面
 */
- (void)buildHotPlayerAnchorInfoView {
    __weak typeof(self)weakSelf = self;
    // 顶部视图
    [self.anchorTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf).offset(10.f * AutoSizeScaleX);
        make.right.equalTo(weakSelf.mas_right).offset(-10.f * AutoSizeScaleX);
        make.height.equalTo(@(64 * AutoSizeScaleY));
    }];
    // 主播头像
    [self.anchorTopView addSubview:self.playerPicBtn];
    [self.playerPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.anchorTopView).offset(10.f * AutoSizeScaleX);
        make.width.height.equalTo(weakSelf.anchorTopView.mas_height).offset(-20.f * AutoSizeScaleX);
    }];
    // 昵称
    [self.anchorTopView addSubview:self.playerNameLabel];
    [self.playerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.playerPicBtn.mas_right).offset(4.f * AutoSizeScaleX);
        make.top.equalTo(weakSelf.playerPicBtn);
        make.width.equalTo(@(144.f * AutoSizeScaleX));
        make.height.equalTo(@(24.f * AutoSizeScaleY));
    }];
    // 观看人数
    [self.anchorTopView addSubview:self.watherNumLabel];
    [self.watherNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(weakSelf.playerNameLabel);
        make.width.equalTo(@(64.f));
        make.bottom.equalTo(weakSelf.playerPicBtn.mas_bottom).offset(4.f * AutoSizeScaleX);
    }];
    // 房间号
    [self.anchorTopView addSubview:self.roomNumLabel];
    [self.roomNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.watherNumLabel.mas_right).offset(4.f * AutoSizeScaleX);
        make.height.bottom.equalTo(weakSelf.watherNumLabel);
        make.width.equalTo(@(128.f * AutoSizeScaleX));
    }];
    // 关注按钮
    [self.anchorTopView addSubview:self.attractBtn];
    [self.attractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.center.equalTo
        make.centerY.equalTo(weakSelf.playerPicBtn.mas_centerY);
        make.right.equalTo(weakSelf.anchorTopView.mas_right).offset(-10.f * AutoSizeScaleX);
        make.width.equalTo(@(72.f * AutoSizeScaleX));
        make.height.equalTo(@(36.f * AutoSizeScaleX));
    }];
    // 礼物Btn
    [self addSubview:self.buttonGift];
    [self.buttonGift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.anchorTopView.mas_left);
        make.top.equalTo(weakSelf.anchorTopView.mas_bottom).offset(10.f * AutoSizeScaleY);
        make.width.equalTo(@(240.f * AutoSizeScaleX));
        make.height.equalTo(@(36.f * AutoSizeScaleY));
    }];
    // All主播
    [self addSubview:self.scrollViewPreson];
    [self.scrollViewPreson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.buttonGift.mas_bottom).offset(10.f * AutoSizeScaleY);
        make.left.equalTo(weakSelf.anchorTopView.mas_left).offset(2.f * AutoSizeScaleX);
        make.right.equalTo(weakSelf.anchorTopView.mas_right).offset(-2.f * AutoSizeScaleX);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    [self layoutIfNeeded];
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self maskViewToBounds:self.playerPicBtn];
    [self maskViewToBounds:self.attractBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self maskViewToBounds:self.anchorTopView];
    [self maskViewToBounds:self.buttonGift];
}

- (void)userBtnAction {
    if (self.clickPlayerPicClick) {
        self.clickPlayerPicClick(self.currentPlayerInfoData);
    }
    DTLog(@"跳转直播间");
}

- (void)attractBtnAction {
    
    if (!self.attractBtn.selected) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BOOL isSave = [[MYStorageData shareMYStorageData] saveData:self.currentPlayerInfoData];
            if (isSave) {
                [MBProgressHUD showSuccess:@"关注成功" toView:self.viewController.view];
                self.attractBtn.selected = !self.attractBtn.selected;
            } else {
                [MBProgressHUD showError:@"关注失败" toView:self.viewController.view];
            }
        });
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BOOL isSave = [[MYStorageData shareMYStorageData] deleteData:self.currentPlayerInfoData];
            if (isSave) {
                [MBProgressHUD showSuccess:@"取消关注成功" toView:self.viewController.view];
                self.attractBtn.selected = !self.attractBtn.selected;
            } else {
                [MBProgressHUD showError:@"取消关注失败" toView:self.viewController.view];
            }
        });
    }
    DTLog(@"关注按钮");
}

#pragma ====重写set方法====
@synthesize allHotPlayerInfoArr   = _allHotPlayerInfoArr;
- (void)setAllHotPlayerInfoArr:(NSMutableArray<MYHotPlayerInfoDataListModel *> *)allHotPlayerInfoArr {
    _allHotPlayerInfoArr = allHotPlayerInfoArr;
    CGFloat scrollWitdh  = CGRectGetWidth(self.scrollViewPreson.bounds);
    CGFloat scrollHeigth = CGRectGetHeight(self.scrollViewPreson.bounds);
    CGFloat margin = 10.f;
    // 设置内容视图
    self.scrollViewPreson.contentSize = CGSizeMake((scrollHeigth + margin) * allHotPlayerInfoArr.count - scrollWitdh, 0);
    if (self.scrollViewPreson.contentSize.width <= scrollWitdh) {
        self.scrollViewPreson.contentSize = CGSizeMake(scrollWitdh, 0);
    }
    CGFloat width = scrollHeigth - margin;
    CGFloat x = 0.0f;
    for (int i = 0; i<allHotPlayerInfoArr.count; i++) {
        x = (width + margin) * i + margin;
        UIButton *phtotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        phtotBtn.frame = CGRectMake(x, margin / 2.f, width, width);
        [self  maskViewToBounds:phtotBtn];
        phtotBtn.tag = 100 + i;
        [phtotBtn addTarget:self action:@selector(phtotBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewPreson addSubview:phtotBtn];
        
        // 设置动画效果 进行旋转
        CABasicAnimation *transformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        transformAnima.fromValue = @(0);
        transformAnima.toValue   = @(M_PI * 2);
        transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
        animaGroup.duration = 8.0f;
        animaGroup.repeatCount = HUGE_VALF;
        animaGroup.fillMode = kCAFillModeForwards;
        animaGroup.removedOnCompletion = NO;
        animaGroup.animations = @[transformAnima];
        [phtotBtn.layer addAnimation:animaGroup forKey:@"Animation"];
        
        MYHotPlayerInfoDataListModel *model = allHotPlayerInfoArr[i];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.smallpic] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            MYMINTHREAD(^{
                [phtotBtn setImage:[UIImage circleImage:image borderColor:RandColor borderWidth:3.f] forState:UIControlStateNormal];
            });
        }];
    }
    

    [self layoutIfNeeded];
}

- (void)phtotBtnClickAction:(UIButton *)btn {
    
}




@synthesize currentPlayerInfoData = _currentPlayerInfoData;
- (void)setCurrentPlayerInfoData:(MYHotPlayerInfoDataListModel *)currentPlayerInfoData {
    if (currentPlayerInfoData == nil) return;
    _currentPlayerInfoData = currentPlayerInfoData;
    
    // 主播头像
    [self.playerPicBtn sd_setImageWithURL:[NSURL URLWithString:currentPlayerInfoData.smallpic] forState:UIControlStateNormal placeholderImage:ImageNamed(@"placeholder_head")];
    // 昵称
    CGSize size = [MYGlobalManager stringSizeWithString:currentPlayerInfoData.myname withWidthLimit:240.f withFont:[UIFont my_FontWithName:@"CourierNewPS-BoldMT" size:14.f]];
    [self.playerNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(size.width + 4.f));
    }];
    self.playerNameLabel.text = currentPlayerInfoData.myname;
    // 观众
    NSString *allNum = [NSString stringWithFormat:@"%ld人",currentPlayerInfoData.allnum];
    CGSize allNumSize = [MYGlobalManager stringSizeWithString:allNum withWidthLimit:72.f withFont:[UIFont my_FontWithName:@"AmericanTypewriter-Bold" size:13.f]];
    [self.watherNumLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(allNumSize.width + 4.f));
    }];
    self.watherNumLabel.text  = allNum;
    // 房间号
    NSString *roomID  = [NSString stringWithFormat:@"房间号:%ld",currentPlayerInfoData.roomid];
    CGSize roomIDSize = [MYGlobalManager stringSizeWithString:roomID withWidthLimit:160.f withFont:[UIFont my_FontWithName:@"AmericanTypewriter-Bold" size:13.f]];
    [self.roomNumLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(roomIDSize.width + 4.f));
    }];
    self.roomNumLabel.text = roomID;
    // 增加猫粮 娃娃
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerActionUpdateNum) userInfo:nil repeats:YES];
    // 关注按钮
    
}
static int randomNum = 0;
- (void)upDateRandomNum {
    randomNum += arc4random_uniform(5);
    self.watherNumLabel.text = [NSString stringWithFormat:@"%ld",randomNum + self.currentPlayerInfoData.allnum];
    [self.buttonGift setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u",1993045 + randomNum, 124593 + randomNum] forState:UIControlStateNormal];
}
/**
 关闭定时器
 */
- (void)closeTimer {
    [self.timer fire];
    [self.timer invalidate];
    self.timer = nil;
}



- (void)timerActionUpdateNum {
    
    
    
}





#pragma mark ==============//懒加载\\==============
- (NSMutableArray<MYHotPlayerInfoDataListModel *> *)allHotPlayerInfoArr {
    if (!_allHotPlayerInfoArr) {
        _allHotPlayerInfoArr = [NSMutableArray new];
    }
    return _allHotPlayerInfoArr;
}

- (UIView *)anchorTopView {
    if (!_anchorTopView) {
        _anchorTopView = [UIView new];
        _anchorTopView.backgroundColor = SXRGBAColor(54.f, 54.f, 54.f, 0.3f);
        [self addSubview:_anchorTopView];
        //[self maskViewToBounds:_anchorTopView];
    }
    return _anchorTopView;
}

- (UIButton *)playerPicBtn {
    if (!_playerPicBtn) {
        _playerPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playerPicBtn.layer.borderWidth = 1.f;
        _playerPicBtn.layer.borderColor = [UIColor whiteSmoke].CGColor;
        [_playerPicBtn setImage:ImageNamed(@"placeholder_head") forState:UIControlStateNormal];
        [_playerPicBtn addTarget:self action:@selector(userBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playerPicBtn;
}

- (UILabel *)playerNameLabel {
    if (!_playerNameLabel) {
        _playerNameLabel = [UILabel new];
        _playerNameLabel.textColor = [UIColor peachRed];
        _playerNameLabel.font = [UIFont my_FontWithName:@"CourierNewPS-BoldMT" size:14.f];
    }
    return _playerNameLabel;
}

- (UILabel *)watherNumLabel {
    if (!_watherNumLabel) {
        _watherNumLabel = [UILabel new];
        _watherNumLabel.textColor = [UIColor indianRed];
        _watherNumLabel.font = [UIFont my_SystemFontOfSize:13.f];
    }
    return _watherNumLabel;
}

- (UILabel *)roomNumLabel {
    if (!_roomNumLabel) {
        _roomNumLabel = [UILabel new];
        _roomNumLabel.textColor = [UIColor indianRed];
        _roomNumLabel.font = [UIFont my_SystemFontOfSize:13.f];
    }
    return _roomNumLabel;
}

- (UIButton *)attractBtn {
    if (!_attractBtn) {
        _attractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attractBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_attractBtn setTitle:@"取消关注" forState:UIControlStateSelected];
//        [_attractBtn setBackgroundImage:[UIColor imageWithColor:SXRGBAColor(214.f, 41.f, 117.f, 1.0f)] forState:UIControlStateNormal];
//        [_attractBtn setBackgroundImage:[UIColor imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
        [_attractBtn addTarget:self action:@selector(attractBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attractBtn;
}

- (UIButton *)buttonGift {
    if (!_buttonGift) {
        _buttonGift = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonGift setTitle:@"猫粮:1993045  娃娃124593" forState:UIControlStateNormal];
        [_buttonGift setImage:ImageNamed(@"cat_food_18x12") forState:UIControlStateNormal];
        [_buttonGift setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_buttonGift setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_buttonGift setImageEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
        _buttonGift.titleLabel.font = [UIFont my_SystemFontOfSize:13.f];
        _buttonGift.backgroundColor = [UIColor goldColor];
    }
    return _buttonGift;
}

- (UIScrollView *)scrollViewPreson {
    if (!_scrollViewPreson) {
        _scrollViewPreson = [UIScrollView new];
        _scrollViewPreson.showsVerticalScrollIndicator   = NO;
        _scrollViewPreson.showsHorizontalScrollIndicator = NO;
    }
    return _scrollViewPreson;
}

- (void)maskViewToBounds:(UIView *)view {
    view.layer.cornerRadius  = CGRectGetHeight(view.bounds) * 0.5f;
    view.layer.masksToBounds = YES;
}

@end
