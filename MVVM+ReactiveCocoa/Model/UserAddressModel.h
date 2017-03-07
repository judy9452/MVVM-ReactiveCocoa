//
//  UserAddressModel.h
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/19.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "BaseModel.h"

@interface UserAddressModel : BaseModel
@property(nonatomic, assign)int          addrId;

@property(nonatomic, strong)NSString     *preAddr;

@property(nonatomic, strong)NSString     *subAddr;

@property(nonatomic, assign)int           isDefault;
    ///经度
@property(nonatomic, assign)long          lonPoint;
    ///纬度
@property(nonatomic, assign)long          latPoint;

@property(nonatomic, strong)NSString      *receiverName;

@property(nonatomic, strong)NSString      *receiverMobile;

@property(nonatomic, strong)NSString      *detailAddr;

@property(nonatomic, assign)int            cityId;

@property(nonatomic, strong)NSString       *city;
@end
