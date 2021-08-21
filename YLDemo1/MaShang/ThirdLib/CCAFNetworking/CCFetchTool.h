//
//  CCFetchTool.h
//  StudentApp
//
//  Created by huangchuanfeng on 2018/8/23.
//  Copyright © 2018年 chuanfeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

//#define HOMEURL @"http://192.168.102.141:8999/tap/"//测试
//#define NETURL @"http://192.168.102.86:8999/tap/" //正式
//#define URL_PATH(url) [HOMEURL stringByAppendingString:url]
//#define NETURL_PATH(url) [HOMEURL stringByAppendingString:url]

typedef enum : NSInteger{
    
    StatusUnknown = 0,//未知状态
    StatusNotReachable,//无网状态
    StatusReachableViaWWAN,//手机网络
    StatusReachableViaWiFi,//Wifi网络
    
} NetworkStatus;

@interface CCFetchTool : AFHTTPSessionManager

@property (nonatomic, assign) NetworkStatus netStatus;
@property (nonatomic, strong) NSOutputStream *outputStream;

/**
 *  建立网络请求单例
 */
+ (instancetype)sharedClient;

/**
 *  GET请求
 *
 *  @param url        请求接口
 *  @param parameters 向服务器请求时的参数
 *  @param success    请求成功，block的参数为服务返回的数据
 *  @param failure    请求失败，block的参数为错误信息
 */
- (void)GET:(NSString *)url
 Parameters:(NSDictionary *)parameters
    Success:(void(^)(id responseObject))success
    Failure:(void (^)(NSError *error))failure;


/*
 更新 post请求 --陈剑英
 */
- (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure;

- (void)PPOST:(NSString *)url
   parameters:(NSArray *)parameters
      Success:(void(^)(id responseObject))success
      Failure:(void(^)(id error))failure;
/*
 更新 get请求 --陈剑英
 */
- (void)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
    Success:(void(^)(id responseObject))success
    Failure:(void(^)(id error))failure;

/*
 上传图片文件
 */
- (void)Post:(NSString *)url
   Parameter:(NSDictionary *)parameter
    mp3Array:(NSMutableArray *)fileDataArray
     Success:(void (^)(id))success
     Failure:(void (^)(NSError *))failure;

/**
 *  POST请求
 *
 *  @param url        要提交的数据结构
 *  @param parameters 要提交的数据
 *  @param success    成功执行，block的参数为服务器返回的内容
 *  @param failure    执行失败，block的参数为错误信息
 */
//- (void)Post:(NSString *)url
//  Parameters:(NSDictionary *)parameters
//     Success:(void(^)(id responseObject))success
//     Failure:(void(^)(NSError *error))failure;

/**
 *  向服务器上传文件
 *
 *  @param url       要上传的文件接口
 *  @param parameter 上传的参数
 *  @param fileDataArray  上传的文件\数据
 *  @param success   成功执行，block的参数为服务器返回的内容
 *  @param failure   执行失败，block的参数为错误信息
 */
- (void)Post:(NSString *)url
   Parameter:(NSDictionary *)parameter
  imageArray:(NSMutableArray *)fileDataArray
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;

/**
 *  下载文件
 *
 *  @param url       下载地址
 *  @param patameter 下载参数
 *  @param savedPath 保存路径
 *  @param complete  下载成功返回文件：NSData
 *  @param progress  设置进度条的百分比：progressValue
 */
- (void)downloadFileWithRequestUrl:(NSString *)url
                         Parameter:(NSDictionary *)patameter
                         SavedPath:(NSString *)savedPath
                          Complete:(void (^)(NSData *data, NSError *error))complete
                          Progress:(void (^)(NSProgress *downloadProgress, double progressValue))progress;

/**
 *  NSData上传文件
 *
 *  @param str        目标地址
 *  @param fromData   文件源
 *  @param progress   实时进度回调
 *  @param completion 完成结果
 */
- (void)updataDataWithRequestStr:(NSString *)str
                        FromData:(NSData *)fromData
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion;


/**
 *  NSURL上传文件
 *
 *  @param str        目标地址
 *  @param fromUrl    文件源
 *  @param progress   实时进度回调
 *  @param completion 完成结果
 */
- (void)updataFileWithRequestStr:(NSString *)str
                        FromFile:(NSURL *)fromUrl
                        Progress:(void(^)(NSProgress *uploadProgress))progress
                      Completion:(void(^)(id object,NSError *error))completion;

/**
 *   监听网络状态的变化
 */
- (NetworkStatus)checkingNetwork;

@end



