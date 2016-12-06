//
//  LKHomePageViewController.m
//  MVVM
//
//  Created by Mike on 16/8/1.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKHomePageViewController.h"
#import "LKLeftMenuViewController.h"
#import "UINavigationBar+Awesome.h"

#import "TYSlidePageScrollView.h"
#import "TYTitlePageTabBar.h"
#import "LKHeadView.h"
#import "LKPageTabBarViewModel.h"
#import "LKTableViewController.h"
#import "LKCellModel.h"

#define kNavBarHeight 64
@interface LKHomePageViewController ()<TYSlidePageScrollViewDelegate,TYSlidePageScrollViewDataSource>

@property(nonatomic,strong)TYSlidePageScrollView *slidePageScrollView;

@property(nonatomic,strong)TYTitlePageTabBar *titlePageTabBar;

@property(nonatomic,strong)LKPageTabBarViewModel *pageTabBarViewModel;

@property(nonatomic,strong)NSMutableArray *pageTabBarArr;

@property(nonatomic,strong)LKCellModel *cellModel;

@property(nonatomic,strong) LKHeadView *headView;
@end

@implementation LKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark -system
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
///** 重写这个方法去更新当前View 的内部布局 */
//- (void)updateViewConstraints
//{
//    [super updateViewConstraints];
//}
#pragma mark - private
- (void)lk_addSubviews
{
   
}

- (void)lk_bindViewModel
{
    // 执行请求
    RACSignal *reqestSignal = [self.pageTabBarViewModel.requestCommand execute:nil];
    // 获取请求的数据
    @weakify(self);
    [reqestSignal subscribeNext:^(id x) {
        @strongify(self);
        self.pageTabBarArr  = x;
        
        self.slidePageScrollView.pageTabBar = self.titlePageTabBar;
        for (NSInteger i = 0; i<self.pageTabBarArr.count; i++) {
            [self addTableViewWithPage:i];
        }
       
        [self.view addSubview:self.slidePageScrollView];
        [self.slidePageScrollView reloadData];
    }];
    
}
- (void)addTableViewWithPage:(NSInteger)page
{
    LKTableViewController *tableViewVC = [[LKTableViewController alloc] init];
    tableViewVC.view.frame = self.view.frame;
    tableViewVC.page = page;
    [self addChildViewController:tableViewVC];
}
- (void)lk_layoutNavigation
{
    self.title = @"单糖";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn setImage:[UIImage imageWithOriginalName:@"list_button"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)lk_getNewData
{
}
#pragma mark - layzLoad
- (TYSlidePageScrollView *)slidePageScrollView
{
    if (!_slidePageScrollView) {
        _slidePageScrollView = [[TYSlidePageScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 49)];
        _slidePageScrollView.pageTabBarIsStopOnTop = YES;
        _slidePageScrollView.pageTabBarStopOnTopHeight = kNavBarHeight;
//        _slidePageScrollView.parallaxHeaderEffect = YES;//弹性视差效果
        _slidePageScrollView.delegate = self;
        _slidePageScrollView.dataSource = self;
        
        _slidePageScrollView.headerView = self.headView;
    }
    return _slidePageScrollView;
}
- (LKPageTabBarViewModel *)pageTabBarViewModel
{
    if (!_pageTabBarViewModel) {
        _pageTabBarViewModel = [[LKPageTabBarViewModel alloc]init];
    }
    return _pageTabBarViewModel;
}

- (LKHeadView *)headView
{
    if (!_headView) {
        _headView  = [[LKHeadView alloc] init];
        _headView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    }
    return _headView;
}
- (TYTitlePageTabBar *)titlePageTabBar
{
    if (!_titlePageTabBar) {
        _titlePageTabBar = [[TYTitlePageTabBar alloc] initWithTitleArray:self.pageTabBarArr];
        _titlePageTabBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        _titlePageTabBar.backgroundColor = [LKTool colorWithHexString:@"#f5f5f5"];
    }
    return _titlePageTabBar;
}
- (LKCellModel *)cellModel
{
    if (!_cellModel) {
        _cellModel = [[LKCellModel alloc] init];
    }
    return _cellModel;
}
#pragma mark -delegate
- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.pageTabBarArr.count;
}
- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    LKTableViewController *tableViewVC = self.childViewControllers[index];
  
    return tableViewVC.tableView;
}
- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    UIColor * color = [UIColor colorWithRed:242/255.0 green:79/255.0 blue:85/255.0 alpha:1];
    
    CGFloat headerContentViewHeight = -(CGRectGetHeight(slidePageScrollView.headerView.frame)+CGRectGetHeight(slidePageScrollView.pageTabBar.frame));
    // 获取当前偏移量
    CGFloat offsetY = pageScrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY - headerContentViewHeight;
    
    CGFloat alpha = delta / (CGRectGetHeight(slidePageScrollView.headerView.frame) - kNavBarHeight);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
}

@end
