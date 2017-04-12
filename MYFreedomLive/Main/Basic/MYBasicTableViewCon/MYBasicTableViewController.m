//
//  MYBasicTableViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYBasicTableViewController.h"

@interface MYBasicTableViewController ()<
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

@end

@implementation MYBasicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXRGBAColor(240.f, 240.f, 240.f, 1.0f);
    
    [self netWork_Loading];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.emptyDataSetSource   = self;
    self.tableView.emptyDataSetDelegate = self;
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark ==============//DZNEmptyDataSetSource\\==============
// 返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.emptyDataTitle;
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont my_BoldSystemFontOfSize:17.0], NSForegroundColorAttributeName : SXRGB16Color(0x545454)};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
// 返回详情文字
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.emptyDataDescription;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    paragraph.alignment     = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont my_BoldSystemFontOfSize:15.0], NSForegroundColorAttributeName : SXRGB16Color(0x545454), NSParagraphStyleAttributeName : paragraph};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//返回点击按钮 带标题
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont my_BoldSystemFontOfSize:17.0]};
    return [[NSAttributedString alloc] initWithString:self.emptyDataButtonTitle attributes:attribute];
}
//返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:self.emptyDataImageName];
}
//动画效果
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue   = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue     = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.f, 0.f, 0.f)];
    animation.duration    = 0.25;
    animation.cumulative  = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}


/*
 // 返回图片的 tintColor
 - (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
 return [UIColor yellowColor];
 }
 
 // 返回可点击按钮的 image
 - (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
 return [UIImage imageNamed:@"icon_wwdc"];
 }
 
 // 返回可点击按钮的 backgroundImage
 - (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
 return [UIImage imageNamed:@"icon_wwdc"];
 }
 
 // 返回自定义 view
 - (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
 return nil;
 }
 */

#pragma mark ==============//DZNEmptyDataSetDelegate Methods\\==============
// 是否显示空白页 默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
// 是否允许点击 默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
// 是否允许滚动 默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
// 图片是否动画效果 默认NO
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return NO;
}
// 将要出现
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    //do something
}
// 已经出现
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView {
    //do something
}
// 将要消失
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView {
    //do something
}
// 已经消失
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView {
    //do something
}
// 点击按钮响应事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
}
// 点击区域事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    
}
// 标题文字与详情文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 4;
}
// 返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return SXRGBAColor(230.f, 230.f, 230.f, 1.0f);
}
// 标题文字与详情文字同事调整垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 2;
}

// 正在加载中
- (void)netWork_Loading {
    self.emptyDataImageName   = @"network_loading";
    self.emptyDataTitle       = @"小丫头正在努力...";
    self.emptyDataButtonTitle = @"";
    self.emptyDataDescription = @"正在努力加载数据中...";
    [self.tableView reloadEmptyDataSet];
}
// 加载失败
- (void)netWork_Failure {
    self.emptyDataTitle       = @"对不起,小丫头已经尽力啦...";
    self.emptyDataButtonTitle = @"点击重新加载...";
    self.emptyDataImageName   = @"network_failure";
    [self.tableView reloadEmptyDataSet];
}
// 无数据时加载
- (void)netWork_EmptyData {
    self.emptyDataTitle       = @"对不起,小丫头已经尽力啦...";
    self.emptyDataButtonTitle = @"点击重新加载...";
    self.emptyDataImageName   = @"network_failure";
    [self.tableView reloadEmptyDataSet];
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
    if (_hud) {
        [_hud removeFromSuperViewOnHide];
        _hud = nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}








@end
