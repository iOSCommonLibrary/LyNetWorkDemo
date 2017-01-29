//
//  LYURLSession.m
//  NetWorkDemo
//
//  Created by 张杰 on 2017/1/21.
//  Copyright © 2017年 张杰. All rights reserved.
//
#define boundary @"uploadBoundary"

#import "LYURLSession.h"

@implementation LYURLSession

+ (instancetype)shareTool
{
    static LYURLSession *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}

/**
 post请求(有请求头Header)
 
 @param url 请求地址url
 @param token 请求头token
 @param keyString 请求参数 : @"vid=1&p=1"
 @param success 成功返回
 @param failure 失败返回
 */
- (void)post:(NSString *)url token:(NSString *)token keyString:(NSString *)keyString success:(void(^)(NSDictionary *dict))success failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //1.请求方式
    request.HTTPMethod = @"POST";
    
    //2.请求头Header
    [request setValue:token forHTTPHeaderField:@"token"];
    
    //3.body
    request.HTTPBody = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    
    //4.发送请求
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            failure(error);
        }
        else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(dict);
        }
        
    }];
    
    //发送请求
    [task resume];
}

/**
 post请求
 
 @param url 请求地址url
 @param keyString 请求参数 : @"vid=1&p=1"
 @param success 成功返回
 @param failure 失败返回
 */
- (void)post:(NSString *)url keyString:(NSString *)keyString success:(void(^)(NSDictionary *dict))success failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //1.请求方式
    request.HTTPMethod = @"POST";
    
    //2.body
    request.HTTPBody = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.发送请求
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            failure(error);
        }
        else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(dict);
        }
        
    }];
    
    //发送请求
    [task resume];
}

/**
 get请求(有请求头Header)
 
 @param url 请求地址url
 @param token 请求头token
 @param keyString 请求参数 : @"vid=1&p=1"
 @param success 成功返回
 @param failure 失败返回
 */
- (void)get:(NSString *)url token:(NSString *)token keyString:(NSString *)keyString success:(void(^)(NSDictionary *dict))success failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //1.请求方式
    request.HTTPMethod = @"GET";
    
    //2.请求头Header
    [request setValue:token forHTTPHeaderField:@"token"];
    
    //3.body
    request.HTTPBody = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    
    //4.发送请求
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            failure(error);
        }
        else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(dict);
        }
        
    }];
    
    //发送请求
    [task resume];
}

/**
 get请求
 
 @param url 请求地址url
 @param keyString 请求参数 : @"vid=1&p=1"
 @param success 成功返回
 @param failure 失败返回
 */
- (void)get:(NSString *)url keyString:(NSString *)keyString success:(void(^)(NSDictionary *dict))success failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //1.请求方式
    request.HTTPMethod = @"GET";
    
    //2.body
    request.HTTPBody = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.发送请求
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            failure(error);
        }
        else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(dict);
        }
        
    }];
    
    //发送请求
    [task resume];
}

/**
 上传图片
 
 @param url 请求地址url
 @param imageName 图片name
 @param key 请求的参数
 @param value 请求的值
 @param uploadKey 图片对应的key
 @param success 成功返回
 @param failure 失败返回
 */
- (void)upLoad:(NSString *)url imageName:(NSString *)imageName key:(NSString *)key value:(NSString *)value uploadKey:(NSString *)uploadKey success:(void(^)(NSDictionary *dict))success failure:(void(^)(NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    request.HTTPMethod = @"POST";
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];//这一行一定不能少，因为后面是转换成JSON发送的
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];
    
//    [request setValue:token forHTTPHeaderField:@"token"];
    
    // 设置请求头
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", boundary]
      forHTTPHeaderField:@"Content-Type"];
    
    // 设置请求文件参数,请求体
//    NSData *formData = [self setBodyData:@"1-1-登录.png" key:@"uid" value:@"1" uploadKey:@"img"];
    NSData *formData = [self setBodyData:imageName key:key value:value uploadKey:uploadKey];
    
    NSURLSessionUploadTask *task = [[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"error   %@",error);
            if (failure) {
                failure(error);
            }
            
        }
        else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"success  %@",dict);
            if (success) {
                success(dict);
            }
        }
        
    }];
    
    [task resume];
}

/**
 拼接请求体body

 @param imageName 图片name
 @param key 请求参数key
 @param value 请求参数key的值
 @param uploadKey 请求图片的key
 @return 请求体body
 */
- (NSData *)setBodyData:(NSString *)imageName key:(NSString *)key value:(NSString *)value uploadKey:(NSString *)uploadKey
{
    // 设置请求文件参数
    NSMutableData *formData = [NSMutableData data];
    
    // 参数,uid = 1
    [formData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",key]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"\r\n%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 文件,后台文件key为img
    [formData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", uploadKey, @"test2.png"] dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //    [formData appendData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HQ_0011" ofType:@"png"]]];
    [formData appendData:UIImageJPEGRepresentation([UIImage imageNamed:imageName], 0.7)];
    [formData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 结束
    [formData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return formData;
}

@end
