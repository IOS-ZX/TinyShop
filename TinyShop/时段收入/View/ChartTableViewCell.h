//
//  ChartTableViewCell.h
//  TinyShop
//
//  Created by rimi on 2016/12/27.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@end
