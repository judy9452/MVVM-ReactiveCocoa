//
//  HomeModel.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/28.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "HomeModel.h"

@implementation CategoriesModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.cateid = [[dict safeBindStringValue:@"id"]integerValue];
        self.icon = [dict safeBindStringValue:@"icon"];
        self.name = [dict safeBindStringValue:@"name"];
    }
    return self;
}
@end

@implementation BannerListModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.cityId = [[dict safeBindStringValue:@"cityId"]integerValue];
        self.imgUrl = [dict safeBindStringValue:@"imgUrl"];
        self.shopId = [[dict safeBindStringValue:@"shopId"]integerValue];
        self.bannerid = [[dict safeBindStringValue:@"id"]integerValue];
        self.productId = [[dict safeBindStringValue:@"productId"]integerValue];
        self.title = [dict safeBindStringValue:@"title"];
        self.url = [dict safeBindStringValue:@"url"];
        self.subTitle = [dict safeBindStringValue:@"subTitle"];
        self.goneType = [[dict safeBindStringValue:@"goneType"]integerValue];
    }
    return self;
}

@end

@implementation ModulesModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.gotoUrl = [dict safeBindStringValue:@"gotoUrl"];
        self.modulesid = [[dict safeBindStringValue:@"id"]integerValue];
        self.content = [dict safeBindStringValue:@"content"];
        self.icon = [dict safeBindStringValue:@"icon"];
        self.name = [dict safeBindStringValue:@"name"];
        self.snapUpLocation = [[dict safeBindStringValue:@"snapUpLocation"]integerValue];
    }
    return self;
}

@end

@implementation ShopSimpleModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.deliveryBeginMoney = [[dict safeBindStringValue:@"deliveryBeginMone"]integerValue];
        self.shopTags = [ShopTagModel makeModelByDictArr:[dict safeBindValue:@"shopTagVos"]];
        self.activities = [ActivitiesModel makeModelByDictArr:[dict safeBindValue:@"activities"]];
        self.startLevel = [[dict safeBindStringValue:@"avgAppPoint"]floatValue];
        self.shopName = [dict safeBindStringValue:@"shopName"];
        self.shopId = [[dict safeBindStringValue:@"shopId"]integerValue];
        self.shopLogo = [dict safeBindStringValue:@"shopLogo"];
        self.isOpen = [[dict safeBindStringValue:@"isInBusiness"]integerValue];
        self.shopCopyWriters    = [dict safeBindValue:@"shopCopyWriters"];
    }
    return self;
}

@end

@implementation ShopTagModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
//        self.deliveryBeginMoney = [[dict safeBindStringValue:@"deliveryBeginMone"]integerValue];
//        self.deliveryFee = [[dict safeBindStringValue:@"deliveryFee"]integerValue];
//        self.shopTags = [ShopTagModel makeModelByDictArr:[dict safeBindValue:@"shopTagVos"]];
//        self.activities = [ActivitiesModel makeModelByDictArr:[dict safeBindValue:@"activities"]];
//        self.salesInWeek = [[dict safeBindStringValue:@"salesInWeek"]integerValue];
//        self.avgPoint = [[dict safeBindStringValue:@"avgAppPoint"]floatValue];
//        self.shopName = [dict safeBindStringValue:@"shopName"];
//        self.deliveryTime = [[dict safeBindStringValue:@"deliveryTime"]integerValue];
//        self.shopId = [[dict safeBindStringValue:@"shopId"]integerValue];
//        self.shopLogo = [dict safeBindStringValue:@"shopLogo"];
//        self.deliveryMethodType = [[dict safeBindStringValue:@"deliveryMethodType"]integerValue];
    }
    return self;
}
@end


@implementation ActivitiesModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.activityId = [[dict safeBindStringValue:@"id"]integerValue];
        self.type = [[dict safeBindStringValue:@"type"]integerValue];
        self.desc = [dict safeBindStringValue:@"desc"];
        self.icon = [dict safeBindStringValue:@"icon"];
    }
    return self;
}

@end

@implementation HomeModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.categories = [CategoriesModel makeModelByDictArr:[dict safeBindValue:@"categories"]];
        self.bannerList = [BannerListModel makeModelByDictArr:[dict safeBindValue:@"bannerList"]];
        self.topShopList = [ShopSimpleModel makeModelByDictArr:[dict safeBindValue:@"topShopList"]];
        self.modules = [ModulesModel makeModelByDictArr:[dict safeBindValue:@"modules"]];

    }
        return self;
}

@end
