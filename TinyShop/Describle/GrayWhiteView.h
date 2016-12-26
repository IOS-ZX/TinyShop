//
//  GrayWhiteView.h
//  TinyShop_x
//
//  Created by MrZhao on 16/12/23.
//  Copyright © 2016年 MrZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrayWhiteView : UIView

@property (nonatomic,assign) CGFloat single_width;
@property (nonatomic,assign) NSInteger count;

-(instancetype)initWithFrame:(CGRect)frame
                 singleWidth:(CGFloat)width
                       count:(NSInteger)count;
@end
