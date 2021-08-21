//
//  CCFetchTool.m
//  StudentApp
//
//  Created by huangchuanfeng on 2018/8/23.
//  Copyright © 2018年 chuanfeng. All rights reserved.
//

#import "CCFetchTool.h"
#import "SVProgressHUD.h"
//#import "HBRSAHandler.h"
//#import "RSAA.h"

//开发服务器
static NSString * const DTBaseURLString = HOST_URL;
//正式服务器
//static NSString * const TKBaseURLString = @"";

static NSString * const kAFNetworkingLockName = @"com.alamofire.networking.operation.lock";


@interface CCFetchTool ()

@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

@end


@implementation CCFetchTool
@synthesize outputStream = _outputStream;

/**
 *  建立网络请求单例
 */
+ (instancetype)sharedClient
{
    static CCFetchTool *_sharedClient;
    static dispatch_once_t onceToken;
    
    __weak CCFetchTool *weakSelf = _sharedClient;
    dispatch_once(&onceToken, ^{
        if (_sharedClient == nil) {
            _sharedClient = [[CCFetchTool alloc] init];
            weakSelf.lock = [[NSRecursiveLock alloc] init];
            weakSelf.lock.name = kAFNetworkingLockName;
        }
    });
    return _sharedClient;
}


- (void)PPOST:(NSString *)url
  parameters:(NSArray *)parameters
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",DTBaseURLString,url];
    //
    //    NSLog(@"请求参数====================%@",body);
    NSString *str = TOKEN;
    //    if (str.length > 0)
    //    {
    //        [body setValue:TOKEN forKey:@"token"];
    //    }
    
    NSError *error;
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrl parameters:nil error:nil];
    
    [req setTimeoutInterval:10];
    
    [req setValue:str forHTTPHeaderField:@"Authorization"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
//            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
//                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//                return ;
//            }
            success(responseObject);
        }
        else
        {
            failure(responseObject);
        }
    }] resume];
}

/*
    更新 post请求 --陈剑英
 */
- (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",DTBaseURLString,url];
    NSLog(@"请求url = %@",fullUrl);
    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:parameters];
//
//    NSLog(@"请求参数====================%@",body);
    NSString *str = TOKEN;
//    if (str.length > 0)
//    {
//        [body setValue:TOKEN forKey:@"token"];
//    }
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrl parameters:nil error:nil];
    
    [req setTimeoutInterval:10];
    
    [req setValue:str forHTTPHeaderField:@"Authorization"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
//            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
//                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//                return ;
//            }
            success(responseObject);            
        }
        else
        {
            NSString *code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"invalid_token"])
            {
                NSNotification *notification =[NSNotification notificationWithName:@"Invalid_token" object:@"invalid_token" userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"authorization"];
                return ;
            }
            
            failure(responseObject);
        }
            
        
    }] resume];
}


/*
 更新 get请求 --陈剑英
 */
