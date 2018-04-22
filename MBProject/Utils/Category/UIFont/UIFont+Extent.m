//
//  UIFont+Extent.m
//  MBProject
//
//  Created by MaBiao on 2018/4/22.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "UIFont+Extent.h"

@implementation UIFont (Extent)

+(UIFont *)adaptFontSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:fontSize*SCALE];
}

+(UIFont *)adaptBoldFontSize:(CGFloat)fontSize
{
    return [UIFont boldSystemFontOfSize:fontSize*SCALE];
}

+(UIFont *)adaptFontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    return [UIFont fontWithName:fontName size:fontSize*SCALE];
}

@end
