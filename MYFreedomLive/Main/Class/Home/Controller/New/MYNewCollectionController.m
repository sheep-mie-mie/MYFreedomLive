//
//  MYNewCollectionController.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/20.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYNewCollectionController.h"
#import "MYNewCollectionViewCell.h"

@interface MYNewCollectionController ()

/**
 newView数据源
 */
@property (nonatomic, strong) NSMutableArray<MYNewPlayerInfoDataListModel *> *infoDataNew;
/**
 当前页
 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation MYNewCollectionController

- (UICollectionViewFlowLayout *)layout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat margin = 10.f * AutoSizeScaleX;
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = 0.f;
    CGFloat width = (MAINSCREEN_WIDTH - (2 + 1) * margin) / 2;
    layout.itemSize = CGSizeMake(width, width);
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    layout.collectionView.showsVerticalScrollIndicator   = NO;
    layout.collectionView.showsHorizontalScrollIndicator = NO;
    layout.collectionView.alwaysBounceVertical           = YES;
    
    return layout;
}

- (instancetype)init {
    return [super initWithCollectionViewLayout:[self layout]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildNewViewState];
    
}


/**
 设置最新界面
 */
- (void)buildNewViewState {
    
    self.collectionView.backgroundColor = [UIColor lavender];
    [self.collectionView registerClass:[MYNewCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MYNewCollectionViewCell class])];
    
    // 刷新
    MJRefreshNormalHeader *refHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewViewInfoDataIsMore:NO];
    }];
    // 加载
    MYRefreshBackFooter * refFooter = [MYRefreshBackFooter footerWithRefreshingBlock:^{
        [self loadNewViewInfoDataIsMore:YES];
    }];
    refHeader.stateLabel.hidden           = YES;
    refHeader.lastUpdatedTimeLabel.hidden = YES;
    refHeader.automaticallyChangeAlpha    = YES;
    
    refFooter.automaticallyHidden      = NO;
    refFooter.automaticallyChangeAlpha = YES;
    self.collectionView.mj_header = refHeader;
    self.collectionView.mj_footer = refFooter;
    
    if ([self.infoDataNew count] > 0) {
        [self.collectionView.mj_header beginRefreshing];
    } else {
        [self loadNewViewInfoDataIsMore:NO];
        [self netWork_Loading];
    }
}


/**
 加载数据 是否更多
 */
- (void)loadNewViewInfoDataIsMore:(BOOL)isMore {
    __weak typeof(self) weakSelf = self;
    if (!isMore) {
        self.currentPage = 1;
        [self.collectionView.mj_footer resetNoMoreData];
    }
    [MYNetwork getNewViewPlayerInfoWithPage:self.currentPage Success:^(id returnData) {
        MYNewPlayerInfoModel *result = [MYNewPlayerInfoModel mj_objectWithKeyValues:returnData];
        if (result.code == 100) {
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView.mj_footer endRefreshing];
            if (!isMore) {
                [weakSelf.infoDataNew removeAllObjects];
            }
            if ([result.data.list count] < 18) {
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                weakSelf.collectionView.mj_footer.alpha = 1.0f;
            } else {
                weakSelf.currentPage ++;
                weakSelf.collectionView.mj_footer.alpha = 0.f;
            }
            [weakSelf.infoDataNew addObjectsFromArray:result.data.list];
        } else {
            [weakSelf netWork_Failure];
        }
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView reloadEmptyDataSet];
    } failure:^(NSError *err) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf netWork_Failure];
    } showView:self.infoDataNew.count <= 0 ? nil : self.view];
}


#pragma mark ==============//UICollectionViewDelegate DataSource\\==============
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.infoDataNew count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MYNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MYNewCollectionViewCell class]) forIndexPath:indexPath];
    cell.infoModel = self.infoDataNew[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}






#pragma mark ==============//懒加载\\==============
- (NSMutableArray<MYNewPlayerInfoDataListModel *> *)infoDataNew {
    if (!_infoDataNew) {
        _infoDataNew = [NSMutableArray new];
    }
    return _infoDataNew;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
