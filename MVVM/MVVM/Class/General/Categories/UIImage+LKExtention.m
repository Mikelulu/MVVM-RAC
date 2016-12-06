//
//  UIImage+LKExtention.m
//  MVVM
//
//  Created by Mike on 16/8/1.
//  Copyright © 2016年 LK. All rights reserved.
//

#import "UIImage+LKExtention.h"

@implementation UIImage (LKExtention)


+ (instancetype)imageWithOriginalName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
