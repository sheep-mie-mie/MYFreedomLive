//
//  MYNewCollectionViewCell.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/28.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYNewCollectionViewCell.h"

@interface MYNewCollectionViewCell ()

/**
 背景视图
 */
@property (nonatomic, strong) UIImageView *imvBackNew;
/**
 顶部视图
 */
@property (nonatomic, strong) UIView      *topViewNew;
/**
 底部视图
 */
@property (nonatomic, strong) UIView      *bottomViewNew;
/**
 定位
 */
@property (nonatomic, strong) UIButton    *locationBtnNew;
/**
 new视图
 */
@property (nonatomic, strong) UIImageView *imvNew;
/**
 昵称
 */
@property (nonatomic, strong) UILabel     *nicknameLabelNew;
/**
 观看人数
 */
@property (nonatomic, strong) UIButton    *allnumBtnNew;

@end


@implementation MYNewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self buildNewCellViewState];
    }
    return self;
}


/**
 设置页面布局
 */
- (void)buildNewCellViewState {
    __weak typeof(self) weakSelf = self;
    // 背景
    [self.imvBackNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    // 顶部
    [self.imvBackNew addSubview:self.topViewNew];
    [self.topViewNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(weakSelf.imvBackNew);
        make.height.equalTo(@(20.f));
    }];
    // 定位
    //self.locationBtnNew.frame = CGRectMake(0, 0, 40, 20);
    [self.topViewNew addSubview:self.locationBtnNew];
    [self.locationBtnNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.height.equalTo(weakSelf.topViewNew);
        make.width.equalTo(weakSelf.topViewNew.mas_width).offset(-60);
    }];
    // newImage
    [self.topViewNew addSubview:self.imvNew];
    [self.imvNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topViewNew.mas_top).offset(3);
        make.height.equalTo(weakSelf.topViewNew.mas_height).offset(-6);
        make.right.equalTo(weakSelf.topViewNew.mas_left).offset(-20);
        make.width.equalTo(@(24.f));
    }];
    // 底部
    [self.imvBackNew addSubview:self.bottomViewNew];
    [self.bottomViewNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(weakSelf.topViewNew);
        make.bottom.equalTo(weakSelf.imvBackNew);
    }];
    // 昵称
    [self.bottomViewNew addSubview:self.nicknameLabelNew];
    [self.nicknameLabelNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.height.equalTo(weakSelf.bottomViewNew);
        make.width.equalTo(weakSelf.bottomViewNew.mas_width).offset(-60);
    }];
    // 观看人数
    [self.bottomViewNew addSubview:self.allnumBtnNew];
    [self.allnumBtnNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.right.equalTo(weakSelf.bottomViewNew);
        make.width.equalTo(@(60.f));
    }];
}

- (void)setInfoModel:(MYNewPlayerInfoDataListModel *)infoModel {
    _infoModel = infoModel;
    
    // 背景视图
    self.imvBackNew.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:infoModel.photo]]];
    // 定位
    if (infoModel.position.length <= 0) {
        [self.locationBtnNew setTitle:@"在喵星" forState:UIControlStateNormal];
    } else {
        [self.locationBtnNew setTitle:infoModel.position forState:UIControlStateNormal];
    }
    // newImage
    if (infoModel.starlevel != 0) {
        self.imvNew.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19",infoModel.starlevel]];
    } else {
        self.imvNew.image = ImageNamed(@"flag_new_33x17_");
    }
    // 昵称
    self.nicknameLabelNew.text = infoModel.nickname;
    // 观看人数
    [self.allnumBtnNew setTitle:[NSString stringWithFormat:@"%ld",infoModel.allnum ] forState:UIControlStateNormal];
}




#pragma mark ==============//懒加载\\==============
- (UIImageView *)imvBackNew {
    if (!_imvBackNew) {
        _imvBackNew = [UIImageView new];
        _imvBackNew.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imvBackNew];
    }
    return _imvBackNew;
}

- (UIView *)topViewNew {
    if (!_topViewNew) {
        _topViewNew = [UIView new];
        _topViewNew.backgroundColor = SXRGBAColor(64.f, 64.f, 64.f, 0.2f);
    }
    return _topViewNew;
}

- (UIView *)bottomViewNew {
    if (!_bottomViewNew) {
        _bottomViewNew = [UIView new];
        _bottomViewNew.backgroundColor = SXRGBAColor(64.f, 64.f, 64.f, 0.2f);
    }
    return _bottomViewNew;
}

- (UIButton *)locationBtnNew {
    if (!_locationBtnNew) {
        _locationBtnNew = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtnNew setImage:ImageNamed(@"location_white_8x9_") forState:UIControlStateNormal];
        //_locationBtnNew.backgroundColor = [UIColor redColor];
        [_locationBtnNew setTitle:@"在地球?" forState:UIControlStateNormal];
        [_locationBtnNew setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_locationBtnNew setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_locationBtnNew setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        _locationBtnNew.titleLabel.font = [UIFont my_SystemFontOfSize:14];
    }
    return _locationBtnNew;
}

- (UIImageView *)imvNew {
    if (!_imvNew) {
        _imvNew = [UIImageView new];
    }
    return _imvNew;
}

- (UILabel *)nicknameLabelNew {
    if (!_nicknameLabelNew) {
        _nicknameLabelNew = [UILabel new];
        _nicknameLabelNew.font = [UIFont my_FontWithName:@"Helvetica-BoldOblique" size:14.f];
        _nicknameLabelNew.textColor = [UIColor whiteColor];
    }
    return _nicknameLabelNew;
}

- (UIButton *)allnumBtnNew {
    if (!_allnumBtnNew) {
        _allnumBtnNew = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allnumBtnNew setImage:ImageNamed(@"allnum_white_8x8") forState:UIControlStateNormal];
        [_allnumBtnNew setTitle:@"12万" forState:UIControlStateNormal];
        [_allnumBtnNew setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_allnumBtnNew setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_allnumBtnNew setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        _allnumBtnNew.titleLabel.font = [UIFont my_SystemFontOfSize:12.f];
    }
    return _allnumBtnNew;
}

@end
