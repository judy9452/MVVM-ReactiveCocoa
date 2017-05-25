//
//  LoginViewController.m
//  MVVM+ReactiveCocoa
//
//  Created by chenyue on 2017/5/25.
//  Copyright © 2017年 juanmao. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
@interface LoginViewController ()
@property(nonatomic, strong)LoginViewModel     *loginViewModel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self bindViewModel];
}

- (LoginViewModel *)loginViewModel{
    if (_loginViewModel == nil) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}

- (void)bindViewModel{
    RAC(self.loginViewModel.account,userName) = self.userNameTxt.rac_textSignal;
    RAC(self.loginViewModel.account,password) = self.passwordTxt.rac_textSignal;
    
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;

    @weakify(self)
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"btn click");
        @strongify(self)
        [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }error:^(NSError *error) {
            NSLog(@"%@",error);
        } completed:^{
            NSLog(@"完成");
        }];
        [self.loginViewModel.loginCommand execute:nil];
    }];
}


@end
