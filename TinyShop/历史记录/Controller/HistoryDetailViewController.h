//
//  HistoryDetailViewController.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryOrderModel.h"

@interface HistoryDetailViewController : UIViewController

@property (nonatomic,strong) HistoryOrderModel *historyOrder;
@property (nonatomic,strong) NSString *shopName;

@end
