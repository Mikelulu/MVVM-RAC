//
//  LKCell.h
//  MVVM
//
//  Created by Mike on 16/8/9.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKTableViewCell.h"

@class LKModel;

@interface LKCell : LKTableViewCell

- (void)confinCellWithModel:(LKModel *)model indexPath:(NSIndexPath *)indexPath;

@end
