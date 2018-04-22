//
//  AppInit.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "AppInit.h"
#import "UpdateTool.h"
#import "GuideViewController.h"
#import "BaseTabBarController.h"
#import "AppDelegate.h"


@interface AppInit()

@end

@implementation AppInit

+ (id)instance
{
    static dispatch_once_t onceToken = 0;
    __strong static AppInit *instance = nil;
    
    _dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)appInitFuction
{
    
    [self initRootTabBar];
}

- (void)initRootTabBar
{
    BaseTabBarController *tabBarViewController = [[BaseTabBarController alloc] init];
    tabBarViewController.tabBar.translucent = NO;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.window.rootViewController = tabBarViewController;
    [app.window makeKeyAndVisible];
}



@end
