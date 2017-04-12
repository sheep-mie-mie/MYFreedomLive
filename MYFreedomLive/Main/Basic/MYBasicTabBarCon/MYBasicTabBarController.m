//
//  MYBasicTabBarController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYBasicTabBarController.h"
#import "MYHomeViewController.h"
#import "MYMineViewController.h"
#import "MYBasicNavigationController.h"
#import "MYHotTableViewController.h"
#import "MYNewCollectionController.h"
#import "MYAttractCollectionController.h"
#import "MYTextViewController.h"

static dispatch_once_t onceToken;
static MYBasicTabBarController *mainTabBar = nil;

@interface MYBasicTabBarController ()

@end

@implementation MYBasicTabBarController

/**
 创建单利
 
 @return 单利对象
 */
+ (MYBasicTabBarController *)shareMainTabBar {

    dispatch_once(&onceToken, ^{
        mainTabBar = [[MYBasicTabBarController alloc] init];
    });
    return mainTabBar;
}

/**
 退出登录时 销毁单利
 */
+ (void)tabBarDestructSingleton {
    mainTabBar = nil;
    onceToken  = 0l;
}

- (instancetype)init {
    if ([super init]) {
        
        [self customizeTabBarAppearance:self];
        //创建子视图
        [self buildUpVIewControllerAndItems];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 创建工具栏及子视图控制器
 */
- (void)buildUpVIewControllerAndItems {
    //new 和 init 区别
    NSMutableArray <NSDictionary *>* tabBarItems = [NSMutableArray new];
    NSArray *imageNormalArr = @[@"toolbar_home",@"toolbar_me"];
    NSArray *titleArr       = @[@"首页",@"我的"];
    NSMutableArray <UIViewController *>* viewControllers = [NSMutableArray new];
    NSArray *vcs = @[@"MYHomeViewController",@"MYMineViewController"];
    for (int i = 0; i < titleArr.count; i ++) {
        NSString *selectIgmStr = [NSString stringWithFormat:@"%@_sel",imageNormalArr[i]];
        NSDictionary *item = @{CYLTabBarItemTitle : titleArr[i],
                               CYLTabBarItemImage : imageNormalArr[i],
                               CYLTabBarItemSelectedImage : selectIgmStr};
        [tabBarItems addObject:item];
        
        UIViewController *basicVC;
        
        if (i == 0) {
            basicVC = [self createHomePageController];
        } else {
            basicVC = [NSClassFromString(vcs[i]) new];
        }
         MYBasicNavigationController *nvc = [[MYBasicNavigationController alloc] initWithRootViewController:basicVC];
        basicVC.navigationItem.title =  titleArr[i];
        [viewControllers addObject:nvc];
    }
    self.tabBarItemsAttributes = tabBarItems;
    self.viewControllers       = viewControllers;
}

/**
 创建首页的分栏控制器
 */
- (MYHomeViewController *)createHomePageController {
    NSMutableArray *vcs    = [NSMutableArray new];
    NSMutableArray *titles = [NSMutableArray new];
    for (int i = 0; i < 3; i++) {
        UIViewController *vc;
        NSString *title = @"";
        switch (i) {
            case 0: {
                vc = [MYHotTableViewController new];
                title = @"热门";
            }
                break;
            case 1: {
                vc = [MYNewCollectionController new];
                title = @"最新";
            }
                break;
            case 2: {
                vc = [MYAttractCollectionController new];
                title = @"关注";
            }
                break;
            default:
                break;
        }
        [vcs addObject:[vc class]];
        [titles addObject:title];
    }
    MYHomeViewController *homeVC = [[MYHomeViewController alloc] initWithViewControllerClasses:vcs andTheirTitles:titles];
    
    // 设置导航栏信息
    homeVC.menuHeight = 44;
    homeVC.titleSizeNormal = 17.f * AutoSizeScaleX;
    homeVC.titleSizeSelected = 18.f * AutoSizeScaleX;
    homeVC.menuViewStyle = WMMenuViewStyleSegmented;
    homeVC.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    homeVC.titleColorNormal = [UIColor whiteColor];
    homeVC.titleColorSelected = MainSelectColor;
    homeVC.progressColor = [UIColor whiteColor];
    homeVC.menuBGColor = [UIColor clearColor];
    homeVC.showOnNavigationBar = YES;
    
    return homeVC;
}



/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    self.tabBarHeight = 44.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = MainSelectColor;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    //[self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];//[UIColor imageWithColor:SXRGBAColor(223, 91, 147, 1.0)]
    
    // set the bar background image
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        //        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor redColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
