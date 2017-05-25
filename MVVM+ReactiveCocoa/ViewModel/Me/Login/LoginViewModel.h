//
//  LoginViewModel.h
//  MVVM+ReactiveCocoa
//
//  Created by chenyue on 2017/5/25.
//  Copyright © 2017年 juanmao. All rights reserved.
//

#import "BaseViewModel.h"

@interface Account : NSObject
@property(nonatomic, strong)NSString      *userName;
@property(nonatomic, strong)NSString      *password;
@end

@interface LoginViewModel : BaseViewModel
@property(nonatomic, strong)RACSignal     *enableLoginSignal;
@property(nonatomic, strong)RACCommand     *loginCommand;
@property(nonatomic, strong)Account                 *account;
@end
