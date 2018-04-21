//
//  BaseTabBarController.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseTabBar.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInit];
}

#pragma mark - UI
- (void)setupInit
{
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor brownColor];
    
    UITabBarItem *tabBarItem =[UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
    self.view.backgroundColor = [UIColor randomColor];
    
    
    [self addChildsViewController:[[UIViewController alloc]init] title:@"语聊" image:@"me" selectedImage:@"me_selected"];
    
    [self addChildsViewController:[[UIViewController alloc]init] title:@"订制" image:@"me" selectedImage:@"me_selected"];
    
    [self addChildsViewController:[[UIViewController alloc]init] title:@"消息" image:@"me" selectedImage:@"me_selected"];
    
    [self addChildsViewController:[[UIViewController alloc]init] title:@"我的" image:@"me" selectedImage:@"me_selected"];
    
    // 更换系统自带的tabBar
//    BaseTabBar *tabBar = [[BaseTabBar alloc]init];
//    [self setValue:tabBar forKeyPath:@"tabBar"];
}

/**  添加子控制器 */
- (void)addChildsViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
