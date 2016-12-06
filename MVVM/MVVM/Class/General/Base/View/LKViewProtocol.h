//
//  LKViewProtocol.h
//  MVVM
//
//  Created by Mike on 16/8/2.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LKViewModelProtocol;

@protocol LKViewProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <LKViewModelProtocol>)viewModel;

- (void)lk_bindViewModel;
- (void)lk_setupViews;
- (void)lk_addReturnKeyBoard;

@end
