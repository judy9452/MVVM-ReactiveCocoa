//
//  BaseModel.h
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/15.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (model)
- (id)safeBindValue:(NSString *)key;
- (NSString *)safeBindStringValue:(NSString *)key;
@end

@interface NSDictionary (model)
- (id)safeBindValue:(NSString *)key;
- (NSString *)safeBindStringValue:(NSString *)key;
@end


    ///防止数组越界
@interface NSArray (model)
- (id)objectAtIndexSafe:(NSUInteger)index;
@end


@interface BaseModel : NSObject
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSArray *)makeModelByDictArr:(NSArray *)arr;
@end
