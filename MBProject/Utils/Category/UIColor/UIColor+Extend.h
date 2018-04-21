//
//  UIColor+Extend.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)

///主题色
+ (UIColor *)mainColor;

///随机色
+ (UIColor *)randomColor;

///从十六进制字符串获取颜色
+ (UIColor *)colorWithHexString:(NSString *)color;

/**  从十六进制字符串获取颜色 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

///10进制颜色
+ (UIColor *)colorWithRGBA:(CGFloat )r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)alpha;

@end
