//
//  ApiNetWork.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ApiNetWork : NSObject
//初始化 单例
+ (id)instance;

//http get方法
- (void)httpGetFunc:(NSDictionary *)parameters
                URL:(NSString *)url
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure;

//http Post方法
- (void)httpPostFunc:(NSDictionary *)parameters
                 URL:(NSString *)url
             success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure;
//Http json Post 方法
- (void)httpJsonPostFunc:(NSDictionary *)parameters
                     URL:(NSString *)url success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure;
//manager ,唯一
@property(strong,nonatomic) AFHTTPSessionManager *manager;
@end
