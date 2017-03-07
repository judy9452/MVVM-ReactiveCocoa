//
//  BaseViewController.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/24.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.navVC = self.navigationController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBarImage];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [self setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)setNavigationTitleImage:(NSString *)imageName{
    UIImage *image = UIImageByName(imageName);
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    self.navigationItem.titleView = imageView;
}

- (void)setNavigationLeft:(NSString *)imageName title:(NSString *)title sel:(SEL)sel{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[self customButton:imageName title:title selector:sel]];
    self.navigationItem.leftBarButtonItem = item;
}


- (void)setNavigationRight:(NSString *)imageName title:(NSString *)title sel:(SEL)sel{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[self customButton:imageName title:title selector:sel]];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)doBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavBarImage{
    UIImage *image = UIImageByName([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0?@"NavigationBar64.png":@"NavigationBar44.png");
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSDictionary *attribute = @{
                                NSForegroundColorAttributeName:[UIColor blackColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:18]
                                };
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];
}

- (UIButton *)customButton:(NSString *)imageName title:(NSString *)title selector:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:UIImageByName(imageName) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)style
{
    [[UIApplication sharedApplication]setStatusBarStyle:style];
}

@end
