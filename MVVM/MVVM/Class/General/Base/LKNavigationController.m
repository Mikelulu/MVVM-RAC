//
//  LKNavigationController.m
//  MVVM
//
//  Created by Mike on 16/8/1.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKNavigationController.h"

@interface LKNavigationController ()

@end

@implementation LKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        ///第二层viewcontroller 隐藏tabbar
        viewController.hidesBottomBarWhenPushed=YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setImage:[UIImage imageWithOriginalName:@"checkUserType_backward_9x15_"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithOriginalName:@"checkUserType_backward_9x15_"] forState:UIControlStateHighlighted];
        [button sizeToFit];
       
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self popViewControllerAnimated:YES];
        }];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    [super pushViewController: viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
