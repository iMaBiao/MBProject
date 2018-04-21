//
//  UpdateTool.h
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateTool : NSObject

+ (id)instance;

///从后台检查版本
- (void)checkAppVersionFromServer;

///从AppStore检查版本
- (void)checkAppVersionFromAppStore;


@end
