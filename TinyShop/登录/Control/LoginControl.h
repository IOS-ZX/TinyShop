//
//  LoginControl.h
//  TinyShop
//
//  Created by rimi on 2016/12/22.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginControl : NSObject

+ (void)userLogin:(NSDictionary *)para response:(void(^)(id result,NSError *error))response;

@end
