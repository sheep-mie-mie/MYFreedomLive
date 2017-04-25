//
//  MYBasicViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYBasicViewController.h"

static const void *GifKey = &GifKey;

@interface MYBasicViewController ()

@end

@implementation MYBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = SXRGBAColor(240.f, 240.f, 240.f, 1.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addHud {
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

- (void)addHudWithMessage:(NSString *)message {
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.labelText = message;
    }
}

- (void)removeHud {
    if (!_hud) {
        [_hud removeFromSuperViewOnHide];
        _hud = nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (UIImageView *)gifView {
    
    return objc_getAssociatedObject(self, GifKey);
}

- (void)setGifView:(UIImageView *)gifView {
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 显示GIF动画
- (void)showGifLoading:(NSArray *)images inView:(UIView *)view {
    if (!images.count) {
        images = @[ImageNamed(@"hold1_60x72"), ImageNamed(@"hold2_60x72"), ImageNamed(@"hold3_60x72")];
    }
    UIImageView *gifView = [[UIImageView alloc] init];
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(70);
    }];
    self.gifView = gifView;
    [gifView playGifAnimation:images];
}

// 取消GIF加载动画
- (void)hideGifLoading {
    [self.gifView stopGifAnimation];
    [self.gifView removeFromSuperview];
    self.gifView = nil;
}

- (BOOL)isNotEmpty:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return YES;
    }
    return NO;
}






@end
