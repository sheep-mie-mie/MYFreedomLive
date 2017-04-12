//
//  MYHotTableViewCell.m
//  MYFreedomLive
//
//  Created by ifly on 2017/3/27.
//  Copyright © 2017年 Meiyang. All rights reserved.
//

#import "MYHotTableViewCell.h"

@interface MYHotTableViewCell ()

/**
 直播
 */
@property (nonatomic, strong) UIImageView *titleImageView;
/**
 背景视图
 */
@property (nonatomic, strong) UIImageView *backgroundImageView;
/**
 头像
 */
@property (nonatomic, strong) UIImageView *iconImageView;
/**
 昵称
 */
@property (nonatomic, strong) UILabel *userNameLabel;
/**
 星级
 */
@property (nonatomic, strong) UIImageView *starImageView;
/**
 定位地址
 */
@property (nonatomic, strong) UIButton *locationBtn;
/**
 观看人数
 */
@property (nonatomic, strong) UILabel *watchersLabel;
/**
 简介
 */
@property (nonatomic, strong) UILabel *describeLabel;

@end


@implementation MYHotTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self layoutHotCellView];
    }
    return self;
}

/**
 设置界面布局
 */
- (void)layoutHotCellView {
    __weak typeof(self) weakSelf = self;
    //背景视图
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(weakSelf.mas_width);
    }];
    //直播
    self.titleImageView = [UIImageView new];
    self.titleImageView.image = ImageNamed(@"home_live_43x22");
    [self.backgroundImageView addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(2.f));
        make.width.equalTo(@(36.f));
        make.height.equalTo(@(18.f));
    }];
    //星级
    self.starImageView = [UIImageView new];
    [self.backgroundImageView addSubview:self.starImageView];
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.backgroundImageView.mas_right).offset(-2.f);
        make.top.equalTo(@(2.f));
        make.width.equalTo(@(36.f));
        make.height.equalTo(@(18.f));
    }];
    //头像
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(8.f));
        make.bottom.equalTo(weakSelf.backgroundImageView.mas_bottom).offset(-8.f);
        make.width.height.equalTo(@(54.f));
    }];
    //昵称
    [self.backgroundImageView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImageView.mas_right).offset(4.5f);
        make.top.equalTo(weakSelf.iconImageView.mas_top).offset(4.f);
        make.width.equalTo(@(200.f * AutoSizeScaleX));
        make.height.equalTo(@(20.f));
    }];
    //观看人数
    [self.backgroundImageView addSubview:self.watchersLabel];
    [self.watchersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.userNameLabel.mas_left);
        make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(5);
        make.height.equalTo(weakSelf.userNameLabel.mas_height);
        make.width.equalTo(@(100.f * AutoSizeScaleX));
    }];
    //定位
    [self.backgroundImageView addSubview:self.locationBtn];
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakSelf.userNameLabel);
        make.right.equalTo(weakSelf.backgroundImageView.mas_right).offset(2);
        make.width.equalTo(@(100.f * AutoSizeScaleX));
    }];
    //简介
    [self.backgroundImageView addSubview:self.describeLabel];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.watchersLabel.mas_right).offset(5);
        make.top.height.equalTo(weakSelf.watchersLabel);
        make.right.equalTo(weakSelf.locationBtn.mas_right);
    }];
}

- (void)setInfoModel:(MYHotPlayerInfoDataListModel *)infoModel {
    _infoModel = infoModel;
    //背景视图
    self.backgroundImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:infoModel.bigpic]]];
    //星级
    self.starImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19",infoModel.starlevel]];
    //头像
    self.iconImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:infoModel.smallpic]]];
    //昵称
    self.userNameLabel.text  = infoModel.myname;
    //定位
    [self.locationBtn setTitle:infoModel.gps forState:UIControlStateNormal];
    //人数
    self.watchersLabel.text = [NSString stringWithFormat:@"%ld人",infoModel.allnum];
    //简介
    self.describeLabel.text = infoModel.signatures;
}



#pragma mark ==============//懒加载\\==============
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 54.f / 2;
        [self.backgroundImageView addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UIButton *)locationBtn {
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setImage:ImageNamed(@"location_white_8x9_") forState:UIControlStateNormal];
        [_locationBtn setTitle:@"在地球?" forState:UIControlStateNormal];
        [_locationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_locationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        _locationBtn.titleLabel.font = [UIFont my_SystemFontOfSize:14.f];
    }
    return _locationBtn;
}
- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [UILabel new];
        _userNameLabel.font = [UIFont my_FontWithName:@"Helvetica-BoldOblique" size:14.f];
        _userNameLabel.textColor = [UIColor whiteColor];
    }
    return _userNameLabel;
}
- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [UILabel new];
        _describeLabel.font = [UIFont my_SystemFontOfSize:14.f];
        _describeLabel.textColor = [UIColor whiteColor];
        _describeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _describeLabel;
}
- (UILabel *)watchersLabel {
    if (!_watchersLabel) {
        _watchersLabel = [UILabel new];
        _watchersLabel.textColor = [UIColor whiteColor];
    }
    return _watchersLabel;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
