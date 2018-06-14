//
//  ApiNetWork.m
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#define TimeOutSecs  20.0

#import "ApiNetWork.h"
#import <YYCache/YYCache.h>

static NSString * const ApiNetworkCache = @"ApiNetworkCache";

@implementation ApiNetWork


+(id)instance
{
    static dispatch_once_t onceToken = 0;
    __strong static ApiNetWork *instance = nil;
    
    _dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _manager.requestSerializer.timeoutInterval = TimeOutSecs;// seconds of timeout
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    }
    return self;
}

- (void)httpGetFunc:(NSDictionary *)parameters
                URL:(NSString *)url
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure
        cachePolicy:(ApiNetworkCachePolicy)cachePolicy
{
    //设置请求头
    //[_manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];

    YYCache *cache = [[YYCache alloc] initWithName:ApiNetworkCache];
    id response = [cache objectForKey:url];
    if ([cache containsObjectForKey:url] && success && cachePolicy == ApiNetworkCachePolicyReturnCacheDataNotLoad) {//有缓存且需要回调且不需要发出请求
        success(response);
    }else {//需要发网络请求
        
        if (cachePolicy == ApiNetworkCachePolicyCacheDataThenLoad) {///< 有缓存就先返回缓存，同步请求数据
           success(response);
        }
        
        [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            ///< 忽略缓存，重新请求
            if (cachePolicy == ApiNetworkCachePolicyIgnoreCacheReload || cachePolicy == ApiNetworkCachePolicyCacheDataThenLoad) {
                if(success){
                    success(responseObject);
                }
            }
            
            //缓存数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            if (dic.count) {
                [cache setObject:dic forKey:url];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    }
   
}

- (void)httpPostFunc:(NSDictionary *)parameters
                 URL:(NSString *)url
             success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure
         cachePolicy:(ApiNetworkCachePolicy)cachePolicy
{
    
    //设置请求头
    //[_manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    
    YYCache *cache = [[YYCache alloc] initWithName:ApiNetworkCache];
    id response = [cache objectForKey:url];
    if ([cache containsObjectForKey:url] && success && cachePolicy == ApiNetworkCachePolicyReturnCacheDataNotLoad) {//有缓存且需要回调且不需要发出请求
        success(response);
    }else{
        
        if (cachePolicy == ApiNetworkCachePolicyCacheDataThenLoad) {///< 有缓存就先返回缓存，同步请求数据
            success(response);
        }
        
        [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            ///< 忽略缓存，重新请求
            if (cachePolicy == ApiNetworkCachePolicyIgnoreCacheReload || cachePolicy == ApiNetworkCachePolicyCacheDataThenLoad) {
                if(success){
                    success(responseObject);
                }
            }
            
            //缓存数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
            if (dic.count) {
                [cache setObject:dic forKey:url];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    }
}


//NSString *jsonString = [[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//if ([jsonString hasPrefix:@"{"]) {
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if (mnnetSet.saveCache && ![dic safeBoolForKey:@"is_last_page"]) {
//        [cache setObject:dic forKey:url];
//    }
//    success(dic);
//}else{
//    success(jsonString);
//}

@end
