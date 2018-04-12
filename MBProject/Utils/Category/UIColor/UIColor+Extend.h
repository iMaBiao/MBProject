//
//  UIColor+Extend.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MBColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

@interface UIColor (Extend)

///从十六进制字符串获取颜色
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 *  从十六进制字符串获取颜色
 *  @param color NSString : 支持@"#123456"、@"0X123456"、@"123456"三种格式
 *  @param alpha CGFloat : 支持 0.1 - 1.0
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
