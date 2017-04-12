//
//  MYHotTableViewController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/21.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotTableViewController.h"
#import "MYHotPlayerViewController.h"
#import "MYHotAdViewController.h"
#import "MYHotPlayerInfoModel.h"
#import "MYHotTableViewCell.h"
#import "MYHotADInfoModel.h"


@interface MYHotTableViewController ()<SDCycleScrollViewDelegate>

/**
 广告轮播图
 */
@property (nonatomic, strong) SDCycleScrollView *adScrollView;
/**
 广告数据源
 */
@property (nonatomic, strong) NSMutableArray <MYHotADInfoDetailModel *> *hotADListArr;
/**
 player数据源
 */
@property (nonatomic, strong) NSMutableArray <MYHotPlayerInfoDataListModel *> *hotDataArr;
/**
 当前页
 */
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation MYHotTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildHotViewState];
}


/**
 设置热门界面
 */
- (void)buildHotViewState {
    
    [self.tableView registerClass:[MYHotTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MYHotTableViewCell class])];
    
    // 刷新
    MJRefreshNormalHeader *refHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadHotInfoNetWorkIsMore:NO];
    }];
    // 加载
    MYRefreshBackFooter *refFooter = [MYRefreshBackFooter footerWithRefreshingBlock:^{
        [self loadHotInfoNetWorkIsMore:YES];
    }];
    refHeader.stateLabel.hidden           = YES;
    refHeader.lastUpdatedTimeLabel.hidden = YES;
    refHeader.automaticallyChangeAlpha    = YES;
    
    refFooter.automaticallyHidden         = NO;
    refFooter.automaticallyChangeAlpha    = YES;
    self.tableView.mj_header = refHeader;
    self.tableView.mj_footer = refFooter;
    
    if ([self.hotDataArr count] > 0) {
        [self.tableView.mj_header beginRefreshing];
    } else {
        [self netWork_Loading];
        [self loadHotInfoNetWorkIsMore:NO];
    }
}


- (void)loadHotInfoNetWorkIsMore:(BOOL)isMore {
    
    if (!isMore) {
        self.currentPage = 1;
        [self.tableView.mj_footer resetNoMoreData];
        // 加载广告
        [MYNetwork getHotViewADInfoSuccess:^(id returnData) {
            [self loadReturnData:returnData IsAD:YES IsMore:NO];
        } failure:^(NSError *err) {
            
        } showView:nil];
    }
    
    // 加载数据
    [MYNetwork getHotViewPlayerInfoWithPage:self.currentPage Success:^(id returnData) {
        [self loadReturnData:returnData IsAD:NO IsMore:isMore];
    } failure:^(NSError *err) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self netWork_Failure];
    } showView:self.hotDataArr.count <= 0 ? nil : self.view];
}

- (void)loadReturnData:(id)returnData IsAD:(BOOL)isAD IsMore:(BOOL)isMore {
    
    if (isAD) {
        MYHotADInfoModel *result = [MYHotADInfoModel mj_objectWithKeyValues:returnData];
        if (result.code == 100) {
            [self.hotADListArr removeAllObjects];
            self.hotADListArr = [NSMutableArray arrayWithArray:result.data];
        } else {
            
        }
    } else {
        MYHotPlayerInfoModel *result = [MYHotPlayerInfoModel mj_objectWithKeyValues:returnData];
        if (result.code == 100) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (!isMore) {
                [self.hotDataArr removeAllObjects];
                self.hotDataArr = [NSMutableArray arrayWithArray:result.data.list];
            }
            if ([result.data.list count] < 20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.alpha = 1.0f;
            } else {
                self.currentPage ++;
                self.tableView.mj_footer.alpha = 0.f;
            }
            [self.hotDataArr addObjectsFromArray:result.data.list];
        } else {
            [self netWork_Failure];
        }
        [self.tableView reloadData];
        [self.tableView reloadEmptyDataSet];
    }
}



#pragma mark ==============//UITableView DataSource Delegate\\==============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.hotDataArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYHotTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MYHotTableViewCell class]) forIndexPath:indexPath];
    cell.infoModel = self.hotDataArr[indexPath.section];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAINSCREEN_WIDTH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == [self.hotDataArr count] - 1) {
        return 0.0000001f;
    }
    return 5.f * AutoSizeScaleY;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MYHotPlayerViewController *hotPlayerVC = [[MYHotPlayerViewController alloc] initWithHotDataArr:self.hotDataArr hotModel:self.hotDataArr[indexPath.section]];
    [self presentViewController:hotPlayerVC animated:YES completion:nil];
}



#pragma mark ==============//SDCycleScrollViewDelegate\\==============
// 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    MYHotADInfoDetailModel *model = self.hotADListArr[index];
    MYHotAdViewController *adViewCon = [[MYHotAdViewController alloc] initWithLink:model.link];
    [self.navigationController pushViewController:adViewCon animated:YES];
}
// 滚动生成回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
}

#pragma mark ==============//重写GET方法\\==============

- (void)setHotADListArr:(NSMutableArray<MYHotADInfoDetailModel *> *)hotADListArr {
    _hotADListArr = hotADListArr;
    if (hotADListArr == nil) {
        return;
    }
    NSMutableArray *titlesArr = [NSMutableArray new];
    NSMutableArray *imagesArr = [NSMutableArray new];
    for (MYHotADInfoDetailModel *model in hotADListArr) {
        [titlesArr addObject:model.title];
        [imagesArr addObject:model.imageUrl];
    }
    self.adScrollView.titlesGroup = titlesArr;
    self.adScrollView.imageURLStringsGroup = imagesArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ==============//懒加载\\==============

- (SDCycleScrollView *)adScrollView {
    if (!_adScrollView) {
        _adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 180.f * AutoSizeScaleY) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _adScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _adScrollView.currentPageDotColor = [UIColor skyBlue];
        self.tableView.tableHeaderView = _adScrollView;
        _adScrollView.titleLabelTextFont = [UIFont my_FontWithName:@"Verdana-Bold" size:14.f];
    }
    return _adScrollView;
}

- (NSMutableArray<MYHotPlayerInfoDataListModel *> *)hotDataArr {
    if (_hotDataArr == nil) {
        _hotDataArr = [[NSMutableArray alloc] init];
    }
    return _hotDataArr;
}






@end
