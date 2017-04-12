//
//  MYBasicNavigationController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYBasicNavigationController.h"


// 打开边界多少距离才触发pop
#define Distance_To_Pop 80


@interface MYBasicNavigationController ()<
UIGestureRecognizerDelegate,
UINavigationControllerDelegate>

@end

@implementation MYBasicNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.arrayScreenshot = [NSMutableArray array];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUpNavViewLayout];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGesture.delegate = self;
    [self.view addGestureRecognizer:self.panGesture];
    if (IOS7) {
        self.navigationBar.translucent = YES;
    }
}


/**
 设置界面布局
 */
- (void)buildUpNavViewLayout {
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"navBar_bg_414x70"];
    NSDictionary *textAttributes = @{NSFontAttributeName:[UIFont my_FontWithName:@"HelveticaNeue-CondensedBlack" size:20.f],
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:textAttributes];
    
    UIImage *backBtnImage = [[UIImage imageNamed:@"privatechat_back_19x19_"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backBtnImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return nil;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    
    
    
    
    
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 状态栏颜色

 @return 统一管理状态栏
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
