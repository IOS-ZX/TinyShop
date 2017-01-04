//
//  OnlyChooseDate.h
//  TinyShop
//
//  Created by rimi on 2017/1/4.
//  Copyright © 2017年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OnlyChooseDateDelegate <NSObject>

- (void)chooseDatesOnlyForDate:(NSString*)date;

@end

@interface OnlyChooseDate : UIView

/** 代理 **/
@property(nonatomic,assign)id<OnlyChooseDateDelegate> delegate;

@end
