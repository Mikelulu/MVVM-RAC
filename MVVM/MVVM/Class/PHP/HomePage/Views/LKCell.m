//
//  LKCell.m
//  MVVM
//
//  Created by Mike on 16/8/9.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKCell.h"
#import "LKModel.h"

@interface LKCell()

@property(nonatomic,strong)UILabel *titleLable;

@property(nonatomic,strong)UILabel *contentLable;

@property(nonatomic,strong)UIImageView *imageV;

@end
@implementation LKCell

#pragma mark -system
- (void)lk_setupViews
{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.contentLable];
    [self.contentView addSubview:self.imageV];
    // 标题
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(15);
    }];
    self.titleLable.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    // 内容
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.mas_bottom).offset(15);
        make.left.mas_equalTo(self.contentView).offset(15);
    }];
    self.contentLable.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    
    // 图片
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLable.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    self.hyb_lastViewInCell = self.imageV;
    self.hyb_bottomOffsetToCell = 10.0;
}

#pragma mark - public
- (void)confinCellWithModel:(LKModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.titleLable.text = model.title;
    CGFloat h1 = [self stringHeightWithString:model.title fontSize:18 maxWith:SCREEN_WIDTH - 30];
    [self.titleLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(h1);
    }];
    
    self.contentLable.text = model.shareMsg;
     CGFloat h2 = [self stringHeightWithString:model.shareMsg fontSize:16 maxWith:SCREEN_WIDTH - 30];
    [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(h2);
    }];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverImageUrl] placeholderImage:DEFAULTIMAGE];
}
#pragma mark -private
// 根据文字多少计算高度
- (float)stringHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize maxWith:(CGFloat)maxWith
{
    float height = [string boundingRectWithSize:CGSizeMake(maxWith, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    
    return ceilf(height);
}
#pragma mark - layzLoad
- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.font = H18;
        _titleLable.backgroundColor = orange_color;
        _titleLable.numberOfLines = 0;
    }
    return _titleLable;
}
- (UILabel *)contentLable
{
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] init];
        _contentLable.textColor = RGB(252, 252, 252);
        _contentLable.font = H16;
//        _contentLable.backgroundColor = orange_color;
        _contentLable.numberOfLines = 0;
        _contentLable.textColor = lightGray_color;
    }
    return _contentLable ;
}
- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}
@end
