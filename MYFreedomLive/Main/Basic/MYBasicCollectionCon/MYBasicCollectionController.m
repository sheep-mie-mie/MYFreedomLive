//
//  MYBasicCollectionController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYBasicCollectionController.h"

@interface MYBasicCollectionController ()<
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@end

@implementation MYBasicCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self netWork_Loading];
    
    self.collectionView.delegate             = self;
    self.collectionView.dataSource           = self;
    self.collectionView.emptyDataSetSource   = self;
    self.collectionView.emptyDataSetDelegate = self;
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor skyBlue];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    return view;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


#pragma mark ==============//DZNEmptyDataSetSource\\==============
// 返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.emptyDataTitle;
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont my_BoldSystemFontOfSize:17.f], NSForegroundColorAttributeName : SXRGB16Color(0x545454)};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

// 返回详情文字
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.emptyDataDescription;
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont my_BoldSystemFontOfSize:15], NSForegroundColorAttributeName : SXRGB16Color(0x545454)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

// 返回可以点击的按钮 带标题
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont my_BoldSystemFontOfSize:17.f]};
    return [[NSAttributedString alloc] initWithString:self.emptyDataButtonTitle attributes:attribute];
}

// 返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:self.emptyDataImageName];
}

// 动画效果
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue   = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue     = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
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

#pragma mark ==============//DZNEmptyDtaSetDelegate Methods\\==============
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
    return NO;
}
// 空白页将要出现
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    
}
// 空白页已经出现
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView {
    
}
// 空白页将要消失
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView {
    
}
// 空白页已经消失
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView {
    
}

// 处理按钮的点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    //do something
}
// 空白区域点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    // do something
}
// 标题文字与详情文字的距离
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 4;
}
// 返回空白区域的颜色自定义
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return SXRGBAColor(230.f, 230.f, 230.f, 1.f);
}
// 标题文字与详情文字同时调整垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 2;
}


// 正在加载
- (void)netWork_Loading {
    self.emptyDataTitle       = @"小丫头正在努力...";
    self.emptyDataImageName   = @"network_loading";
    self.emptyDataButtonTitle = @"";
    self.emptyDataDescription = @"正在加载数据中,请稍等...";
    [self.collectionView reloadEmptyDataSet];
}
// 数据加载失败
- (void)netWork_Failure {
    self.emptyDataTitle       = @"对不起,小丫头已经尽力了...";
    self.emptyDataImageName   = @"network_failure";
    self.emptyDataButtonTitle = @"点击重新加载...";
    [self.collectionView reloadEmptyDataSet];
}
// 无数据时加载
- (void)netWork_EmptyData {
    self.emptyDataTitle       = @"对不起,小花花已经尽力了...";
    self.emptyDataImageName   = @"network_failure";
    self.emptyDataButtonTitle = @"点击重新加载...";
    [self.collectionView reloadEmptyDataSet];
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




@end
