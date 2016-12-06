//
//  LKHeadView.m
//  MVVM
//
//  Created by Mike on 16/8/4.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKHeadView.h"
#import "LKheadViewModel.h"

@interface LKHeadView ()

@property(nonatomic,strong)LKheadViewModel *headViewModel;

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;

@end
@implementation LKHeadView

#pragma mark - system
- (instancetype)initWithViewModel:(id<LKViewModelProtocol>)viewModel
{
    self.headViewModel = (LKheadViewModel *)viewModel;
  return  [super initWithViewModel:viewModel];
}
#pragma mark - private
- (void)lk_setupViews
{
    
}
- (void)lk_bindViewModel
{
    // 执行请求
    RACSignal *requesSiganl = [self.headViewModel.requestCommand execute:nil];
    
    // 获取请求的数据
    @weakify(self);
    [requesSiganl subscribeNext:^(NSMutableArray *x) {
        @strongify(self);
        self.headViewModel.dataArray = x;
        
        [self addSubview:self.cycleScrollView];
    }];
}
#pragma mark - layzLoad
- (LKheadViewModel *)headViewModel
{
    if (!_headViewModel) {
        _headViewModel = [[LKheadViewModel alloc] init];
    }
    return _headViewModel;
}
- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:nil placeholderImage:DEFAULTIMAGE];
        _cycleScrollView.imageURLStringsGroup = self.headViewModel.dataArray;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.bannerImageViewContentMode =   UIViewContentModeScaleAspectFill;
    }
    return _cycleScrollView;
}
@end
