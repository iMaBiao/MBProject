//
//  UpdateView.h
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//  检查更新的弹框View

#import <UIKit/UIKit.h>

#import "AppVersionModel.h"

@interface UpdateView : UIView

///appStore下载地址
@property (nonatomic, strong) NSString *appStoreUrl;
///版本信息模型
@property (nonatomic, strong) AppVersionModel *versionModel;

@end
