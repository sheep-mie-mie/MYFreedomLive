//
//  MYHotAdViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/23.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotAdViewController.h"
#import <WebKit/WKWebView.h>

@interface MYHotAdViewController ()<
WKNavigationDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

/**
 加载广告网址
 */
@property (nonatomic, copy  ) NSString *link;

/**
 webView
 */
@property (nonatomic, strong) WKWebView *hotAdView;

@end

@implementation MYHotAdViewController

- (instancetype)initWithLink:(NSString *)link {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
        _link = link;
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildUpHotAdViewState];
}


/**
 设置广告页界面
 */
- (void)buildUpHotAdViewState {
    
    self.tableView.emptyDataSetSource   = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.tableView addSubview:self.hotAdView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
    [self.hotAdView loadRequest:request];
}


#pragma mark ==============//WKNavigationDelegate\\==============
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    self.hotAdView.alpha = 1.f;
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}


#pragma mark ==============//懒加载\\==============
- (WKWebView *)hotAdView {
    if (_hotAdView == nil) {
        _hotAdView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, self.tableView.frame.size.height - 89)];
        _hotAdView.navigationDelegate = self;
        _hotAdView.alpha = 0.f;
    }
    return _hotAdView;
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
