//
//  MYHotPlayerUserInfoView.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/13.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerUserInfoView.h"

#define PlayerUserInfoBtnTag 100

@interface MYHotPlayerUserInfoView ()
/**当前数据源*/
@property (nonatomic, strong) MYHotPlayerInfoDataListModel *currentModel;
/**父视图*/
@property (nonatomic, strong) UIView *viewSpuer;
/**当前视图*/
@property (nonatomic, strong) UIView *selfView;
/**用户信息背景视图*/
@property (nonatomic, strong) UIView *userBackView;
/**用户头像*/
@property (nonatomic, strong) UIImageView *userImv;
/**用户昵称*/
@property (nonatomic, strong) UILabel *userNameLabel;
/**关注人数*/
@property (nonatomic, strong) UILabel *careNumLabel;
/**粉丝人数*/
@property (nonatomic, strong) UILabel *fansNumLabel;

@end


@implementation MYHotPlayerUserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self buildUpUserInfoView];
    }
    return self;
}

/**
 设置界面状态
 */
- (void)buildUpUserInfoView {
    self.backgroundColor = [UIColor redColor];
    //self.backgroundColor = SXRGBAColor(100.f, 100.f, 100.f, 0);
    // 添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    [self addGestureRecognizer:tapGesture];
    
    MYWEAKSELF;
    CGFloat xMargin = 2 * AutoSizeScaleX;
    CGFloat width   = CGRectGetWidth(self.bounds) - xMargin * 2;
    CGFloat doubleNum = 1.0f;
    if (MAINSCREEN_WIDTH <= 320) {
        doubleNum = 1.28f;
    } else if (MAINSCREEN_WIDTH <= 375) {
        doubleNum = 1.08f;
    }
    CGFloat height = width * doubleNum * AutoSizeScaleX;
    
    // 设置背景
    [self.userBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
        make.left.equalTo(weakSelf.mas_left).offset(xMargin);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    // 举报按钮
    UIButton *btnReport = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReport.tag = PlayerUserInfoBtnTag;
    [btnReport setTitle:@"举报" forState:UIControlStateNormal];
    [btnReport setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btnReport.titleLabel.font = [UIFont my_FontWithName:@"AmericanTypewriter" size:18.f];
    [btnReport addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.userBackView addSubview:btnReport];
    [btnReport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(10 * AutoSizeScaleX));
        make.width.equalTo(@(56.f * AutoSizeScaleX));
        make.height.equalTo(@(36.f * AutoSizeScaleX));
    }];
    // 关闭按钮
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClose.tag = PlayerUserInfoBtnTag + 1;
    [btnClose setBackgroundImage:ImageNamed(@"user_close_15x15") forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.userBackView addSubview:btnClose];
    [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnReport.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-16 * AutoSizeScaleX);
        make.width.height.equalTo(@(16.f * AutoSizeScaleX));
    }];
    // 头像
    [self.userBackView addSubview:self.userImv];
    [self.userImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnReport.mas_centerY);
        make.centerX.equalTo(weakSelf.userBackView.mas_centerX);
        make.width.height.equalTo(@(96 * AutoSizeScaleX));
    }];
    // 昵称
    [self.userBackView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.userImv.mas_centerX);
        make.width.lessThanOrEqualTo(weakSelf.userBackView.mas_width);
        make.top.equalTo(weakSelf.userImv.mas_bottom).offset(10.f * AutoSizeScaleX);
        make.height.equalTo(@(28.f * AutoSizeScaleX));
    }];
    // 设置欢迎光临
    UILabel *welcomeLabel = [UILabel new];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.text = @"欢迎光临";
    welcomeLabel.font = [UIFont my_SystemFontOfSize:14.f];
    welcomeLabel.textColor = [UIColor lightGrayColor];
    [self.userBackView addSubview:welcomeLabel];
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(weakSelf.userNameLabel);
        make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(10 * AutoSizeScaleX);
        make.height.equalTo(@(18.f * AutoSizeScaleX));
    }];
    // 看直播
    UIButton *watchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [watchBtn setTitle:@"看直播" forState:UIControlStateNormal];
    [watchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    watchBtn.titleLabel.font = [UIFont my_SystemFontOfSize:16.f];
    [watchBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    watchBtn.backgroundColor = SXRGBAColor(199.f, 61.f, 116.f, 1.0f);
    watchBtn.tag = PlayerUserInfoBtnTag + 2;
    [watchBtn maskViewToBoundsWithCornerRadius:4.f * AutoSizeScaleX];
    [self.userBackView addSubview:watchBtn];
    [watchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        
    }];
    
    
    
    
    
    [self layoutIfNeeded];
}

