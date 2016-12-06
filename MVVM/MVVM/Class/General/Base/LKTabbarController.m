//
//  LKTabbarController.m
//  MVVM
//
//  Created by Mike on 16/8/1.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTabbarController.h"
#import "LKHomePageViewController.h"
#import "LKSingleGoodsViewController.h"
#import "LKClassifyViewController.h"
#import "LKMineViewController.h"
#import "LKNavigationController.h"

@interface LKTabbarController ()

@end

@implementation LKTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSubviewControllers];
}

- (void)setSubviewControllers
{
    NSArray *titleArr = @[@"单糖",@"单品",@"分类",@"我的"];
    
    NSArray *classArr = @[@"LKHomePageViewController",@"LKSingleGoodsViewController",@"LKClassifyViewController",@"LKMineViewController"];
    
    NSArray *imageArr = @[@"TabBar_home_23x23_",@"TabBar_gift_23x23_",@"TabBar_category_23x23_",@"TabBar_me_boy_23x23_"];
    
      NSMutableArray *subVCArr  = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIViewController *vc = [[NSClassFromString(classArr[i] ) alloc] init];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArr[i] image:[UIImage imageWithOriginalName:imageArr[i]] selectedImage:[UIImage imageWithOriginalName:[imageArr[i] stringByAppendingString:@"selected"]]];
        [subVCArr addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
        
    }
    self.viewControllers = subVCArr;
    
    [self.tabBar setTintColor:RGB(245.0, 80.0, 83.0)];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName :RGBA(159.0, 159.0, 159.0, 1.0)
                                                        } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName :RGBA(234.0, 54.0, 6.0, 1.0)
                                                        } forState:UIControlStateSelected];
}
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
