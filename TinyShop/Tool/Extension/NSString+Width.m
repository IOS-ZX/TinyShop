//
//  NSString+Width.m
//  TinyShop
//
//  Created by rimi on 2016/12/23.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "NSString+Width.h"

@implementation NSString (Width)

- (CGFloat)getStringWidth{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(0, 40) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.width;
}

@end
