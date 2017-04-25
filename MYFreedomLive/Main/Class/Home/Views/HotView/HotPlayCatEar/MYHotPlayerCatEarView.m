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
    
}




























@end
