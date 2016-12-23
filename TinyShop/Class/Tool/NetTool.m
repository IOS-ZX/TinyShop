//
//  NetTool.m
//  NetWorking
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 iOS-ZX. All rights reserved.
//

#import "NetTool.h"
#import "UserInstance.h"
#import "TQConst.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"

@implementation NetTool

+ (void)loginWithMessage:(NSString *)loadingMessage
               parameter:(NSDictionary *)parameters
                 success:(SuccessHandler)success
                   error:(ErrorHandler)errors
{
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionary];
    [mutableParams setObject:@"ios" forKey:@"client_type"];
    [mutableParams setObject:@"2.0" forKey:@"client_version"];
    [mutableParams setObject:@"2a8242f0858bbbde9c5dcbd0a0008e5a" forKey:@"client_token"];
    [mutableParams addEntriesFromDictionary:parameters];
    [self requestWithURL:LOGIN_URL loadingMsg:loadingMessage parameter:mutableParams success:^(NSDictionary *result) {
        success(result);
    } error:^(NSError *error) {
        errors(error);
    }];
    
}

+ (void)requestWithURL:(NSString *)suffUrl
            loadingMsg:(NSString *)msg
             parameter:(NSDictionary *)parameters
               success:(SuccessHandler)success
                 error:(ErrorHandler)errors
{
    NSString *url;
    if ([suffUrl rangeOfString:LOGIN_URL].length == 0) {
        url = [NSString stringWithFormat:@"%@?%@",suffUrl,[UserInstance sharedUserInstance].getParamsString];
    }else{
        url = suffUrl;
    }
    //部分URL已经包含了前缀 http
    if ([url rangeOfString:@"http"].length == 0) {
        url = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 10.0;
    // HTTPS
    //允许无效或非法证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    //不验证域名
    manager.securityPolicy.validatesDomainName = NO;
    //显示
    if (msg.length > 0) {
        [MBProgressHUD showMessage:msg];
    }
    NSLog(@"%@",url);
    NSLog(@"%@",parameters);
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        errors(error);
    }];
}

@end
