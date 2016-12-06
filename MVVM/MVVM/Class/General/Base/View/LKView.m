//
//  LKView.m
//  MVVM
//
//  Created by Mike on 16/8/2.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKView.h"

@implementation LKView

- (instancetype)init
{
    if (self == [super init]) {
        
        /** 一些比用函数写在基类里 */
        [self lk_setupViews];
        [self lk_bindViewModel];
    }
    return self;
}
/** VM配置初始化V */
- (instancetype)initWithViewModel:(id<LKViewModelProtocol>)viewModel
{
    if (self == [super init]) {
        
        [self lk_setupViews];
        [self lk_bindViewModel];
    }
    return self;
}
/**
 *  添加子View到主View
 */
- (void)lk_setupViews{};

/**
 *  绑定V与VM
 */
- (void)lk_bindViewModel{};

/**
 *  点击空白键盘回收
 */
- (void)lk_addReturnKeyBoard
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    // 监听手势 rac_gestureSignal
    [tap.rac_gestureSignal subscribeNext:^(id x) {
       
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}
@end
