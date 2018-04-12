//
//  UIColor+Extend.m
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#define DEFAULT_VOID_COLOR  [UIColor colorWithRed:49.0/255.0 green:186.0/255.0 blue:138.0/255.0 alpha:1.0]

#import "UIColor+Extend.h"

@implementation UIColor (Extend)

+ (UIColor *)colorWithHexString:(NSString *)color
{
     return [self colorWithHexString:color alpha:1.0f];
}

/**
 *  从十六进制字符串获取颜色
 *  @param color NSString : 支持@"#123456"、@"0X123456"、@"123456"三种格式
 *  @param alpha CGFloat : 支持 0.1 - 1.0
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
{
    // 删除字符串中空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    // r
    NSString *rString = [cString substringWithRange:range];
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end