/**
 点击事件
 */
- (void)buttonClickAction:(UIButton *)btn {
    
    switch (btn.tag) {
        case 100: {
            
        }
            break;
        case 101: {
            
        }
            break;
        case 102: {
            
        }
            break;
        case 103: {
            
        }
            break;
        case 104: {
            
        }
        default:
            break;
    }
}




- (void)tapGestureAction {
    self.viewSpuer.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.6 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.selfView = nil;
    }];
}

/**
 绘制布局 重绘任务
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

/**
 标记为需要重新布局 异步调用layoutIfNeeded刷新布局 不立刻刷新 但layoutSubviews一定会被调用
 */
- (void)setNeedsLayout {
    [super setNeedsLayout];
}

/**
 当我们在某个类的内部调整子视图的位置时 需要调用
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.userBackView.layer.cornerRadius  = 10.f * AutoSizeScaleX;
    self.userBackView.layer.masksToBounds = YES;
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self.userImv maskViewToBoundsWithCornerRadius:CGRectGetWidth(self.userImv.bounds)];
}

- (void)showCurrentUserModel:(MYHotPlayerInfoDataListModel *)currentModel toView:(UIView *)view {
    self.currentModel = currentModel;
    self.viewSpuer    = view;
    if (self.selfView) return;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    view.userInteractionEnabled = YES;
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.6 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    self.selfView = self;
}

#pragma mark ==============//重写setter方法\\==============
- (void)setCurrentModel:(MYHotPlayerInfoDataListModel *)currentModel {
    _currentModel = currentModel;
    // 头像
    [self.userImv sd_setImageWithURL:[NSURL URLWithString:currentModel.smallpic] placeholderImage:ImageNamed(@"placeholder_head")];
    // 昵称
    self.userNameLabel.text = currentModel.myname;
    
}











#pragma mark ==============//懒加载\\==============
- (UIView *)userBackView { // 背景视图
    if (!_userBackView) {
        _userBackView = [UIView new];
        _userBackView.backgroundColor = SXRGBAColor(236.f, 236.f, 236.f, 1.0f);
        [self addSubview:_userBackView];
    }
    return _userBackView;
}
- (UIImageView *)userImv { // 头像
    if (!_userImv) {
        _userImv = [UIImageView new];
        _userImv.userInteractionEnabled = YES;
        _userImv.contentMode = UIViewContentModeScaleToFill;
    }
    return _userImv;
}
- (UILabel *)userNameLabel { // 用户名
    if (!_userNameLabel) {
        _userNameLabel = [UILabel new];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.font = [UIFont my_FontWithName:@"Verdana-Bold" size:18.f];
        _userNameLabel.textColor = RandColorNum(160);
        [self.userBackView addSubview:_userNameLabel];
    }
    return _userNameLabel;
}
- (UILabel *)fansNumLabel { // 粉丝数
    if (!_fansNumLabel) {
        _fansNumLabel = [self createFatherLabel];
    }
    return _fansNumLabel;
}
- (UILabel *)careNumLabel {
    if (!_careNumLabel) {
        _careNumLabel = [self createFatherLabel];
    }
    return _careNumLabel;
}
/**创建label*/
- (UILabel *)createFatherLabel {
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont my_SystemFontOfSize:16.f];
    label.textColor = [UIColor blackColor];
    return label;
}






@end
