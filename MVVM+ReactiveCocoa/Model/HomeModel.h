//
//  HomeModel.h
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/28.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "BaseModel.h"
@interface CategoriesModel :BaseModel
    ///分类id
@property (nonatomic , assign) NSInteger             cateid;
    ///分类icon
@property (nonatomic , copy) NSString              * icon;
    ///分类名称
@property (nonatomic , copy) NSString              * name;

@end

@interface BannerListModel :BaseModel
    ///城市id
@property (nonatomic , assign) NSInteger             cityId;
    ///图片链接
@property (nonatomic , copy) NSString              * imgUrl;
    ///商铺id
@property (nonatomic , assign) NSInteger             shopId;
    ///banner id
@property (nonatomic , assign) NSInteger             bannerid;
    ///商品id
@property (nonatomic , assign) NSInteger             productId;
    ///标题
@property (nonatomic , copy) NSString              * title;
    ///跳转URL
@property (nonatomic , copy) NSString              * url;
    ///子标题
@property (nonatomic , copy) NSString              * subTitle;
    ///跳转类型
@property (nonatomic , assign) NSInteger             goneType;

@end

@interface ModulesModel :BaseModel
    ///跳转url
@property (nonatomic , copy) NSString              * gotoUrl;
    ///导购id
@property (nonatomic , assign) NSInteger             modulesid;
    ///导购内容
@property (nonatomic , copy) NSString              * content;
    ///导购icon
@property (nonatomic , copy) NSString              * icon;
    ///导购名称
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger             snapUpLocation;

@end

@interface ShopTagModel:BaseModel
    ///标签id
@property(nonatomic, assign)NSInteger             tagId;
    ///标签icon
@property(nonatomic, copy)NSString                *imgUrl;
@end

@interface ActivitiesModel : BaseModel
@property(nonatomic , assign)NSInteger              typeCode;
    ///活动id
@property(nonatomic , assign)NSInteger              activityId;
@property(nonatomic , assign)NSInteger              maxDiscount;
@property(nonatomic , assign)NSInteger              typeCodeValue;
@property(nonatomic , assign)NSInteger              initAmount;
    ///活动类型
@property(nonatomic , assign)NSInteger              type;
    ///活动描述
@property(nonatomic , copy)NSString                 *desc;
    ///活动icon
@property(nonatomic , copy)NSString                 *icon;
@end

@interface ShopSimpleModel : BaseModel
    ///起送价
@property(nonatomic , assign)NSInteger          deliveryBeginMoney;
    ///商铺标签
@property(nonatomic , strong)NSArray<ShopTagModel *> *shopTags;
    ///商家活动
@property(nonatomic , strong)NSArray<ActivitiesModel *>            *activities;
    ///星级
@property(nonatomic , assign)CGFloat            startLevel;
    ///商铺名称
@property(nonatomic , copy)NSString             *shopName;
    ///商铺id
@property(nonatomic , assign)NSInteger          shopId;
    ///商铺logo
@property(nonatomic , copy)NSString             *shopLogo;
    ///是否正常营业
@property(nonatomic , assign)NSInteger          isOpen;
    ///销量,起送价，送达时间的集合
@property(nonatomic , strong)NSArray            *shopCopyWriters;

@end

@interface HomeModel : BaseModel
    ///分类
@property (nonatomic , strong) NSArray<CategoriesModel *>              * categories;
    ///有无抢购
@property (nonatomic , assign) NSInteger                               hasSnapUp;
    ///轮播图
@property (nonatomic , strong) NSArray<BannerListModel *>              * bannerList;
    ///导购
@property (nonatomic , strong) NSArray<ModulesModel *>                 * modules;
    ///商家list
@property (nonatomic , strong) NSArray<ShopSimpleModel *>             * topShopList;
@end
