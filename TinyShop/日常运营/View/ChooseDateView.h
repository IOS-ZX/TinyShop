//
//  ChooseDateView.h
//  TinyShop
//
//  Created by rimi on 2016/12/29.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyTimeControll.h"

typedef void(^ChooseDate)(RequestQueryType type, NSString* value);

@interface ChooseDateView : UIView

/** 选中回调 **/
@property(nonatomic,copy)ChooseDate dates;


- (NSArray*)getDay:(NSString*)year month:(NSString*)month;

@end
