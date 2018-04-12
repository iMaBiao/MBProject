//
//  ApiNetWork.m
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#define TimeOutSecs  30.0

#import "ApiNetWork.h"

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
            failure:(void (^)(NSError *error))failure;
{
    
    //[_manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];

    [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)httpPostFunc:(NSDictionary *)parameters
                 URL:(NSString *)url
             success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure
{
    [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)httpJsonPostFunc:(NSDictionary *)parameters URL:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
