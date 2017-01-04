//
//  NetTool.h
//  NetWorking
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 iOS-ZX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessHandler)(NSDictionary *result);
typedef void(^ErrorHandler)(NSError *error);

@interface NetTool : NSObject

+ (void)loginWithMessage:(NSString *)loadingMessage
               parameter:(NSDictionary *)parameters
                 success:(SuccessHandler)success
                   error:(ErrorHandler)error;

+ (BOOL)checkRequest:(NSString *)mod_action
      loadingMessage:(NSString *)loadingMessage
           parameter:(NSDictionary *)parameters
             success:(SuccessHandler)success
               error:(ErrorHandler)errors;

+ (void)requestWithURL:(NSString *)suffixURL
                  loadingMsg:(NSString *)loadingMsg
                      params:(NSDictionary *)params
                     success:(SuccessHandler)successHandler
                       error:(ErrorHandler)ErrorHandler;
@end
