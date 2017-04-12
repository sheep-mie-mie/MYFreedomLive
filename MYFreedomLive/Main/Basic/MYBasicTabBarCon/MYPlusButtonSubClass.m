//
//  MYPlusButtonSubClass.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/21.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYPlusButtonSubClass.h"
#import "MYBasicTabBarController.h"
#import "MYLiveViewController.h"


@interface MYPlusButtonSubClass ()<CYLPlusButtonSubclassing> {
    CGFloat _buttonImageHeight;
}

@end

@implementation MYPlusButtonSubClass

+ (void)load {
    //请在 `-application:didFinishLaunchingWithOptions:` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}


/**
 上下结构的 button
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小 间距大小
    // 注意: 一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWith   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight = imageViewEdgeWith;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.1;
    
    // imageView 和 titleLabel 中心的Y值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5 + 6;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight + verticalMargin * 2 + labelLineHeight * 0.5 + 8.5;
    
    // imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWith, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    // title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
    
}

#pragma mark ==============//CYLPlusButtonSubclassing Methods\\==============

+ (id)plusButton {
    MYPlusButtonSubClass *button = [[MYPlusButtonSubClass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"toolbar_live"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    [button setTitle:@"选中" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:10.5];
    [button sizeToFit];
    // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    //    button.frame = CGRectMake(0.0, 0.0, 250, 100);
    //    button.backgroundColor = [UIColor redColor];
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    MYLiveViewController *liveVC = [[MYLiveViewController alloc] init];
    [[MYBasicTabBarController shareMainTabBar].selectedViewController presentViewController:liveVC animated:YES completion:nil];
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return 0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return -10;
}











@end
