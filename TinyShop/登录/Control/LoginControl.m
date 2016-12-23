//
//  LoginControl.m
//  TinyShop
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "LoginControl.h"

@implementation LoginControl

+ (void)userLogin:(NSDictionary *)para response:(void (^)(id, NSError *))response{
    [NetTool loginWithMessage:@"登录中.." parameter:para success:^(NSDictionary *result) {
        response(result,nil);
    } error:^(NSError *error) {
        response(nil,error);
    }];
}

@end
