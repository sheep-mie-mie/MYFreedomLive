//
//  MYWaveView.m
//  MYFreedomLive
//
//  Created by ifly on 2017/5/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYWaveView.h"


@interface MYWaveView ()
/**波纹振幅*/
@property (nonatomic, assign) CGFloat waveAmplitude;
/**波纹传播的周期*/
@property (nonatomic, assign) CGFloat wavePeriod;
/**波纹长度*/
@property (nonatomic, assign) CGFloat waveLength;
/**偏移量*/
@property (nonatomic, assign) CGFloat offsetX;
/**定时器*/
@property (nonatomic, strong) CADisplayLink *link;
/**形状视图*/
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/**头像*/
@property (nonatomic, strong) UIImageView *icon;
/**标签文字*/
@property (nonatomic, strong) UILabel *labelName;
/**设置按钮*/
@property (nonatomic, strong) UIButton *btnSet;
/**头像名称*/
@property (nonatomic, copy  ) NSString *iconName;

@end


@implementation MYWaveView

- (instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName CenterIcon:(NSString *)icon {
    if (self = [super initWithFrame:frame]) {
        
        self.contentMode = UIViewContentModeScaleToFill;
        self.image = ImageNamed(imageName);
        _iconName = icon;
        
        [self buildUpThisViewState];
    }
    return self;
}


/**
 设置界面状态
 */
- (void)buildUpThisViewState {
    
    MYWEAKSELF;
    
    self.wavePeriod = 1;
    self.waveLength = MAINSCREEN_WIDTH;
    
    // 头像
    [self addSubview:self.icon];
    self.icon.image = ImageNamed(_iconName);
    self.icon.layer.cornerRadius = 40.f;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(80.f);
        make.centerX.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf).offset(-40);
    }];
    // 昵称
    [self addSubview:self.labelName];
    self.labelName.text = @"一条呆呆鱼";
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300.f);
        make.height.mas_equalTo(24.f);
        make.top.mas_equalTo(weakSelf.icon.mas_bottom).offset(4.f);
        make.centerX.equalTo(weakSelf);
    }];
}

- (void)startWave {
    
    self.waveAmplitude = 6.0f;
    self.shapeLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.shapeLayer];
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    //【**波动画关键**】 一秒执行60次（算是CADisplayLink特性），即每一秒执行 setShapeLayerPath 方法60次
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setShapeLayerPath)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)setShapeLayerPath {
    // 振幅不断践行 波执行完后为0
    self.waveAmplitude -= 0.02; // 2s后为0
    if (self.waveAmplitude < 0.1) {
        [self stopWave];
    }
    // 每次执行画的正玄线平移一小段距离 （SCREEN_W / 60 / wavePeriod，1s执行60次，传波周期为wavePeriod,所以每个波传播一个屏幕的距离） 从而形成波在传播的效果
    self.offsetX += (MAINSCREEN_WIDTH / 60 / self.wavePeriod);
    _shapeLayer.path = [[self currentWavePath] CGPath];
}


/**
 画线
 */
- (UIBezierPath *)currentWavePath {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    // 设置线宽
    bezierPath.lineWidth = 2.0f;
    //
    CGPathMoveToPoint(path, nil, 0, self.frame.size.height);
    CGFloat y = 0.0f;
    
    for (float x = 0; x<MAINSCREEN_WIDTH * 2.f; x++) {
        /**
         * *** 正玄波的基础知识  ***
         *  f(x) = Asin(ωx+φ)+k
         *  A    为振幅, 波在上下振动时的最大偏移
         *  φ/w  为在x方向平移距离
         *  k    y轴偏移，即波的振动中心线y坐标与x轴的偏移距离
         *  2π/ω 即为波长，若波长为屏幕宽度即， SCREEN_W = 2π/ω, ω = 2π/SCREEN_W
         */
        y = _waveAmplitude * sinf((2 * M_PI / _waveLength) * (x + _offsetX + _waveLength / 12)) + self.frame.size.height - _waveAmplitude;
        // A = waveAmplitude  w = (2 * M_PI / waveLength) φ = (waveLength / 12) / (2 * M_PI / waveLength) k = headHeight - waveAmplitude （注意：坐标轴是一左上角为原点的）
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, MAINSCREEN_WIDTH, self.frame.size.height);
    CGPathCloseSubpath(path);
    bezierPath.CGPath = path;
    CGPathRelease(path);
    return bezierPath;
}

- (void)stopWave {
    [self.shapeLayer removeFromSuperlayer];
    [self.link invalidate];
    self.link = nil;
}


#pragma mark ==============//懒加载\\==============

- (UILabel *)labelName {
    if (!_labelName) {
        _labelName = [UILabel new];
        _labelName.textAlignment = NSTextAlignmentCenter;
        _labelName.numberOfLines = 0;
        _labelName.textColor = [UIColor whiteColor];
    }
    return _labelName;
}




- (UIImageView *)icon {
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}


- (UIButton *)btnSet {
    if (!_btnSet) {
        _btnSet = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSet setImage:ImageNamed(@"MoreSetting") forState:UIControlStateNormal];
        [_btnSet sizeToFit];
        [self addSubview:_btnSet];
    }
    return _btnSet;
}










@end