- (void)GET:(NSString *)url
  parameters:(NSDictionary *)parameters
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure
{
//    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",DTBaseURLString,url];
//    NSLog(@"GET  ---fullURL ==%@",fullUrl);
    NSString *str = TOKEN;
    //    if (str.length > 0)
    //    {
    //        [body setValue:TOKEN forKey:@"token"];
    //    }
    
//    NSError *error;
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
//    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:nil error:nil];
    
    //请求对象
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    //请求方式
    [req setHTTPMethod:@"GET"];
    
    
    //req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setTimeoutInterval:10];
    
    [req setValue:str forHTTPHeaderField:@"Authorization"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
//    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
//
            //            NSLog(@"Reply JSON: %@", responseObject);
//            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
//                [DTProgressHUD dismiss];
//                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
//
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//                return ;
//            }
            success(responseObject);
            
        }
        else
        {
            NSString *code = [responseObject objectForKey:@"code"];
            if ([code isEqualToString:@"invalid_token"])
            {
                NSNotification *notification =[NSNotification notificationWithName:@"Invalid_token" object:@"invalid_token" userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"authorization"];
                return ;
            }
            
            failure(responseObject);
            //            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];
}



/**
 *  GET请求
 */
- (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Success:(void (^)(id))success Failure:(void (^)(NSError *))failure{
    
    //网络检查
    if ([[CCFetchTool sharedClient] checkingNetwork] == StatusNotReachable) {
        [SVProgressHUD showProgress:1.5 status:@"网络连接失败"];
        return;
    }
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    //使用AFNetworking进行网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //因为服务器返回的数据如果不是application/json格式的数据
    //需要以NSData的方式接收,然后自行解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.requestSerializer.timeoutInterval = 10;
    //发起get请求
    NSMutableDictionary *mutParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSString *str = TOKEN;
    if (str.length > 0) {
        [mutParameters setValue:TOKEN forKey:@"Authorization"];
    }
    
    [manager GET:url parameters:mutParameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //将返回的数据转成json数据格式
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
        //通过block，将数据回掉给用户
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //通过block,将错误信息回传给用户
        if (failure) {
            failure(error);
        }
    }];
}


/**
 *  POST请求
 */
- (void)Post:(NSString *)url
  Parameters:(NSDictionary *)parameters
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure
{
    //将baseUrl和接口关键词 进行拼接组成完整请求连接
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",DTBaseURLString,url];
    //网络检查
    if ([[CCFetchTool sharedClient] checkingNetwork] == StatusNotReachable) {
        //        [ETPublic showHUDWithTitle:@"网络连接失败"];
        return;
    }
    //断言
    NSAssert(baseUrl != nil, @"url不能为空");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"Authorization"];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",nil];
    manager.requestSerializer.timeoutInterval = 20;
    
    //添加签名
    //    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    //    long long int date = (long long int)time;
    //    NSString *dateStr = [NSString stringWithFormat:@"%lld",date];
    //
    //    NSMutableDictionary *parametersCopy = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //    [parametersCopy setValue:dateStr forKey:@"timestamp"];
    //
    //    NSArray *dicArr = [parametersCopy allKeys];
    //    NSArray *newArray = [dicArr sortedArrayUsingSelector:@selector(compare:)];
    //
    //    NSMutableDictionary *mutParameters = [[NSMutableDictionary alloc] init];
    //    for (int i = 0; i < newArray.count; i++) {
    //        [mutParameters setObject:[parametersCopy valueForKey:newArray[i]] forKey:newArray[i]];
    //    }
    //    NSString *str = [NSString stringWithFormat:@"%@=%@",newArray.firstObject,[mutParameters valueForKey:newArray.firstObject]];
    //    if (newArray.count > 1) {
    //        for (int i =1; i < newArray.count; i++) {
    //            str = [NSString stringWithFormat:@"%@&%@=%@",str,newArray[i],[mutParameters valueForKey:newArray[i]]];
    //        }
    //    }
    //    HBRSAHandler* handler = [HBRSAHandler new];
    //    [handler importKeyWithType:KeyTypePrivate andkeyString:PrivateKeyO2O];
    ////    [handler importKeyWithType:KeyTypePublic andkeyString:PublicKeyO2O];
    //
    //    NSString* sigMd5 = [handler signMD5String:str];
    //    if (sigMd5.length > 0) {
    //        [mutParameters setObject:sigMd5 forKey:@"sign"];
    //    }
    //    BOOL isMatchMd5 = [handler verifyMD5String:str withSign:sigMd5];//用公钥验证生成的私钥是否正确
    //签名结束
    [manager POST:baseUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress)
     {
         //不需要实现进度条
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //        NSLog(@"+++responseObject%@",responseObject);
         //通过block，将数据回掉给用户
         //解密
         //        NSString *longStr = [responseObject valueForKey:@"data"];
         //        NSString *decWithPrivKey = [RSAA decryptString:longStr privateKey:PrivateKeyO2O];
         //        NSDictionary *dic = [self dictionaryWithJsonString:decWithPrivKey];
         //        NSMutableDictionary *mutResponseObject = [NSMutableDictionary dictionaryWithDictionary:responseObject];
         //        [mutResponseObject setObject:dic forKey:@"data"];
         //         if ([[[responseObject valueForKey:@"result"]objectForKey:@"success"] isEqualToString:@"1"])
         //         {
         //             success(responseObject);
         //         }
         //         else
         //         {
         //         NSData *data = (NSData *)responseObject;
         //         id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         success(responseObject);
         //         }
         //             NSString *codeStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"LoginCode"];
         //             NSDictionary *_dic = @{@"code":codeStr};
         //             [self POst:API_LOGIN_GETTOKEN Parameters:_dic Success:^(id response)
         //             {
         //                 if ([[response valueForKey:@"result"] integerValue] == 1) {
         //                     [[NSUserDefaults standardUserDefaults] setObject:[response objectForKey:@"token"] forKey:@"USERID"];
         //                     [mutParameters setValue:USERID forKey:@"token"];
         //                     if ([mutParameters valueForKey:@"sign"] != nil || [mutParameters objectForKey:@"timestamp"] != nil) {
         //                         [mutParameters removeObjectForKey:@"sign"];
         //                         [mutParameters removeObjectForKey:@"timestamp"];
         //                     }
         //                     //添加签名
         //                     [self POst:url Parameters:mutParameters Success:success Failure:failure];
         //                 }
         //             } Failure:^(NSError *error) {
         //                 failure(error);
         //             }];
         
         //解密完成
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         //通过block,将错误信息回传给用户
         failure(error);
     }];
}


/**
 *  上传图片文件
 */
