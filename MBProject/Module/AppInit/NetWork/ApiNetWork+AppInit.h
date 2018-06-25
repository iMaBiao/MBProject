//
//  ApiNetWork+AppInit.h
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "ApiNetWork.h"

@interface ApiNetWork (AppInit)

///app版本信息
- (NSString *)apiAppVersion;

///开机广告活动页面
- (NSString *)apiAppActivity;

- (void)getAppVersion:(NSDictionary *)parameters URL:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getAppActivity:(NSDictionary *)parameters URL:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
