//
//  MYHotPlayerCatEarView.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/25.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerCatEarView.h"

@interface MYHotPlayerCatEarView ()
/**播放视图*/
@property (nonatomic, strong) UIView *viewPlayer;
/**头像ImageView*/
@property (nonatomic, strong) UIImageView *imvHeader;
/**视频播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
@end


@implementation MYHotPlayerCatEarView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = SXRGBAColor(255.f, 255.f, 255.f, 1.0f);
        MYWEAKSELF;
        [self addSubview:self.viewPlayer];
        [self.viewPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f));
        }];
        [self addSubview:self.imvHeader];
        [self.imvHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf).offset(0.f);
            make.height.equalTo(@(25.f));
        }];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.viewPlayer.layer.cornerRadius = CGRectGetHeight(self.viewPlayer.bounds) * 0.5f;
    self.viewPlayer.layer.masksToBounds = YES;
    self.moviePlayer.view.frame = self.viewPlayer.bounds;
    [self.viewPlayer addSubview:self.moviePlayer.view];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
}

- (void)setCatEarModel:(MYHotPlayerInfoDataListModel *)catEarModel {
    _catEarModel = catEarModel;
    
    // 设置只播放视频 不播放声音
    IJKFFOptions *option = [IJKFFOptions optionsByDefault];
    [option setPlayerOptionValue:@"1" forKey:@"an"];
    // 开启硬解码
    [option setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    IJKFFMoviePlayerController *movie = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.catEarModel.flv] withOptions:option];
    // 填充Fill
    movie.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放
    movie.shouldAutoplay = YES;
    movie.view.userInteractionEnabled =YES;
    
    [movie prepareToPlay];
    self.moviePlayer = movie;
}

- (void)removeFromSuperview {
    if (self.moviePlayer) {
        
        [self.moviePlayer pause];
        [self.moviePlayer stop];
        [self.moviePlayer shutdown];
        [self.moviePlayer.view removeFromSuperview];
        self.moviePlayer = nil;
    }
    [super removeFromSuperview];
}

#pragma mark ==============//懒加载\\==============
- (UIView *)viewPlayer {
    if (!_viewPlayer) {
        _viewPlayer = [UIView new];
        _viewPlayer.userInteractionEnabled = YES;
    }
    return _viewPlayer;
}

- (UIImageView *)imvHeader {
    if (!_imvHeader) {
        _imvHeader = [[UIImageView alloc] initWithImage:ImageNamed(@"public_catEar_98x25")];
        _imvHeader.userInteractionEnabled = YES;
        _imvHeader.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imvHeader;
}

/*
 //改进
 //[options setPlayerOptionIntValue:0 forKey:@"no-time-adjust"];
 //[options setPlayerOptionIntValue:1 forKey:@"audio_disable"];
 //[options setPlayerOptionIntValue:1 forKey:@"infbuf"];
 //[options setPlayerOptionIntValue:0 forKey:@"framedrop"];
 
 //videotoolbox 配置（硬件解码）
 [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
 
 
 [options setPlayerOptionIntValue:30     forKey:@"max-fps"];
 [options setPlayerOptionIntValue:0      forKey:@"framedrop"];
 [options setPlayerOptionIntValue:3      forKey:@"video-pictq-size"];
 [options setPlayerOptionIntValue:0      forKey:@"videotoolbox"];
 [options setPlayerOptionIntValue:960    forKey:@"videotoolbox-max-frame-width"];
 
 [options setFormatOptionIntValue:0                  forKey:@"auto_convert"];
 [options setFormatOptionIntValue:1                  forKey:@"reconnect"];
 [options setFormatOptionIntValue:30 * 1000 * 1000   forKey:@"timeout"];
 [options setFormatOptionValue:@"ijkplayer"          forKey:@"user-agent"];
 
 */



@end

/**
-(void)layoutSubviews:当我们在某个类的内部调整子视图位置时，需要调用
layoutSubviews在以下情况下会被调用：
1、init初始化不会触发layoutSubviews.但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
2、addSubview会触发layoutSubviews
3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
4、滚动一个UIScrollView会触发layoutSubviews
5、旋转Screen会触发父UIView上的layoutSubviews事件
6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
**/


/**
 setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
 
 如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局
 **/

/**
 layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
 **/

/**
 
 -drawRect:(CGRect)rect方法：重写此方法，执行重绘任务
 -setNeedsDisplay方法：标记为需要重绘，异步调用drawRect
 -setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘
 sizeToFit会自动调用sizeThatFits方法；
 sizeToFit不应该在子类中被重写，应该重写sizeThatFits
 sizeThatFits传入的参数是receiver当前的size，返回一个适合的size
 sizeToFit可以被手动直接调用
 sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己
 
 **/



