//
//  LKheadViewModel.h
//  MVVM
//
//  Created by Mike on 16/8/5.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKViewModel.h"

@interface LKheadViewModel : LKViewModel

// 网络请求命令
@property(nonatomic,strong)RACCommand *requestCommand;

// 数据
@property(nonatomic,strong)NSMutableArray *dataArray;

@end
