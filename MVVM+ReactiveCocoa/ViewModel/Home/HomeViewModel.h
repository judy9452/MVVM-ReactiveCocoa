//
//  HomeViewModel.h
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/12/2.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "BaseViewModel.h"
#import "HomeModel.h"

@interface HomeViewModel : BaseViewModel
    ///网络请求信号量
@property(nonatomic, strong)RACCommand               *requestCommand;



@end
