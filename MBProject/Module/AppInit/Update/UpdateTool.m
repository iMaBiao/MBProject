//
//  UpdateTool.m
//  MBProject
//
//  Created by MaBiao on 2018/4/21.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#import "UpdateTool.h"
#import "UpdateView.h"
#import "ApiNetWork+AppInit.h"
#import "AppDelegate.h"
#import "AppVersionModel.h"

@interface UpdateTool()

@property (nonatomic, strong) NSString *appStoreUrl;

@end

@implementation UpdateTool

+ (id)instance
{
    static dispatch_once_t onceUpdateToken = 0;
    __strong static UpdateTool *updateInstance = nil;
    
    _dispatch_once(&onceUpdateToken, ^{
        updateInstance = [[self alloc] init];
    });
    return updateInstance;
}

///从后台检查版本
- (void)checkAppVersionFromServer
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSDictionary *paramsDic = @{@"":@""};
    
    NSString *url = [[ApiNetWork instance] apiAppVersion];
    
    [[ApiNetWork instance]getAppVersion:paramsDic URL:url success:^(__autoreleasing id responseObject) {
        
        NSInteger localVersion = [[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
        
        //将获取到的数据转成AppVersionModel
        
        NSInteger onlineVersion = 0;
        
        if(onlineVersion > localVersion){
            [self showUpdateView];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%s form server version error = %@",__FUNCTION__,error);
    }];
}

///从AppStore检查版本
- (void)checkAppVersionFromAppStore
{
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=1163499508"];
    
    [[ApiNetWork instance]GETWithURL:url parameters:nil cachePolicy:MBCachePolicyIgnoreCache callback:^(id responseObject, NSError *error) {
        if (!error) {
            NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            NSArray *resultArray = [resultDictionary objectForKey:@"results"];
            
            if (![resultArray count]) {
                NSLog(@"error : resultArray == nil");
                return;
            }
            
            NSDictionary *infoDict = [resultArray objectAtIndex:0];
            //获取服务器上应用的最新版本号
            NSString *updateVersion = infoDict[@"version"];
            //获取服务器上应用的最新名字
            //        NSString *trackName = infoDict[@"trackName"];
            //获取服务器上应用最新的版本新功能
            //        NSString *note = [infoDict objectForKey:@"releaseNotes"];
            //应用下载页
            self.appStoreUrl = infoDict[@"trackViewUrl"];
            //获取当前设备中应用的版本号
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"] ;
            //判断两个版本是否相同
            if ([updateVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                [self showUpdateView];
            }
            
        }else{
            NSLog(@"%s from appStpre Info error = %@",__FUNCTION__,error);
        }
    }];
}

- (void)showUpdateView
{
    UpdateView *updateView = [[UpdateView alloc] init];
    //设置数据
    if(self.appStoreUrl.length){//AppStore
        updateView.appStoreUrl = self.appStoreUrl;
    }else{//服务端
//         updateView.versionModel =
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabbar = (UITabBarController *)appDelegate.window.rootViewController;
    [tabbar.view addSubview:updateView];
}

@end
