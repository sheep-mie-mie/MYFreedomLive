//
//  MYHomeViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHomeViewController.h"
#import "MYHotTableViewController.h"
#import "MYNewCollectionController.h"
#import "MYAttractCollectionController.h"

@interface MYHomeViewController ()<WMPageControllerDataSource>

@end

@implementation MYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ==============//WMPageController DataSource\\==============
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *homeVC = [UIViewController new];
    if (index == 0) {
        // 热门
        homeVC = [MYHotTableViewController new];
    } else if (index == 1) {
        // 最新
        homeVC = [MYNewCollectionController new];
    } else if (index == 2) {
        // 关注
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        homeVC = [[MYAttractCollectionController alloc] initWithCollectionViewLayout:layout];
    }
    return homeVC;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
