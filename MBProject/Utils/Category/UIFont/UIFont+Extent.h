//
//  UIFont+Extent.h
//  MBProject
//
//  Created by MaBiao on 2018/4/22.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extent)

+(UIFont *)adaptFontSize:(CGFloat)fontSize;
+(UIFont *)adaptBoldFontSize:(CGFloat)fontSize;

+(UIFont *)adaptFontWithName:(NSString*)fontName size:(CGFloat)fontSize;

@end