- (void)Post:(NSString *)url
   Parameter:(NSDictionary *)parameter
  imageArray:(NSMutableArray *)fileDataArray
     Success:(void (^)(id))success
     Failure:(void (^)(NSError *))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",DTBaseURLString,url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"Authorization"];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //签名结束
    [manager POST:fullUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         for (NSData *data in fileDataArray) {
             NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
             formatter.dateFormat=@"yyyyMMddHHmmss";
             NSString *str=[formatter stringFromDate:[NSDate date]];
             NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
             [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
         }
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         //不需要实现进度条
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
         //将返回的数据转成json数据格式
         success(responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         //通过block,将错误信息回传给用户
//         NSString *code = [responseObject objectForKey:@"code"];
//         if ([code isEqualToString:@"invalid_token"])
//         {
//             NSNotification *notification =[NSNotification notificationWithName:@"Invalid_token" object:@"invalid_token" userInfo:nil];
//             [[NSNotificationCenter defaultCenter] postNotification:notification];
//             
//             return ;
//         }
         
         failure(error);
     }];
}

/**
 *  上传音频
 */
- (void)Post:(NSString *)url
   Parameter:(NSDictionary *)parameter
  mp3Array:(NSMutableArray *)fileDataArray
     Success:(void (^)(id))success
     Failure:(void (^)(NSError *))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",DTBaseURLString,url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"Authorization"];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //签名结束
    [manager POST:fullUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
 
         for (NSData *data in fileDataArray)
         {
             NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
             formatter.dateFormat=@"yyyyMMddHHmmss";
             NSString *str=[formatter stringFromDate:[NSDate date]];
             NSString *fileName=[NSString stringWithFormat:@"%@.mp3",str];
             [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"mp4/mp3"];


         }
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         //不需要实现进度条
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         //NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
         //将返回的数据转成json数据格式
         success(responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         //通过block,将错误信息回传给用户
         failure(error);
     }];
}


/**
 *  下载文件
 */
- (void)downloadFileWithRequestUrl:(NSString *)url
                         Parameter:(NSDictionary *)patameter
                         SavedPath:(NSString *)savedPath
                          Complete:(void (^)(NSData *data, NSError *error))complete
                          Progress:(void (^)(NSProgress *downloadProgress, double progressValue))progress{
    //网络检查
    if ([[CCFetchTool sharedClient] checkingNetwork] == StatusNotReachable) {
//        [ETPublic showHUDWithTitle:@"网络连接失败"];
        return;
    }
    
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //AFN3.0URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"downloadProgress:%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
        double progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        
        progress(downloadProgress, progressValue);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        //        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        //        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        //        NSLog(@"下载地址11111111:%@",path);
        //        return [NSURL fileURLWithPath:savedPath != nil ? savedPath : path];
        
        //下载文件应该存在这里
        NSURL *downUrl = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [downUrl URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // filePath就是下载文件的位置，可以直接拿来使用
        NSData *data = [NSData dataWithContentsOfURL:filePath];
        NSLog(@"下载地址:%@",filePath);
        complete(data, error);
        
    }];
    
    //默认下载操作是挂起的，须先手动恢复下载。
    [downloadTask resume];
}


/**
 *  NSData上传文件
 */
- (void)updataDataWithRequestStr:(NSString *)str
                        FromData:(NSData *)fromData
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion{
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager uploadTaskWithRequest:request fromData:fromData progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        completion(responseObject,error);
    }];
}


/**
 *  NSURL上传文件
 */
- (void)updataFileWithRequestStr:(NSString *)str
                        FromFile:(NSURL *)fromUrl
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",DTBaseURLString,str];

    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager uploadTaskWithRequest:request fromFile:fromUrl progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        completion(responseObject,error);
    }];
}


/**
 *   监听网络状态的变化
 */
- (NetworkStatus)checkingNetwork{
    
    __block NSInteger statusTag = 0;
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager manager];
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusUnknown) {
            
            statusTag = StatusUnknown;
            
        }else if (status == AFNetworkReachabilityStatusNotReachable){
            
            statusTag = StatusNotReachable;
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            
            statusTag = StatusReachableViaWWAN;
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            
            statusTag = StatusReachableViaWiFi;
            
        }
    }];
    return statusTag;
}


/**
 *   取消所有正在执行的网络请求项
 */
- (void)cancelAllNetworkingRequest{
    
    //开发中...
}


- (NSOutputStream *)outputStream {
    if (!_outputStream) {
        self.outputStream = [NSOutputStream outputStreamToMemory];
    }
    
    return _outputStream;
}


- (void)setOutputStream:(NSOutputStream *)outputStream {
    [self.lock lock];
    if (outputStream != _outputStream) {
        if (_outputStream) {
            [_outputStream close];
        }
        _outputStream = outputStream;
    }
    [self.lock unlock];
}


- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix{
    NSString    *result;
    NSString    *newResult;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    newResult = [NSString stringWithFormat:@"%@",uuidStr];
    NSLog(@"-----%@----",newResult);
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

//字符串转json
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
