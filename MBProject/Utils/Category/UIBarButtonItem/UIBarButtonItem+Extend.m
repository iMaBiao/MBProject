//
//  UIBarButtonItem+Extend.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "UIBarButtonItem+Extend.h"

@implementation UIBarButtonItem (Extend)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)aciton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (highImage.length > 0) {//如果设置了高亮图片
        [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    CGFloat buttonW = button.currentBackgroundImage.size.width;
    CGFloat buttonH = button.currentBackgroundImage.size.height;
    button.bounds = CGRectMake(0, 0, buttonW, buttonH);
    //    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:aciton forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:button];
}
@end
