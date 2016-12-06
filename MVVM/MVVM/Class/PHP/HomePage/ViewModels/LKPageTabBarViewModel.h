//
//  LKPageTabBarViewModel.h
//  MVVM
//
//  Created by Mike on 16/8/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKViewModel.h"

@interface LKPageTabBarViewModel : LKViewModel

@property(nonatomic,strong)RACCommand *requestCommand;

@property(nonatomic,strong)NSMutableArray *dataArr;

@end
