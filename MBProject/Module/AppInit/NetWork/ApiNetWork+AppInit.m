//
//  ApiNetWork+AppInit.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "ApiNetWork+AppInit.h"

@implementation ApiNetWork (AppInit)


- (NSString *)apiAppVersion
{
    return [NSString stringWithFormat:@"%@",BaseUrl];
}

- (NSString *)apiAppActivity
{
    return [NSString stringWithFormat:@"%@",BaseUrl];
}



- (void)getAppVersion:(NSDictionary *)parameters URL:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    [self GETWithURL:url parameters:parameters cachePolicy:MBCachePolicyNetworkOnly callback:^(id responseObject, NSError *error) {
        
        if (!error) {
            if(success){
                success(responseObject);
            }
            
        }else{
            failure(error);
            NSLog(@"---->%@",@"错误");
        }
    }];
}

- (void)getAppActivity:(NSDictionary *)parameters URL:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self GETWithURL:url parameters:parameters cachePolicy:MBCachePolicyNetworkOnly callback:^(id responseObject, NSError *error) {
        if (!error) {
            if(success){
                success(responseObject);
            }
            
        }else{
            failure(error);
            NSLog(@"---->%@",@"错误");
        }
    }];
}

@end
