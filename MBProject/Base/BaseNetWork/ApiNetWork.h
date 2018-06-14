//
//  ApiNetWork.h
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, ApiNetworkCachePolicy){
    ApiNetworkCachePolicyCacheDataThenLoad = 1000,      ///< 有缓存就先返回缓存，同步请求数据
    ApiNetworkCachePolicyIgnoreCacheReload,             ///< 忽略缓存，重新请求
    ApiNetworkCachePolicyReturnCacheDataElseLoad,       ///< 有缓存就用缓存，没有缓存就重新请求
    ApiNetworkCachePolicyReturnCacheDataNotLoad         ///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};
@interface ApiNetWork : NSObject
//初始化 单例
+ (id)instance;

//http get方法
- (void)httpGetFunc:(NSDictionary *)parameters
                URL:(NSString *)url
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure
        cachePolicy:(ApiNetworkCachePolicy)cachePolicy;

//http Post方法
- (void)httpPostFunc:(NSDictionary *)parameters
                 URL:(NSString *)url
             success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure
         cachePolicy:(ApiNetworkCachePolicy)cachePolicy;

//manager ,唯一
@property(strong,nonatomic) AFHTTPSessionManager *manager;


@end
