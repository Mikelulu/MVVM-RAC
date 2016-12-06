//
//  LKCellModel.m
//  MVVM
//
//  Created by Mike on 16/8/9.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKCellModel.h"
#import "LKModel.h"

@interface LKCellModel()

@property(nonatomic,assign)NSInteger offset;

@end
@implementation LKCellModel

- (void)lk_initialize
{
    @weakify(self);
    [self.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.dataArr removeAllObjects];
        NSArray *arr = [LKModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"items"]];
        [self.dataArr addObjectsFromArray:arr];
        
        [self.refreshUISubjext sendNext:nil];
        [self.refreshEndSubjext sendNext:@(LKHeaderRefresh_HasMoreData)];
        
    }];
   
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        NSArray *arr = [LKModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"items"]];
        [self.dataArr addObjectsFromArray:arr];
        
        [self.refreshUISubjext sendNext:nil];
        if ([x[@"data"][@"code"] integerValue] == 200) {
            [self.refreshEndSubjext sendNext:@(LKFooterRefresh_HasMoreData)];
        }else{
            
            [self.refreshEndSubjext sendNext:@(LKFooterRefresh_HasNoMoreData)];
        }
        
    }];
}
#pragma mark -layzLoad
- (RACCommand *)requestCommand
{
    if (!_requestCommand) {
        @weakify(self);
        // 创建命令
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            // 创建网络请求信号;
            return  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                self.offset = 0;
                // 网络请求
                [self.request GET:[NSString stringWithFormat:HOMEAPI,self.offset] parameters:nil success:^(LKRequest *request, NSString *responseString) {
//                    NSLog(@"%@",responseString);
                    // 发送信号
                    [subscriber sendNext:responseString];
                    // 命令执行完毕
                    [subscriber sendCompleted];
                    
                } failure:^(LKRequest *request, NSError *error) {
                    [MBProgressHUD showError:@"网络连接失败"];
                    // 命令执行完毕
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
       }];
    }
    return _requestCommand;
}
- (RACCommand *)nextPageCommand
{
    if (!_nextPageCommand) {
        //创建命令
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            // 创建信号
             return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                
                self.offset ++;
                [self.request GET:[NSString stringWithFormat:HOMEAPI,self.offset] parameters:nil success:^(LKRequest *request, NSString *responseString) {
                    
                    // 发送信号
                    [subscriber sendNext:responseString];
                    // 结束执行命令
                    [subscriber sendCompleted];
                } failure:^(LKRequest *request, NSError *error) {
                    @strongify(self);
                    self.offset -- ;
                    [MBProgressHUD showError:@"网络不给力"];
                    // 结束执行命令
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
            
        }];
    }
    return _nextPageCommand;
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
- (RACSubject *)refreshUISubjext
{
    if (!_refreshUISubjext) {
        _refreshUISubjext = [RACSubject subject];
    }
    return _refreshUISubjext;
}
- (RACSubject *)refreshEndSubjext
{
    if (!_refreshEndSubjext) {
        _refreshEndSubjext = [RACSubject subject];
    }
    return _refreshEndSubjext;
}
@end
