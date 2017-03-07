//
//  BaseViewController.h
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/24.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

@interface BaseViewController : UIViewController
@property(nonatomic,strong,readonly)BaseViewModel       *viewModel;


- (void)setNavigationTitleImage:(NSString *)imageName;
- (void)setNavigationLeft:(NSString *)imageName title:(NSString *)title sel:(SEL)sel;
- (void)setNavigationRight:(NSString *)imageName title:(NSString *)title sel:(SEL)sel;
- (void)setStatusBarStyle:(UIStatusBarStyle)style;

- (void)doBack:(id)sender;

@end
