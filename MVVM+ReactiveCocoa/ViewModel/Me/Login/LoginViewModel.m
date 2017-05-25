//
//  LoginViewModel.m
//  MVVM+ReactiveCocoa
//
//  Created by chenyue on 2017/5/25.
//  Copyright © 2017年 juanmao. All rights reserved.
//

#import "LoginViewModel.h"
#import "DES3Util.h"
@implementation Account
- (instancetype)init{
    if (self == [super init]) {
    }
    return self;
}
@end

@interface LoginViewModel()
@end

@implementation LoginViewModel

- (Account *)account{
    if (_account == nil) {
        _account = [[Account alloc]init];
    }
    return _account;
}

- (instancetype)init{
    if (self == [super init]) {
        [self initialBind];
    }
    return self;
}

- (void)initialBind{
    self.enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, userName),RACObserve(self.account, password)] reduce:^id(NSString *userName,NSString *pwd){
        return @(userName.length&&pwd.length);
    }];
    
    
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSString *encryptPassword = [DES3Util encrypt:self.account.password];
            //"cityId":1,"source":3,"password":"QgMeUlxPI8E=","userX":118.8067112198866,"deviceType":"3","version":"5.2.3","userY":32.03299303289314,"name":"18652937407","userToken":""
            NSDictionary *params = @{@"cityId":@(1),
                                     @"source":@(3),
                                     @"password":encryptPassword,
                                     @"userX":@(118.8067112198866),
                                     @"deviceType":@"3",
                                     @"version":@"5.2.3",
                                     @"userY":@(32.03299303289314),
                                     @"name":self.account.userName,
                                     @"userToken":@""};
//            NSMutableDictionary *conbParas = [[BaseRequest shareInstance]defaultPars:@{@"name": self.account.userName, @"password" : encryptPassword, @"version" : @"5.2.3"} isNeedLocation:YES];
            [[BaseRequest shareInstance]POST:@"user/login" params:params completeBlock:^(BOOL isSuccess, NSDictionary *dict, NSError *err) {
                if (isSuccess && !err) {
                    [subscriber sendNext:dict];
                    [subscriber sendCompleted];
                }else{
                    [subscriber sendError:err];
                }
                
            }];
            return [RACDisposable disposableWithBlock:^{
                //取消网络请求
            }];
            
        }];
    }];
}
@end
