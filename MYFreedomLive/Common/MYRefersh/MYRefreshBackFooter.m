//
//  MYRefreshBackFooter.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/24.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYRefreshBackFooter.h"

@interface MYRefreshBackFooter ()
/**
 提示语
 */
@property (nonatomic, weak) UILabel * label;
/**
 图片
 */
@property (nonatomic, weak) UIImageView * logoView;
/**
 加载框
 */
@property (nonatomic, weak) UIActivityIndicatorView * loadView;

@end


@implementation MYRefreshBackFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50.f;
    // 添加label
    UILabel *label  = [[UILabel alloc] init];
    label.textColor = SXRGBAColor(1.0f, 0.5f, 0.0f, 1.0f);
    label.font      = [UIFont my_BoldSystemFontOfSize:16.f];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    // logo
#warning addIamge
    UIImageView *logoView = [[UIImageView alloc] initWithImage:ImageNamed(@"")];
    logoView.contentMode  = UIViewContentModeScaleAspectFit;
    [self addSubview:logoView];
    self.logoView = logoView;
    // loading
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loadView];
    self.loadView = loadView;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    __weak typeof(self)weakSelf = self;
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.width.mas_equalTo(weakSelf);
        make.centerX.mas_offset(weakSelf.mj_w * 0.5f);
        make.centerY.mas_offset(weakSelf.mj_y + weakSelf.logoView.mj_y * 0.5);
    }];
    /*
     self.logoView.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
     self.logoView.center = CGPointMake(self.mj_w * 0.5, self.mj_h + self.logoView.mj_h * 0.5);
     */
    [self.loadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(weakSelf.mj_w - 30);
        make.centerY.mas_offset(weakSelf.mj_h * 0.5f);
    }];
    /*
     self.loadView.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
     */
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle: {
            [self.loadView stopAnimating];
            self.label.text = @"赶紧上拉呀";
        }
            break;
        case MJRefreshStatePulling: {
            [self.loadView stopAnimating];
            self.label.text = @"赶紧放开我吧";
        }
            break;
        case MJRefreshStateRefreshing: {
            [self.loadView startAnimating];
            self.label.text = @"加载数据中...";
        }
            break;
        case MJRefreshStateNoMoreData: {
            [self.loadView stopAnimating];
            self.label.text = @"木有数据了";
        }
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red   = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue  = 0.5 * pullingPercent;
    self.label.textColor = SXRGBAColor(red, green, blue, 1.0f);
}




@end
