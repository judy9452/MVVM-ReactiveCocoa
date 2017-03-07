//
//  UserDefaultControl.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/19.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "UserDefaultControl.h"

@implementation UserDefaultControl
static UserDefaultControl *_instance = nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (void)setCacheUserAddrModel:(UserAddressModel *)cacheUserAddrModel{
    if (!cacheUserAddrModel) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"cacheUserAddrModel"];
    }else{
        NSData   *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheUserAddrModel];
        if (cacheData) {
            [[NSUserDefaults standardUserDefaults]setObject:cacheData forKey:@"cacheUserAddrModel"];
        }
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
