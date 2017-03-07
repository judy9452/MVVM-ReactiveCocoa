//
//  MainTabBarController.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/28.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()
    //storyBoard名称
@property (nonatomic, strong)NSArray      *storyName;
    //选中时的图片
@property (nonatomic, strong)NSArray      *selectedImg;
    //未选中的图片
@property (nonatomic, strong)NSArray      *normalImg;

@property (nonatomic, strong)NSArray      *tabBarTitle;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storyName = @[@"Home",@"Order",@"Me"];
    self.selectedImg = @[@"icon_home_on",@"icon_list_on",@"icon_me_on"];
    self.normalImg = @[@"icon_home_off",@"icon_list_off",@"icon_me_off"];
    self.tabBarTitle = @[@"首页",@"订单",@"我的"];
    
    [self setupViewControllers];
    
}

- (void)setupViewControllers{
    NSMutableArray *tabBarItemsAttr = [NSMutableArray array];
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    for (int i =0; i<self.storyName.count; i++) {
        NSDictionary *dict = @{
                               CYLTabBarItemImage:[self.normalImg objectAtIndexSafe:i],
                               CYLTabBarItemSelectedImage:[self.selectedImg objectAtIndexSafe:i],
                               CYLTabBarItemTitle:[self.tabBarTitle objectAtIndexSafe:i]
                               };
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[self.storyName objectAtIndexSafe:i] bundle:nil];
        UIViewController *vc  = [storyboard instantiateInitialViewController];
        
        [tabBarItemsAttr addObject:dict];
        [viewControllers addObject:vc];
    }
    
    self.tabBarItemsAttributes = tabBarItemsAttr;
    self.viewControllers = viewControllers;
}
@end
