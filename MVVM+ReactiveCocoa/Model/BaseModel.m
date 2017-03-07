//
//  BaseModel.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/15.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "BaseModel.h"

@implementation NSObject (model)
- (id)safeBindValue:(NSString *)key{
    NSLog(@"错误对象调用 safeBindValue 调用路径 %@",[NSThread callStackSymbols]);
    return nil;
}


- (NSString *)safeBindStringValue:(NSString *)key{
    NSLog(@"错误对象调用 safeBindStringValue 调用路径 %@",[NSThread callStackSymbols]);
    return nil;
}
@end

@implementation NSDictionary (model)
- (id)safeBindValue:(NSString *)key{
    id result = nil;
    if ([self.allKeys containsObject:key]) {
        result = [self objectForKey:key];
        result = [result isKindOfClass:[NSNull class]]?nil:result;
    }
    return result;
}
- (NSString *)safeBindStringValue:(NSString *)key{
    id result = [self safeBindValue:key];
    if (result) {
        return [NSString stringWithFormat:@"%@",result];
    }
    return nil;
}
@end


@implementation NSArray (model)
- (id)objectAtIndexSafe:(NSUInteger)index{
    if ([self count]>index) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end




@implementation BaseModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if ([dict isKindOfClass:[NSNull class]]||
        ![dict isKindOfClass:[NSDictionary class]]||
        ![dict count]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSArray *)makeModelByDictArr:(NSArray *)arr{
    if (arr && [arr isKindOfClass:[NSArray class]] && [arr count]) {
        NSMutableArray *modelArr = [NSMutableArray array];
        for (int i = 0; i < [arr count]; i++) {
            id model = [[self alloc]initWithDict:[arr objectAtIndexSafe:i]];
            if (model) {
                [modelArr addObject:model];
            }
        }
        return modelArr;
    }
    return nil;
}
@end
