//
//  LKheadViewModel.m
//  MVVM
//
//  Created by Mike on 16/8/5.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKheadViewModel.h"
#import "LKheadModel.h"

@interface LKheadViewModel()

@property (nonatomic,strong)LKheadModel *headModel;

@end
@implementation LKheadViewModel

#pragma mark -system
- (instancetype)initWithModel:(id)model
{
    self.headModel = (LKheadModel *)model;
    return [super initWithModel:model];
}
- (void)lk_initialize
{

}
#pragma mark -layzLoad
- (RACCommand *)requestCommand
{
    if (!_requestCommand) {
       // 创建命令
        @weakify(self);
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            // 返回一个信号
            RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                  @strongify(self);
                [MBProgressHUD showMessage:@"正在加载..."];
                // 网络请求
                [self.request GET:BANNERAPI parameters:nil success:^(LKRequest *request, NSString *responseString) {
                    
                    [MBProgressHUD hideHUD];
                    // 发送信号
                    [subscriber sendNext:responseString];
                    
                    // 命令执行完毕
                    [subscriber sendCompleted];
                    
                } failure:^(LKRequest *request, NSError *error) {
                      [MBProgressHUD showError:@"网络连接失败"];
                    
                      [subscriber sendCompleted];
                }];
                return nil;
            }];
            // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
             return [requestSignal map:^id(id value) {
                 @strongify(self);
                NSArray *arr = [LKheadModel mj_objectArrayWithKeyValuesArray:value[@"data"][@"banners"]];
                for ( LKheadModel *headModel  in arr) {
                    [self.dataArray addObject:headModel.imageUrl];
                }
                 return self.dataArray;
            }];
        }];
    }
    return _requestCommand;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
@end
