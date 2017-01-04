//
//  DetailOrderViewController.h
//  FrameTinyShop
//
//  Created by Mac on 16/12/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipModel.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface DetailOrderViewController : UIViewController

@property (nonatomic,strong) VipModel *vipInfo;

@end
