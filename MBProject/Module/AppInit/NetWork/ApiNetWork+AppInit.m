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



- (void)getAppVersion:(NSDictionary *)parameters URL:(NSString *)url success:(void (^)(id *responseObject))success failure:(void (^)(NSError *error))failure
{
    [self httpGetFunc:parameters URL:url success:^(id result) {
        //将获取的数据转成NSDictionary
//        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:result options:kNilOptions error:nil];
        if(success){
            
        }
        
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}

- (void)getAppActivity:(NSDictionary *)parameters URL:(NSString *)url success:(void (^)(id *responseObject))success failure:(void (^)(NSError *error))failure
{
    [self httpGetFunc:parameters URL:url success:^(id result) {
       
        if(success){
            
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}

@end
