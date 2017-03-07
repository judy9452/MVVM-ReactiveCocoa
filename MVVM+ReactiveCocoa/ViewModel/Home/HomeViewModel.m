//
//  HomeViewModel.m
//  MVVM+ReactiveCocoak
//
//  Created by juanmao on 16/12/2.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel
- (instancetype)init{
    if (self = [super init]) {
        [self requestData];
    }
    return self;
}

- (void)requestData{
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                ///每当有订阅者订阅信号，就会调用block。
            [subscriber sendNext:[self getData]];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                ///当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
                NSLog(@"信号被销毁");
            }];
        }];
        return signal;
    }];
}

- (HomeModel *)getData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"HomePage" ofType:@"json"];
    NSString *jsonContent = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    HomeModel *model = nil;
    if(jsonContent != nil){
        NSData *jsonData = [jsonContent dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        NSDictionary *dict = [dic safeBindValue:@"response"];
        model = [[HomeModel alloc]initWithDict:dict];
        if (err) {
            NSLog(@"json解析失败：%@",err);
        }
    }
    return model;
}

@end
