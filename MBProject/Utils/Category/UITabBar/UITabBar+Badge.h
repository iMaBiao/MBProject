//
//  UITabBar+Badge.h
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index AndTotalIndex:(int)totalIndex;

//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index;
- (void)hideBadgeOnItemIndex:(NSInteger)index;
//移除小红点
- (void)removeBadgeOnItemIndex:(NSInteger)index;


@end
