//
//  NSData+Addition.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/1.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "NSData+Addition.h"
#import "DES3Util.h"

@implementation NSData (Addition)
- (id)responseJSON{
    if (self == nil) return nil;
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:self options:0 error:&error];
    if (error) NSLog(@"JSON Parsing Error: %@",error);
    return returnValue;
}

- (id)responseJSONDES3{
    if (self == nil) return nil;
    NSError *error = nil;
    NSString *decryptStr = [DES3Util decrypt:[[NSString alloc]initWithData:self encoding:NSUTF8StringEncoding]];
    id returnValue = [NSJSONSerialization JSONObjectWithData:[decryptStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (error) NSLog(@"JSON Parsing Error: %@",error);
    return returnValue;

    
}
@end
