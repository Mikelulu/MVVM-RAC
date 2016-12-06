//
//  LKViewControllerProtocol.h
//  MVVM
//
//  Created by Mike on 16/8/2.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LKViewModelProtocol ;

@protocol LKViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <LKViewModelProtocol>)viewModel;

- (void)lk_bindViewModel;
- (void)lk_addSubviews;
- (void)lk_layoutNavigation;
- (void)lk_getNewData;
- (void)recoverKeyboard;


@end
