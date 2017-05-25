//
//  MeViewController.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/28.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
@interface MeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    
    @weakify(self)
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
}


@end
