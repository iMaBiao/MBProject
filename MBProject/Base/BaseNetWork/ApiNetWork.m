//
//  ApiNetWork.m
//  MBProject
//
//  Created by MaBiao on 2018/4/12.
//  Copyright © 2018年 MaBiao. All rights reserved.
//

#define TimeOutSecs  20.0

#import "ApiNetWork.h"

static NSString * const ApiNetworkCache = @"ApiNetworkCache";//缓存name
static YYCache *_dataCache;
static NSMutableArray *_allSessionTask;//所有请求task


@implementation ApiNetWork

#pragma mark - 初始化 单例
+ (id)instance
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
        //超时时间设置
        _manager.requestSerializer.timeoutInterval = TimeOutSecs;
        //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
        
        //开始监测网络状态
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        //打开状态栏菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        _dataCache = [[YYCache alloc] initWithName:ApiNetworkCache];
        
    }
    return self;
}

/* 所有的请求task数组 */
- (NSMutableArray *)allSessionTask{
    if (!_allSessionTask) {
        _allSessionTask = [NSMutableArray array];
    }
    return _allSessionTask;
}


/** GET请求 */
- (void)GETWithURL:(NSString *)url
        parameters:(NSDictionary *)parameters
       cachePolicy:(MBCachePolicy)cachePolicy
          callback:(MBHttpRequest)callback
{
    [self HTTPWithMethod: MBRequestMethodGET url: url parameters: parameters cachePolicy: cachePolicy callback:callback];
}

/** POST请求 */
- (void)POSTWithURL:(NSString *)url
         parameters:(NSDictionary *)parameters
        cachePolicy:(MBCachePolicy)cachePolicy
           callback:(MBHttpRequest)callback
{
    [self HTTPWithMethod:MBRequestMethodPOST url:url parameters:parameters cachePolicy:cachePolicy callback:callback];
}

/// 缓存策略处理
- (void)HTTPWithMethod:(MBRequestMethod)method
                   url:(NSString *)url
            parameters:(NSDictionary *)parameters
           cachePolicy:(MBCachePolicy)cachePolicy
              callback:(MBHttpRequest)callback
{
    
    if (cachePolicy == MBCachePolicyIgnoreCache) {
        //只从网络获取数据，且数据不会缓存在本地
        [self httpWithMethod: method url:url parameters: parameters callback:callback];
    }else if (cachePolicy == MBCachePolicyCacheOnly){
        //只从缓存读数据，如果缓存没有数据，返回一个空。
        [self httpCacheForURL:url parameters:parameters withBlock:^(id<NSCoding> object) {
            callback ? callback(object, nil) : nil;
        }];
    }else if (cachePolicy == MBCachePolicyNetworkOnly){
        //先从网络获取数据，同时会在本地缓存数据
        [self httpWithMethod:method url:url parameters:parameters callback:^(id responseObject, NSError *error) {
            [self setHttpCache:responseObject url:url parameters:parameters];
            callback ? callback(responseObject, error) : nil;
        }];
        
    }else if (cachePolicy == MBCachePolicyCacheElseNetwork){
        //先从缓存读取数据，如果没有再从网络获取
        [self httpCacheForURL:url parameters:parameters withBlock:^(id<NSCoding> object) {
            if (object) {
                callback ? callback(object, nil) : nil;
            }else{
                [self httpWithMethod:method url:url parameters:parameters callback:^(id responseObject, NSError *error) {
                    callback ? callback(responseObject, error) : nil;
                }];
            }
        }];
    }else if (cachePolicy == MBCachePolicyNetworkElseCache){
        //先从网络获取数据，如果没有，此处的没有可以理解为访问网络失败，再从缓存读取
        [self httpWithMethod:method url:url parameters:parameters callback:^(id responseObject, NSError *error) {
            if (responseObject && !error) {
                callback ? callback(responseObject, error) : nil;
            }else{
                [self httpCacheForURL:url parameters:parameters withBlock:^(id<NSCoding> object) {
                    callback ? callback(object, nil) : nil;
                }];
            }
        }];
    }else if (cachePolicy == MBCachePolicyCacheThenNetwork){
        //先从缓存读取数据，然后在本地缓存数据，无论结果如何都会再次从网络获取数据，在这种情况下，Block将产生两次调用
        [self httpCacheForURL:url parameters:parameters withBlock:^(id<NSCoding> object) {
            callback ? callback(object, nil) : nil;
            [self httpWithMethod:method url:url parameters:parameters callback:^(id responseObject, NSError *error) {
                [self setHttpCache:responseObject url:url parameters:parameters];
                callback ? callback(responseObject, error) : nil;
            }];
        }];
    }else{
        //缓存策略错误，将采取 HJCachePolicyIgnoreCache 策略
        NSLog(@"缓存策略错误");
        [self httpWithMethod:method url:url parameters:parameters callback:callback];
    }
}

#pragma mark -- 上传文件
- (void)uploadFileWithURL:(NSString *)url parameters:(NSDictionary *)parameters name:(NSString *)name filePath:(NSString *)filePath progress:(MBHttpProgress)progress callback:(MBHttpRequest)callback
{
    NSURLSessionTask *sessionTask = [_manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //添加-文件
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        callback ? callback(responseObject, nil) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        callback ? callback(nil, error) : nil;
    }];
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
}


