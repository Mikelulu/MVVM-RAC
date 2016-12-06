//
//  LKTableViewCellProtocol.h
//  MVVM
//
//  Created by Mike on 16/8/2.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LKTableViewCellProtocol <NSObject>

@optional

- (void)lk_setupViews;
- (void)lk_bindViewModel;

@end
