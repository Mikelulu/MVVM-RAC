//
//  LKTableViewCell.m
//  MVVM
//
//  Created by Mike on 16/8/2.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTableViewCell.h"

@implementation LKTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self lk_setupViews];
        [self lk_bindViewModel];
    }
    return self;
}

- (void)lk_setupViews
{
    
}
- (void)lk_bindViewModel
{
    
}
@end
