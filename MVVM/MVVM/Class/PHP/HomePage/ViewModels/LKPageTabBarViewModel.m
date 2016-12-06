//
//  LKPageTabBarViewModel.m
//  MVVM
//
//  Created by Mike on 16/8/8.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKPageTabBarViewModel.h"
#import "LKPageTabBarModel.h"

@implementation LKPageTabBarViewModel

#pragma mark -system
- (instancetype)initWithModel:(id)model
{
    return [super initWithModel:model];
}
#pragma mark -private
-(void)lk_initialize
{
}
#pragma mark -layzLoad
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
- (RACCommand *)requestCommand
{
    if (!_requestCommand) {
        @weakify(self);
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            // 返回一个信号
            RACSignal *requuestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
              @strongify(self);
                [self.request GET:SLIDEPAGEAPI parameters:nil success:^(LKRequest *request, NSString *responseString) {
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
            // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
            return [requuestSignal map:^id(id value) {
                @strongify(self);
                NSArray *arr = [LKPageTabBarModel mj_objectArrayWithKeyValuesArray:value[@"data"][@"candidates"]];
                for (LKPageTabBarModel *pageTabbarModel in arr) {
                    [self.dataArr addObject:pageTabbarModel.name];
                }
                return self.dataArr;
            }];

        }];
    }
    return _requestCommand;
}
@end
