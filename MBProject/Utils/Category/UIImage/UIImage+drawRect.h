//
//  UIImage+drawRect.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (drawRect)

/** 根据颜色绘制图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)cColor withFrame:(CGRect)aFrame;
/** 将图片切成圆形图片 */
- (UIImage *)circleImage;

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

/**
 压缩图片到指定尺寸
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;

//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
