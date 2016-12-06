//
//  LKModel.m
//  MVVM
//
//  Created by Mike on 16/8/9.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "LKModel.h"

@implementation LKModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"coverImageUrl":@"cover_image_url",
             @"shareMsg":@"share_msg",
             @"likesCount":@"likes_count"
             };
}
@end
