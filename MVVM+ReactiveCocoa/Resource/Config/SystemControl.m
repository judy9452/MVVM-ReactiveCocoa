//
//  SystemControl.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/21.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "SystemControl.h"
@interface SystemControl()
@end

@implementation SystemControl
static SystemControl *_instance = nil;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

@end
