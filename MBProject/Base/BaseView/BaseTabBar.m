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

/***  发布按钮*/
@property(nonatomic,weak)UIButton *publishButton;
//@property(nonatomic,weak)UIView  *line;
@end

@implementation BaseTabBar

/**
 *  在初始化时候添加自己内部的控件
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundImage = [UIImage imageWithColor:[UIColor colorWithRGBA:33 g:32 b:36 a:1.0]];
//        UIView *line = [[UIView alloc]init];
//        line.backgroundColor = [UIColor mainColor];
//        [self addSubview:line];
//        line.alpha = 0.5;
//        self.line = line;

        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"compose.jpg"] forState:UIControlStateNormal];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.adjustsImageWhenHighlighted = NO;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

#pragma mark - UI
/**  布局子控件 */
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
//    CGFloat lineX = ScreenWidth / 2 + 0.5;
//    CGFloat lineW = 1;
//    CGFloat lineH = 32;
//    CGFloat lineY = (TabBarHeight + BottomTarBarSpace -lineH)/2;
//    self.line.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat publichButtonW =  self.publishButton.currentBackgroundImage.size.width;
    CGFloat publichButtonH = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.publishButton.bounds = CGRectMake(0, 0, publichButtonW, publichButtonH);
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 3;
    CGFloat buttonH = self.frame.size.height;
    
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //如果tabBar的子控件不是继承UIControl 或子控件是发布按钮，继续遍历，直到找到继承UIControl的子控件（UITabBarButton）
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 0)?(index+1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
}


#pragma mark - action
/**
 *  发布按钮点击
 */
- (void)publishClick{
    NSLog(@"%s ",__FUNCTION__);
}

@end
