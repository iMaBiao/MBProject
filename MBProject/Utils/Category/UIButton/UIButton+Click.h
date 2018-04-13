//
//  UIButton+Click.h
//  MBProject
//
//  Created by MaBiao on 2018/4/13.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)(void);

@interface UIButton (Click)

///将addTarget改为block
@property (nonatomic,copy) clickBlock click;


///拦截重复点击
@property (nonatomic, assign) NSTimeInterval acceptEventInterval; // 重复点击的间隔
@property (nonatomic, assign) NSTimeInterval acceptEventTime;

@end
