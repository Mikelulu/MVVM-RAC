//
//  UIImage+LKExtention.h
//  MVVM
//
//  Created by Mike on 16/8/1.
//  Copyright © 2016年 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LKExtention)


// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
//返回可伸展的图片
+ (instancetype)imageWithStretchableName:(NSString *)imageName;


@end
