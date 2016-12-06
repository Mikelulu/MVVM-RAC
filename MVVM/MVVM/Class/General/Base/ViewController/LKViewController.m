//
//  LKViewController.m
//  MVVM
//
//  Created by Mike on 16/8/1.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKViewController.h"

@interface LKViewController ()

// UIStatusBarStyle 枚举类型
@property(nonatomic,assign)UIStatusBarStyle statusBarStyle;
@property(nonatomic,assign)BOOL statusBarHidden;

@end

@implementation LKViewController

/**
 *  常用方法绑定到基类，方便调用
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    LKViewController *viewController = [super allocWithZone:zone];
    
    //  rac_signalForSelector
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)]
        subscribeNext:^(id x) {
            @strongify(viewController)
            [viewController lk_addSubviews];
            [viewController lk_bindViewModel];
        }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController lk_layoutNavigation];
        [viewController lk_getNewData];
    }];
    
    return viewController;
}
/**
 *  使用VM配置初始化VC
 */
- (instancetype)initWithViewModel:(id <LKViewModelProtocol>)viewModel
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lk_removeNavgationBarLine];
    
    [self layoutNavigationBar:nil titleColor:RGB(255, 255, 255) titleFont:[UIFont systemFontOfSize:18.0] leftBarButtonItem:nil rightBarButtonItem:nil];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    self.view.backgroundColor = [LKTool colorWithHexString:@"#f5f5f5"];
    [[UINavigationBar appearance] setBarTintColor:RGB(242, 79, 85)];
}
#pragma mark - private-
/**
 *  去除nav 上的line
 */
- (void)lk_removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                }
            }
        }
    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}
#pragma mark -- RAC --
/**
 *  添加View到ViewController
 */
- (void)lk_addSubviews{}

/**
 *  用来绑定V(VC)与VM
 */
- (void)lk_bindViewModel{}

/**
 *   设置导航栏、分栏
 */
- (void)lk_layoutNavigation{}

/**
 *  初次获取数据的时候调用(不是特别必要)
 */
- (void)lk_getNewData{}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