#pragma mark -- 上传图片文件
- (void)uploadImageURL:(NSString *)url parameters:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(MBHttpProgress)progress callback:(MBHttpRequest)callback;
{
    NSURLSessionTask *sessionTask = [_manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType ? mimeType : @"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        callback ? callback(responseObject, nil) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[self allSessionTask] removeObject:task];
        callback ? callback(nil, error) : nil;
    }];
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
}

#pragma mark -- 下载文件
- (void)downloadWithURL:(NSString *)url fileDir:(NSString *)fileDir progress:(MBHttpProgress)progress callback:(MBHttpDownload)callback
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __block NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建DownLoad目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allSessionTask] removeObject:downloadTask];
        if (callback && error) {
            callback ? callback(nil, error) : nil;
            return;
        }
        callback ? callback(filePath.absoluteString, nil) : nil;
    }];
    //开始下载
    [downloadTask resume];
    
    //添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil;
}

#pragma mark -- 网络请求处理
- (void)httpWithMethod:(MBRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters callback:(MBHttpRequest)callback{
    
    [self dataTaskWithHTTPMethod:method url:url parameters:parameters callback:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        [[self allSessionTask] removeObject:task];
        callback ? callback(responseObject, nil) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callback ? callback(nil, error) : nil;
        [[self allSessionTask] removeObject:task];
    }];
}

- (void)dataTaskWithHTTPMethod:(MBRequestMethod)method url:(NSString *)url parameters:(NSDictionary *)parameters
                     callback:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))callback
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionTask *sessionTask;
    if (method == MBRequestMethodGET){
        sessionTask = [_manager GET:url parameters:parameters progress:nil success:callback failure:failure];
    }else if (method == MBRequestMethodPOST) {
        sessionTask = [_manager POST:url parameters:parameters progress:nil success:callback failure:failure];
    }
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
}


#pragma mark - 网络状态部分
/*实时获取网络状态*/
- (void)getNetworkStatusWithBlock:(MBNetworkStatus)networkStatus{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(MBNetworkStatusUnknown) : nil;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(MBNetworkStatusNotReachable) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(MBNetworkStatusReachableWWAN) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(MBNetworkStatusReachableWiFi) : nil;
                    break;
                default:
                    break;
            }
        }];
    });
}

/*判断是否有网*/
- (BOOL)isNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

/*是否是手机网络*/
- (BOOL)isWWANNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

/*是否是WiFi网络*/
- (BOOL)isWiFiNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/*取消所有Http请求*/
- (void)cancelAllRequest{
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}
/*取消指定URL的Http请求*/
- (void)cancelRequestWithURL:(NSString *)url{
    if (!url) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:url]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}
/**设置请求超时时间(默认30s) */
- (void)setRequestTimeoutInterval:(NSTimeInterval)time{
    _manager.requestSerializer.timeoutInterval = time;
    
}
/**是否打开网络加载菊花(默认打开)*/
- (void)openNetworkActivityIndicator:(BOOL)open{
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:open];
}


#pragma mark -- 网络缓存
+ (YYCache *)getYYCache
{
    return _dataCache;
}

- (void)setHttpCache:(id)httpData url:(NSString *)url parameters:(NSDictionary *)parameters
{
    if (httpData) {
        NSString *cacheKey = [self cacheKeyWithURL:url parameters:parameters];
        [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
    }
}

- (void)httpCacheForURL:(NSString *)url parameters:(NSDictionary *)parameters withBlock:(void(^)(id responseObject))block
{
    NSString *cacheKey = [self cacheKeyWithURL:url parameters:parameters];
    [_dataCache objectForKey:cacheKey withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(object);
        });
    }];
}

- (NSString *)cacheKeyWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    if(!parameters){return url;};
    
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",url,paraString];
    
    return cacheKey;
}

- (void)setCostLimit:(NSInteger)costLimit
{
    [_dataCache.diskCache setCostLimit:costLimit];//磁盘最大缓存开销
}

- (NSInteger)getAllHttpCacheSize
{
    return [_dataCache.diskCache totalCost];
}

- (void)getAllHttpCacheSizeBlock:(void(^)(NSInteger totalCount))block
{
    return [_dataCache.diskCache totalCountWithBlock:block];
}

- (void)removeAllHttpCache
{
    [_dataCache.diskCache removeAllObjects];
}

- (void)removeAllHttpCacheBlock:(void(^)(int removedCount, int totalCount))progress
                       endBlock:(void(^)(BOOL error))end
{
    [_dataCache.diskCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

/*json转字符串*/
- (NSString *)jsonToString:(id)data
{
    if(!data){ return @"空"; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark -- HTTPS 证书验证
- (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName{
    
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //使用证书验证模式
    AFSecurityPolicy *securitypolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //如果需要验证自建证书(无效证书)，需要设置为YES
    securitypolicy.allowInvalidCertificates = YES;
    //是否需要验证域名，默认为YES
    securitypolicy.validatesDomainName = validatesDomainName;
    securitypolicy.pinnedCertificates = [[NSSet alloc]initWithObjects:cerData, nil];
    [_manager setSecurityPolicy:securitypolicy];
}
 
@end

