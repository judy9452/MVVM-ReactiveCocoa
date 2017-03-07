//
//  UserDefaultControl.h
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/19.
//  Copyright © 2016年 juanmao. All rights reserved.
//  所有NSUserDefault的缓存值入口

#import <Foundation/Foundation.h>
#import "UserAddressModel.h"

@interface UserDefaultControl : NSObject

+ (instancetype)shareInstance;
    ///读取与写入用户设置的当前收货地址
@property(nonatomic, strong)UserAddressModel            *cacheUserAddrModel;
@end
