//
//  MYHotPlayerUserInfoView.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/13.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerUserInfoView.h"
#import "MYStorageData.h"

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
        make.width.equalTo(@(96.f * AutoSizeScaleX));
        make.height.equalTo(@(32.f * AutoSizeScaleY));
        make.centerX.equalTo(weakSelf.userBackView.mas_centerX).offset(-8 * AutoSizeScaleX - 96.f * AutoSizeScaleX / 2.f);
        make.top.equalTo(welcomeLabel.mas_bottom).offset(10.f * AutoSizeScaleY);
    }];
    // 关注按钮
    UIButton *buttonCare = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCare setTitle:@"+ 关注" forState:UIControlStateNormal];
    [buttonCare  setTitle:@"已关注" forState:UIControlStateSelected];
    [buttonCare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal | UIControlStateSelected];
    buttonCare.tag = PlayerUserInfoBtnTag + 3;
    [buttonCare maskViewToBoundsWithCornerRadius:4.f * AutoSizeScaleX];
    buttonCare.backgroundColor = SXRGBAColor(199.f, 61.f, 116.f, 1.0f);
    [buttonCare addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.userBackView addSubview:buttonCare];
    [buttonCare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(watchBtn);
        make.left.equalTo(watchBtn.mas_right).offset(24 * AutoSizeScaleX);
    }];
    // 设置底部 视图
    UIView *viewBottom = [UIView new];
    viewBottom.backgroundColor = [UIColor whiteColor];
    [self.userBackView addSubview:viewBottom];
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.userBackView);
        make.height.equalTo(@(136.f * AutoSizeScaleX));
    }];
    // 关注人数 粉丝 View
    UIView *attentAndFansView = [UIView new];
    [viewBottom addSubview:attentAndFansView];
    [attentAndFansView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(viewBottom);
//        make.right.equalTo(viewBottom.mas_right).multipliedBy(0.5f);
        make.height.equalTo(@(81.f * AutoSizeScaleY));
    }];
    // 关注数
    [attentAndFansView addSubview:self.careNumLabel];
    [self.careNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(attentAndFansView.mas_left);
        make.right.equalTo(attentAndFansView.mas_right).multipliedBy(0.5f);
        make.centerY.equalTo(attentAndFansView.mas_centerY).offset(-12 * AutoSizeScaleY);
        make.height.equalTo(@(24.f * AutoSizeScaleY));
    }];
    self.careNumLabel.text = @"9981";
    // 关注
    UILabel *labelAttent = [UILabel new];
//    labelAttent.backgroundColor = RandColor;
    labelAttent.textColor = [UIColor lightGrayColor];
    labelAttent.textAlignment = NSTextAlignmentCenter;
    labelAttent.font = [UIFont my_SystemFontOfSize:15.f];
    labelAttent.text = @"关注";
    [attentAndFansView addSubview:labelAttent];
    [labelAttent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(weakSelf.careNumLabel);
//        make.left.equalTo(attentAndFansView.mas_left);
//        make.right.equalTo(attentAndFansView.mas_right).multipliedBy(0.5f);
//        make.height.equalTo(weakSelf.careNumLabel.mas_height);
        make.top.equalTo(weakSelf.careNumLabel.mas_bottom);
    }];
    // 粉丝数
    [attentAndFansView addSubview:self.fansNumLabel];
    [self.fansNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(attentAndFansView.mas_right);
//        make.centerY.equalTo(attentAndFansView.mas_centerY).offset(12.f * AutoSizeScaleY);
        make.top.equalTo(weakSelf.careNumLabel.mas_top);
        make.left.equalTo(weakSelf.careNumLabel.mas_right);
        make.height.equalTo(weakSelf.careNumLabel.mas_height);
    }];
    self.fansNumLabel.text = @"9527";
    // 粉丝
    UILabel *labelFans = [UILabel new];
