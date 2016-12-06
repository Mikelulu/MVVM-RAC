//
//  LKViewModel.m
//  MVVM
//
//  Created by Mike on 16/8/2.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKViewModel.h"


@implementation LKViewModel

@synthesize request  = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    LKViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        /** 初始化时 添加初始化函数 方便调用 */
        [viewModel lk_initialize];
    }
    return viewModel;
}

/** 用M初始化VM */
- (instancetype)initWithModel:(id)model
{
    if (self == [super init]) {
        /** 初始化时 添加初始化函数 方便调用 */
        [self lk_initialize];
    }
    return self;
}

/** 初始化请求体，方便子类发起网络请求 */
- (LKRequest *)request
{
    if (!_request) {
        _request = [LKRequest request];
    }
    return _request;
}

/** 做一些数据绑定 网络回调处理 */
- (void)lk_initialize
{
    
}
@end
