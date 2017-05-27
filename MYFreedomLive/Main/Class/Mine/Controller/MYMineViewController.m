//
//  MYMineViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/21.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYMineViewController.h"
#import "MYWaveView.h"
#import "MYTextViewController.h"

@interface MYMineViewController ()
/**头视图*/
@property (nonatomic, strong) MYWaveView *heardView;
/**是否正在播放动画*/
@property (nonatomic, assign, getter=isShowWave) BOOL showWave;
/**数据源*/
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation MYMineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self buildUpThisViewState];
}


/**
 设置界面状态
 */
- (void)buildUpThisViewState {
    
    [self.tableView addSubview:self.heardView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 270)];
    
    [self.tableView reloadEmptyDataSet];
    [self.tableView reloadData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableDictionary *dic = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}


// 计算缓存
- (NSString *)cacheSize {
    NSString *detailTitle = nil;
    CGFloat size = [SDImageCache sharedImageCache].getSize;
    if (size > 1024 * 1024) {
        detailTitle = [NSString stringWithFormat:@"%.02fM",size / 1024 / 1024];
    } else if (size > 1024) {
        detailTitle = [NSString stringWithFormat:@"%.02fKB",size / 1024];
    } else {
        detailTitle = [NSString stringWithFormat:@"%.02fB",size];
    }
    return detailTitle;
}





// 只要滚动就触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY < 0) {
        self.heardView.frame = CGRectMake(offSetY/2, offSetY, MAINSCREEN_WIDTH - offSetY, 270 - offSetY);
    }
}

// 减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isShowWave) {
        [self.heardView startWave];
    }
}

// 开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (fabs(offsetY) > 20) {
        self.showWave = YES;
    } else {
        self.showWave = NO;
    }
}

// 开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.heardView stopWave];
}






#pragma mark ==============//懒加载\\==============

- (MYWaveView *)heardView {
    if (!_heardView) {
        _heardView = [[MYWaveView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 270) Image:@"Cyuri03" CenterIcon:@"icon"];
    }
    return _heardView;
}

- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableDictionary *miaoBi = [NSMutableDictionary dictionary];
        miaoBi[@"title"] = @"我的喵币";
        miaoBi[@"icon"] = @"ic_account_balance_wallet_black_24dp1";
        //自己写要跳转到的控制器
        miaoBi[@"controller"] = [MYTextViewController class];
        NSMutableDictionary *zhiBoJian = [NSMutableDictionary dictionary];
        zhiBoJian[@"title"] = @"直播间管理";
        zhiBoJian[@"icon"] = @"MoreExpressionShops";
        //自己写要跳转到的控制器
        zhiBoJian[@"controller"] = [MYTextViewController class];
        NSMutableDictionary *shouYi = [NSMutableDictionary dictionary];
        shouYi[@"title"] = @"我的收益";
        shouYi[@"icon"] = @"MoreMyBankCard";
        shouYi[@"controller"] = [MYTextViewController class];
        NSMutableDictionary *liCai = [NSMutableDictionary dictionary];
        liCai[@"title"] = @"微钱进理财";
        liCai[@"icon"] = @"buyread";
        liCai[@"controller"] = [MYTextViewController class];
        NSMutableDictionary *cleanCache = [NSMutableDictionary dictionary];
        cleanCache[@"title"] = @"清空缓存";
        cleanCache[@"icon"] = @"img_cache";
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"设置";
        setting[@"icon"] = @"MoreSetting";
        setting[@"controller"] = [MYTextViewController class];
        NSArray *section1 = @[miaoBi, zhiBoJian];
        NSArray *section2 = @[shouYi, liCai];
        NSArray *section3 = @[cleanCache];
        NSArray *section4 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section1, section2, section3,section4, nil];
    }
    return _dataList;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
