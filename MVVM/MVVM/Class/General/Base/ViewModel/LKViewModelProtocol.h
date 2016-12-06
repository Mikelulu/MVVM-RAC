//
//  LKViewModelProtocol.h
//  MVVM
//
//  Created by Mike on 16/8/2.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LKRefreshDataStatus)
{
    LKHeaderRefresh_HasMoreData = 1, // 下拉还有更多数据
//    LKHeaderRefresh_HasNoMoreData,   // 下拉没有更多数据
    LKFooterRefresh_HasMoreData,     // 上拉还有更多数据
    LKFooterRefresh_HasNoMoreData,   // 上拉没有更多数据
    LKRefreshError,                  // 刷新出错
    LKRefreshUI,                     // 仅仅刷新UI布局
};
@protocol LKViewModelProtocol <NSObject>

@property(nonatomic,strong)LKRequest *request;

@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)lk_initialize;

@end
