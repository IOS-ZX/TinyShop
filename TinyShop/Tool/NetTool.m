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
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.requestSerializer.timeoutInterval = 20.0;
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
        if ([responseObject[@"status"] integerValue] == 0) {
            [MBProgressHUD showSuccess:@"加载成功！"];
            success(responseObject);
        }else{
            [MBProgressHUD showError:responseObject[@"errorMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"服务器开小差了。"];
        errors(error);
    }];
}

+ (BOOL)checkRequest:(NSString *)mod_action
      loadingMessage:(NSString *)loadingMessage
           parameter:(NSDictionary *)parameters
             success:(SuccessHandler)success
               error:(ErrorHandler)errors
{
    //获取 suffixUrl
    NSArray *rights = [UserInstance sharedUserInstance].rights;
    NSString *suffixUrl = [self suffixURLBy:mod_action rights:rights];
    if (suffixUrl.length == 0) {
        [MBProgressHUD showError:@"用户没有此权限"];
        return NO;
    }
    [self requestWithURL:suffixUrl
              loadingMsg:loadingMessage
               parameter:parameters
                 success:^(NSDictionary *result) {
                     success(result);
    } error:^(NSError *error) {
        errors(error);
    }];
    return YES;
}

+ (NSString *)suffixURLBy:(NSString *)mod_action
                   rights:(NSArray *)rights
{
    __block NSString *url;
    [rights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"mod_action"] isEqualToString:mod_action]) {
            url = obj[@"mod_params"];
            *stop = YES;
        }
        if (!url && [obj[@"subs"] count] > 0) {
            url = [self suffixURLBy:mod_action rights:obj[@"subs"]];
        }
        if (url.length > 0) {
            *stop = YES;
        }
    }];

    return url;
}

@end
