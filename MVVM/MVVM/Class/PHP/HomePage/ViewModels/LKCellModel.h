//
//  LKCellModel.h
//  MVVM
//
//  Created by Mike on 16/8/9.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKViewModel.h"

@interface LKCellModel : LKViewModel



@property(nonatomic,strong)RACCommand  *requestCommand;

@property(nonatomic,strong)RACSubject *refreshUISubjext;

@property(nonatomic,strong)NSMutableArray *dataArr;

// 上拉加载
@property(nonatomic,strong)RACCommand *nextPageCommand;

@property(nonatomic,strong)RACSubject *refreshEndSubjext;



@end
