//
//  ApiManager.m
//  AFNetWorking库初试
//
//  Created by 陈剑英 on 18/01/07.
//  Copyright © 2018年 陈剑英 All rights reserved.
//

#import "ApiManager.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "SizeHeader.h"

/*
    http://120.78.172.212:3000/api/class/all1
    域名：端口号/接口具体地址
 */
static NSString * const BaseURLString = @"http://120.78.172.212:3000/";


static ApiManager *mInstance;

@implementation ApiManager
+ (ApiManager *)shareInstance {
    if (nil == mInstance) {
        mInstance = [[ApiManager alloc] init];
    }
    return mInstance;
}


/*
 更新 post请求 --陈剑英
 */
- (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(id error))failure
{
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",BaseURLString,url];
    NSLog(@"请求url = %@",fullUrl);
    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    NSString *str = TOKEN;
    
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:fullUrl parameters:nil error:nil];
    
    [req setTimeoutInterval:10];
    
//    [req setValue:str forHTTPHeaderField:@"token"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            //做是否需要重新登录的判断，其实就是验证token有效性
            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                return ;
            }
            success(responseObject);
        }
        else
        {
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
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",BaseURLString,url];

    NSString *str = TOKEN;
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    
    //请求对象
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    //请求方式
    [req setHTTPMethod:@"GET"];
    
    
    //req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setTimeoutInterval:10];
    
//    [req setValue:str forHTTPHeaderField:@"token"];//添加token
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            //
            //            NSLog(@"Reply JSON: %@", responseObject);
            if (![responseObject[@"result"][@"success"] boolValue] && [responseObject[@"result"][@"code"] intValue]== 909) {
//                [DTProgressHUD dismiss];
                NSNotification *notification =[NSNotification notificationWithName:@"relogin" object:nil userInfo:nil];
                
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                return ;
            }
            success(responseObject);
            
        }
        else
        {
            failure(responseObject);
            //            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];
}


@end
