//
//  BaseTabBar.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "BaseTabBar.h"
#import "UIImage+drawRect.h"

@interface BaseTabBar()

/***  中心按钮 */
@property(nonatomic,weak)UIButton *centerButton;
@end

@implementation BaseTabBar

/**
 *  在初始化时候添加自己内部的控件
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerButton setBackgroundImage:[UIImage imageNamed:@"compose.jpg"] forState:UIControlStateNormal];
        [centerButton addTarget:self action:@selector(centerClick) forControlEvents:UIControlEventTouchUpInside];
        centerButton.adjustsImageWhenHighlighted = NO;
        [self addSubview:centerButton];
        self.centerButton = centerButton;
    }
    return self;
}

#pragma mark - UI
/**  布局子控件 */
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat centerButtonW =  self.centerButton.currentBackgroundImage.size.width;
    CGFloat centerButtonH = self.centerButton.currentBackgroundImage.size.height;
    self.centerButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.centerButton.bounds = CGRectMake(0, 0, centerButtonW, centerButtonH);
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 3;
    CGFloat buttonH = self.frame.size.height;
    
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //如果tabBar的子控件不是继承UIControl 或子控件是发布按钮，继续遍历，直到找到继承UIControl的子控件（UITabBarButton）
        if (![button isKindOfClass:[UIControl class]] || button == self.centerButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 0)?(index+1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
}

#pragma mark - action
/**  按钮点击 */
- (void)centerClick{
    NSLog(@"%s ",__FUNCTION__);
}

@end