//    labelFans.backgroundColor = RandColor;
    labelFans.textColor = [UIColor lightGrayColor];
    labelFans.textAlignment = NSTextAlignmentCenter;
    labelFans.font = [UIFont my_SystemFontOfSize:15.f];
    labelFans.text = @"粉丝";
    [attentAndFansView addSubview:labelFans];
    [labelFans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(weakSelf.fansNumLabel);
        make.top.equalTo(weakSelf.fansNumLabel.mas_bottom);
    }];
    // 分界线
    UIView *viewSeparate = [UIView new];
    viewSeparate.backgroundColor = SXRGBAColor(180.f, 180.f, 180.f, 1.0f);
    [viewBottom addSubview:viewSeparate];
    [viewSeparate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(attentAndFansView);
        make.height.equalTo(@(1));
        make.top.equalTo(attentAndFansView.mas_bottom);
    }];
    // 四按钮
    NSArray *btnNames = @[@"关注", @"私聊", @"邀播", @"踢出"];
    CGFloat btnWidth = width / btnNames.count;
    for (int i = 0; i<btnNames.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnNames[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont my_SystemFontOfSize:16.f];
        [btn setTitleColor:SXRGBAColor(199.f, 61.f, 116.f, 1.0f) forState:UIControlStateNormal];
        [viewBottom addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewBottom).offset(i * btnWidth);
            //make.height.equalTo(@(36.f * AutoSizeScaleY));
            make.top.equalTo(viewSeparate.mas_bottom);
            make.bottom.equalTo(viewBottom.mas_bottom);
            make.width.equalTo(@(btnWidth - 1.f));
        }];
        if (i == 0) { // 关注按钮
            if ([[MYStorageData shareMYStorageData] dataIsExistence:self.currentModel]) {
                btn.selected = YES;
                buttonCare.selected = YES;
            }
        }
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = PlayerUserInfoBtnTag + 4 + i;
        // 分割线
        if (i != btnNames.count - 1) {
            UIView *separateLine = [UIView new];
            separateLine.backgroundColor = viewSeparate.backgroundColor;
            [viewBottom addSubview:separateLine];
            [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btn.mas_right);
                make.height.equalTo(btn.mas_height).multipliedBy(0.48f);
                make.width.equalTo(@(1.f));
                make.centerY.equalTo(btn.mas_centerY);
            }];
        }
    }
    [self layoutIfNeeded];
}

/**
 点击事件
 */
- (void)buttonClickAction:(UIButton *)btn {
    
    switch (btn.tag) {
        case 100: { // 举报
            DTLog(@"举报");
            // 定制延时执行任务 不会阻塞线程 效率高(推存使用)
            [MBProgressHUD showMessag:@"正在为你处理.." toView:self.userBackView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.userBackView animated:YES];
                    [MBProgressHUD showSuccess:@"举报成功!" toView:self];
                });
            });
        }
            break;
        case 101: { // 关闭
            DTLog(@"关闭");
            [self tapGestureAction];
        }
            break;
        case 102: { // 看直播
            DTLog(@"看直播");
            if (self.clickUserInfoSelectBlock) {
                self.clickUserInfoSelectBlock();
                [self tapGestureAction];
            }
        }
            break;
        case 103: { // +关注
            DTLog(@"+关注");
            if (!btn.selected) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    BOOL isSave = [[MYStorageData shareMYStorageData] saveData:self.currentModel];
                    if (isSave) {
                        [MBProgressHUD showSuccess:@"关注成功" toView:self];
                        btn.selected = !btn.selected;
                    } else {
                        [MBProgressHUD showError:@"关注失败" toView:self];
                    }
                });
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    BOOL isSave = [[MYStorageData shareMYStorageData] deleteData:self.currentModel];
                    if (isSave) {
                        [MBProgressHUD showSuccess:@"取消关注成功" toView:self];
                        btn.selected = !btn.selected;
                    } else {
                        [MBProgressHUD showError:@"取消关注失败" toView:self];
                    }
                });
            }
        }
            break;
        case 104: { // 关注
            DTLog(@"关注");
            if (!btn.selected) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    BOOL isSave = [[MYStorageData shareMYStorageData] saveData:self.currentModel];
                    if (isSave) {
                        [MBProgressHUD showSuccess:@"关注成功" toView:self];
                        btn.selected = !btn.selected;
                    }else{
                        [MBProgressHUD showError:@"关注失败" toView:self];
                    }
                });
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    BOOL isSave = [[MYStorageData shareMYStorageData] saveData:self.currentModel];
                    if (isSave) {
                        [MBProgressHUD showSuccess:@"取消关注成功" toView:self];
                        btn.selected = !btn.selected;
                    }else{
                        [MBProgressHUD showError:@"取消关注失败" toView:self];
                    }
                });
            }
        }
            break;
        case 105: { // 私聊
            DTLog(@"私聊");
            [MBProgressHUD showMessage:@"私聊" toView:self.userBackView];
        }
            break;
        case 106: { // 邀播
            DTLog(@"邀播");
            [MBProgressHUD showMessage:@"邀播" toView:self.userBackView];
        }
            break;
        case 107: { // 踢出
            DTLog(@"踢出");
            [MBProgressHUD showMessage:@"踢出" toView:self.userBackView];
        }
            break;
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
    [self.userImv maskViewToBoundsWithCornerRadius:CGRectGetWidth(self.userImv.bounds) * 0.5];
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
