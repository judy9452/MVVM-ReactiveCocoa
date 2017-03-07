//
//  NSDictionary+Addition.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/7.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)

- (NSString *)jsonEncodedKeyValueString{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    
    if(error){
        NSLog(@"json parsing error:%@",error);
    }
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
