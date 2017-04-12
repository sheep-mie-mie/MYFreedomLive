//
//  MYLiveViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/22.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYLiveViewController.h"

@interface MYLiveViewController ()

@end

@implementation MYLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnAction {
    
    [self dismissViewControllerAnimated:MASAttributeCenterYWithinMargins completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
