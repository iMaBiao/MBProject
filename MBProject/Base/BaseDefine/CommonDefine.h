//
//  CommonDefine.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//常用的宏定义

//-------系统宽，高-------------------------------------------------
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width      // 界面宽度
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height     // 界面高度

//状态栏高度 44 或 20
#define StatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NavBarHeight 44                                             //导航条高度
#define NavTopHeight (StatusBarHeight == 44 ? 88 : 64)              //整个导航栏高度
#define BottomTarBarSpace (StatusBarHeight == 44 ? 34 : 0)          //tabBar到底部距离
#define TabBarHeight 49                                            //tabBar高度

//// 是否是iPhoneX
//#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//// 判断是否为 4英寸
//#define FourInch [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
//// 判断是否为 4.7英寸
//#define Four_sevenInch [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
//// 判断是否为 5.5英寸
//#define Five_fiveInch [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f


//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5 SE 系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6 7 8 系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone 6 7 8 Plus 系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX  XS
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXR
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)


//-------比例（以6S为例）------------------------------------------------------
#define SCALE  ScreenWidth / 375.0f

//提示显示时间  秒
#define TipShowTime   2.0


#endif /* CommonDefine_h */
