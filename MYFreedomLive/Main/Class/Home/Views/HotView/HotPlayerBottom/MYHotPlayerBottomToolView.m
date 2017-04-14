//
//  MYHotPlayerBottomToolView.m
//  MYFreedomLive
//
//  Created by ifly on 2017/4/13.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotPlayerBottomToolView.h"


@interface MYHotPlayerBottomToolView ()

/**
 工具数组
 */
@property (nonatomic, strong) NSArray *tools;

@end


@implementation MYHotPlayerBottomToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setBottomViewBasic];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

/**
 设置界面状态
 */
- (void)setBottomViewBasic {
    CGFloat width  = 36.f * AutoSizeScaleX;
    CGFloat margin = (CGRectGetWidth(self.frame) - width * self.tools.count) / (self.tools.count + 1);
    CGRect oldFrame = self.frame;
    CGFloat height  = width + margin / 2.0f;
    oldFrame.origin.y = MAINSCREEN_HEIGHT - height;
    self.frame = oldFrame;
    
    CGFloat x = 0.f;
    for (int i = 0; i<self.tools.count; i++) {
        x = (margin + width) * i + margin;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, margin / 4.0f, width, width);
        btn.userInteractionEnabled = YES;
        btn.tag = i + 100;
        [btn setImage:ImageNamed(self.tools[i]) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)btnAction:(UIButton *)btn {
    if (self.clickToolBottomBlock) {
        self.clickToolBottomBlock(btn.tag - 100);
    }
}


#pragma mark ==============//懒加载\\==============

- (NSArray *)tools {
    if (!_tools) {
        _tools = [[NSArray alloc] initWithObjects:@"talk_public_40x40",
                  @"talk_private_40x40",
                  @"talk_sendgift_40x40",
                  @"talk_rank_40x40",
                  @"talk_share_40x40",
                  @"talk_close_40x40", nil];
    }
    return _tools;
}







@end
