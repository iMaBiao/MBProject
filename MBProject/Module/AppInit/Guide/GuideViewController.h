//
//  GuideViewController.h
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//  引导图

#import <UIKit/UIKit.h>

@protocol GuideVCSelectDelegate <NSObject>

- (void)guideVCBtnAction:(UIButton *)sender;

@end


@interface GuideViewController : UIViewController

@property (nonatomic, strong) UIButton *btnEnter;

@property (nonatomic,strong) UIImageView *imageView;

// 创建单利类
+ (instancetype)shareXTGuideVC;

// 初始化引导页
- (void)initWithXTGuideView:(NSArray *)images;
// 版本信息判断
- (BOOL)isShow;
@property (nonatomic, assign) id<GuideVCSelectDelegate> delegate;


@end
