//
//  DailyDetailViewController.h
//  TinyShop
//
//  Created by rimi on 2016/12/30.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ViewController.h"
#import "DailyTimeControll.h"

@interface DailyDetailViewController : UIViewController

/** id **/
@property(nonatomic,strong)NSString *shopId;
/** date **/
@property(nonatomic,strong)NSString *date;
/** dataType **/
@property(nonatomic,assign)RequestDataType dataType;
/** queryType **/
@property(nonatomic,assign)RequestQueryType queryType;

@end
