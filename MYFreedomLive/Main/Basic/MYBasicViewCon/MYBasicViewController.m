//
//  MYBasicViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYBasicViewController.h"

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








@end
