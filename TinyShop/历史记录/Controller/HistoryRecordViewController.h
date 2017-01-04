//
//  HistoryRecordViewController.h
//  FrameTinyShop
//
//  Created by Mac on 17/1/2.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryDetailModel.h"

@interface HistoryRecordViewController : UIViewController

@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *shop_id;
@property (nonatomic,strong) NSString *dinner;
@property (nonatomic,strong) HistoryDetailModel *model;

@end
