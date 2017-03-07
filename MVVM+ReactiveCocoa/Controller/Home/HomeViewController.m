
//
//  HomeViewController.m
//  MVVM+ReactiveCocoa
//
//  Created by juanmao on 16/11/28.
//  Copyright © 2016年 juanmao. All rights reserved.
//

#import "HomeViewController.h"
#import "CartViewController.h"
#import "HomeViewModel.h"
#import "HomeModel.h"
#import "SDCycleScrollView.h"
#import "ShopListCell.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic, strong)UITableView      *tableView;
@property(nonatomic, strong)HomeModel         *model;
@property(nonatomic, strong)HomeViewModel     *viewmodel;
    //轮播控件
@property(nonatomic, strong)SDCycleScrollView *cycleScrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self setNavigationRight:@"cart_nav" title:nil sel:@selector(goCart)];
    [self getDataFromviewModel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];

}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopSimpleModel *model = [self.model.topShopList objectAtIndexSafe:indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ShopListCell class] contentViewWidth:SCREEN_WIDTH];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.topShopList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShopListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([self.model.topShopList count] > indexPath.row) {
        cell.model = [self.model.topShopList objectAtIndexSafe:indexPath.row];
    }
    
    return cell;
    
}

- (void)getDataFromviewModel{
        ///执行命令
    RACSignal *signal = [self.viewmodel.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        ///每当有信号发出数据，就会调用block
        self.model = x;
        [self makeHeaderView];
        [self.tableView reloadData];
    }];
}

- (HomeViewModel *)viewModel{
    if (!_viewmodel) {
        _viewmodel = [[HomeViewModel alloc]init];
    }
    return _viewmodel;
}

- (void)makeHeaderView{
    CGFloat totalHeight = 0.0f;
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = UICOLOR_RGB(235, 235, 235);
    self.tableView.tableHeaderView = headerView;

    UIView *cateView = [self makeCategoryView];
    [headerView addSubview:cateView];
    [cateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(85*2);
    }];
    totalHeight += 85*2;
    
    UIView *taskPointView = [self makeTaskAndPointView];
    [headerView addSubview:taskPointView];
    [taskPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(cateView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(55);
    }];
    
    totalHeight += 65;
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    NSMutableArray *bannerImgUrl = [NSMutableArray array];
    for (BannerListModel *bannerModel in self.model.bannerList) {
        if (bannerModel.imgUrl.length>0) {
            [bannerImgUrl addObject:bannerModel.imgUrl];
        }
    }
    self.cycleScrollView.imageURLStringsGroup = bannerImgUrl;
    [headerView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(taskPointView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(74);
    }];
    totalHeight+=84;
    
    UIView *shoppingGuideView = [self makeShoppingGuideView];
    [headerView addSubview:shoppingGuideView];
    [shoppingGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(105*2);
    }];
    totalHeight+=(105*2+10);
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(shoppingGuideView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(35);
    }];
    totalHeight+=35;
    
    UIImageView *topImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top10"]];
    topImg.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(topView.mas_top).offset(10);
        make.width.mas_equalTo(81);
        make.height.mas_equalTo(21);
    }];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, totalHeight);
}

- (UIView *)makeCategoryView{
        ///分类view
    UIView  *bgView = [[UIView alloc]initWithFrame:CGRectZero];
    bgView.backgroundColor = [UIColor whiteColor];
    
    int totalloc = 4;
    CGFloat viewWidth = 50;
    CGFloat viewHeight = 75;
    CGFloat margin = (SCREEN_WIDTH-totalloc*viewWidth)/(totalloc+1);
    
    for (int i = 0; i < self.model.categories.count; i++) {
        int row = i/totalloc;
        int loc = i%totalloc;
        CGFloat viewX = margin+(margin+viewWidth)*loc;
        CGFloat viewY = 10+(10+viewHeight)*row;
        UIView *cateView = [[[NSBundle mainBundle]loadNibNamed:@"CategoriesScrollItem" owner:self options:nil]lastObject];
        cateView.tag = i;
        [bgView addSubview:cateView];
        [cateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(viewY);
            make.left.mas_equalTo(viewX);
            make.width.mas_equalTo(viewWidth);
            make.height.mas_equalTo(viewHeight);
        }];
        
        CategoriesModel *cateModel = [self.model.categories objectAtIndexSafe:i];
        UIImageView *imageView = (UIImageView *)[cateView viewWithTag:101];
        [imageView sd_setImageWithURL:[NSURL URLWithString:cateModel.icon]];
        
        UILabel *nameLab = (UILabel *)[cateView viewWithTag:102];
        nameLab.text = cateModel.name;
        
        UIButton *cateBtn = (UIButton *)[cateView viewWithTag:103];
        cateBtn.tag = i;
        [[cateBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"btn%ld跳转",(long)cateBtn.tag);
        }];
    }
    return bgView;
}

- (UIView *)makeTaskAndPointView{
        ///活动入口view
    UIView *taskPointView = [[[NSBundle mainBundle]loadNibNamed:@"TaskPointView" owner:self options:nil]lastObject];
    taskPointView.backgroundColor = [UIColor whiteColor];
    
    UIButton *checkInBtn = (UIButton *)[taskPointView viewWithTag:101];
    [[checkInBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"签到抽奖click");
    }];
    
    UIButton *mallStoreBtn = (UIButton *)[taskPointView viewWithTag:102];
    [[mallStoreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"积分领券click");
    }];
    
    UIButton *taskCenterBtn = (UIButton *)[taskPointView viewWithTag:103];
    [[taskCenterBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"任务领奖click");
    }];
    
    return taskPointView;
}

- (UIView *)makeShoppingGuideView{
        ///导购view
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectZero];
    bgView.backgroundColor = [UIColor whiteColor];
    
    int totalloc = 2;
    CGFloat viewHeight = 105;
    for (int i = 0; i < self.model.modules.count; i++) {
        int row = i/totalloc;
        int loc = i%totalloc;
        UIView *guideView = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingGuideView" owner:self options:nil]lastObject];
        ModulesModel *mmodel = [self.model.modules objectAtIndexSafe:i];
        UILabel *nameLab = (UILabel *)[guideView viewWithTag:101];
        nameLab.text = mmodel.name;
        
        UILabel *descLab = (UILabel *)[guideView viewWithTag:102];
        descLab.text = mmodel.content;
        
        UIImageView *imageView = (UIImageView *)[guideView viewWithTag:103];
        [imageView sd_setImageWithURL:[NSURL URLWithString:mmodel.icon]];
        
        UIButton *goUrl = (UIButton *)[guideView viewWithTag:104];
        [[goUrl rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"go link%@",mmodel.gotoUrl);
        }];
        guideView.tag = i;
        [bgView addSubview:guideView];
        [guideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(viewHeight*row);
            make.left.mas_equalTo(SCREEN_WIDTH/2*loc);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(viewHeight);
            
        }];
    }
        ///分割线
    UIView *line1View = [[UIView alloc]init];
    line1View.backgroundColor = UICOLOR_RGB(230, 231, 232);
    [bgView addSubview:line1View];
    [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(viewHeight);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line2View = [[UIView alloc]init];
    line2View.backgroundColor = UICOLOR_RGB(230, 231, 232);
    [bgView addSubview:line2View];
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH/2);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(viewHeight*2);
    }];
    return bgView;
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"click banner");
}

- (void)goCart{
    CartViewController *cartVC = [[CartViewController alloc]init];
    [self.navigationController pushViewController:cartVC animated:YES];
}

@end
