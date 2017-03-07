//
//  ShopListCell.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 17/2/24.
//  Copyright © 2017年 juanmao. All rights reserved.
//

#import "ShopListCell.h"
#import "EDStarRating.h"
@interface ShopListCell()
    ///商铺logo
@property(nonatomic, strong)UIImageView       *iconImgView;
    ///商铺名称
@property(nonatomic, strong)UILabel           *shopNameLab;
    ///商家标签
@property(nonatomic, strong)UIView            *shopTagsView;
    ///商家星级
@property(nonatomic, strong)EDStarRating      *starRating;
    ///是否营业
@property(nonatomic, strong)UILabel           *shopStateLab;
    ///配送费等集合view
@property(nonatomic, strong)UILabel           *orderCostLab;
    ///优惠活动
@property(nonatomic, strong)UIView            *activitiesView;
    ///虚线分割
@property(nonatomic, strong)UIView            *dotLineView;
    ///分割线
@property(nonatomic, strong)UIView            *sepLineView;
@end

@implementation ShopListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.iconImgView = [[UIImageView alloc]init];
    self.iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImgView.layer.cornerRadius = 2;
    self.iconImgView.clipsToBounds = YES;
    [self.contentView addSubview:self.iconImgView];
    
    self.shopNameLab = [[UILabel alloc]init];
    self.shopNameLab.textColor = UICOLOR_RGB(56, 58, 62);
    self.shopNameLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shopNameLab];
    
    self.shopTagsView = [[UIView alloc]init];
    [self.contentView addSubview:self.shopTagsView];
    
    self.starRating = [[EDStarRating alloc]initWithFrame:CGRectZero];
    [self.starRating setDefaultProperties:@"small"];
    self.starRating.horizontalMargin = 0;
    [self.starRating setDisplayMode:EDStarRatingDisplayAccurate];
    [self.contentView addSubview:self.starRating];
    
    self.shopStateLab = [[UILabel alloc]init];
    self.shopStateLab.layer.cornerRadius = 6;
    self.shopStateLab.layer.masksToBounds = YES;
    self.shopStateLab.textColor = [UIColor whiteColor];
    self.shopStateLab.textAlignment = NSTextAlignmentCenter;
    self.shopStateLab.backgroundColor = UICOLOR_RGB(255, 214, 52);
    self.shopStateLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.shopStateLab];
    
    self.orderCostLab = [[UILabel alloc]init];
    self.orderCostLab.textAlignment = NSTextAlignmentLeft;
    self.orderCostLab.textColor = UICOLOR_RGB(90, 100, 110);
    self.orderCostLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.orderCostLab];
    
    self.activitiesView = [[UIView alloc]init];
    [self.contentView addSubview:self.activitiesView];
    
    self.dotLineView = [[UIView alloc]init];
    self.dotLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shop_list_line"]];
    [self.contentView addSubview:self.dotLineView];
    
    self.sepLineView = [[UIView alloc]init];
    self.sepLineView.backgroundColor = UICOLOR_RGB(230, 231, 232);
    [self.contentView addSubview:self.sepLineView];
    
}

- (void)setModel:(ShopSimpleModel *)model{
    _model = model;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.shopLogo]];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(50);
    }];
    
    _shopNameLab.text = model.shopName;
    [_shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right).offset(10);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(15);
        make.height.mas_equalTo(21);
    }];
    
    _starRating.rating = model.startLevel;
    [_starRating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLab.mas_left).offset(0);
        make.top.equalTo(_shopNameLab.mas_bottom).offset(-3);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(10);
    }];
    
    if (model.isOpen) {
        _shopStateLab.textColor = [UIColor blackColor];
        _shopStateLab.backgroundColor = UICOLOR_RGB(0xff, 0xd6, 0x34);
        _shopStateLab.text = @"营业中";
    }else{
        _shopStateLab.text = @"可预订";
        _shopStateLab.textColor = [UIColor whiteColor];
        _shopStateLab.backgroundColor = UICOLOR_RGB(0x43, 0xad, 0xff);
    }
    
    [_shopStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starRating.mas_right).offset(10);
        make.top.equalTo(_starRating.mas_top);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(14);
    }];
    
    NSString *minOrderTextStr = @"";
    for (NSString *str in model.shopCopyWriters) {
        minOrderTextStr = [minOrderTextStr stringByAppendingFormat:@"%@|",str];
    }
    
    if (minOrderTextStr.length > 0) {
        minOrderTextStr = [minOrderTextStr substringToIndex:minOrderTextStr.length-1];
    }
    
    self.orderCostLab.text = minOrderTextStr;
    [_orderCostLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLab.mas_left).offset(0);
        make.top.equalTo(_starRating.mas_bottom).offset(0);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(25);
    }];
    
    [_dotLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLab.mas_left).offset(0);
        make.top.equalTo(_orderCostLab.mas_bottom).offset(3);
        make.right.equalTo(_orderCostLab.mas_right).offset(0);
        make.height.mas_equalTo(1.5);
    }];
    
    [_activitiesView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_activitiesView addSubview:[self createActivityView:model.activities]];
    [_activitiesView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopNameLab.mas_left).offset(-25);
        make.top.equalTo(_dotLineView.mas_bottom).offset(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20*model.activities.count);
    }];
    
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(_activitiesView.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(0.5);
    }];
    
    [self setupAutoHeightWithBottomView:_sepLineView bottomMargin:0];
}

- (UIView *)createActivityView:(NSArray *)activityArr{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectZero];
    for(int i  = 0;i < activityArr.count; i++){
        ActivitiesModel *aModel = [activityArr objectAtIndexSafe:i];
        UIView *aView = [[[NSBundle mainBundle]loadNibNamed:@"activityItem" owner:self options:nil]lastObject];
        aView.backgroundColor = [UIColor clearColor];
        UIImageView *aImg = (UIImageView *)[aView viewWithTag:101];
        [aImg sd_setImageWithURL:[NSURL URLWithString:aModel.icon]];
        
        UILabel *aLab = (UILabel *)[aView viewWithTag:102];
        aLab.text = aModel.desc;
        
        [bgView addSubview:aView];
        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(20*i);
            make.height.mas_equalTo(20);
        }];
    }
    return bgView;
}
@end
