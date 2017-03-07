//
//  UserAddressModel.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/19.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "UserAddressModel.h"

@implementation UserAddressModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super initWithDict:dict];
    if (self) {
        self.addrId            = [[dict safeBindStringValue:@"id"]intValue];
        self.preAddr           = [dict safeBindStringValue:@"preAddr"];
        self.subAddr           = [dict safeBindStringValue:@"subAddr"];
        self.isDefault         = [[dict safeBindStringValue:@"isDefault"]intValue];
        self.lonPoint          = [[dict safeBindStringValue:@"lonPoint"]longLongValue];
        
    }
    return self;
}
@end
