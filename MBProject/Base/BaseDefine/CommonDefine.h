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

#define StatusBarHeight (DeviceHeight == 812.0 ? 44 : 20)           //状态栏高度
#define NavBarHeight    44                                          //导航栏高度
#define SafeAreaTopHeight (DeviceHeight == 812.0 ? 88 : 64)
#define BottomTarBarSpace (DeviceHeight == 812.0 ? 34 : 0)
#define TabBarHeight       49

// 是否是iPhoneX
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为 4英寸
#define FourInch [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为 4.7英寸
#define Four_sevenInch [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为 5.5英寸
#define Five_fiveInch [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//-------比例（以6S为例）------------------------------------------------------
#define SCALE  ScreenWidth / 375.0f

//提示显示时间  秒
#define TipShowTime   2.0


#endif /* CommonDefine_h */
