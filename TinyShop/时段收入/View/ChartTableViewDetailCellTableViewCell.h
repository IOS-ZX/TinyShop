//
//  ChartTableViewDetailCellTableViewCell.h
//  TinyShop
//
//  Created by rimi on 2016/12/28.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartTableViewDetailCellTableViewCell : UITableViewCell

/** title **/
@property(nonatomic,strong)UILabel *titleLabel;
/** value **/
@property(nonatomic,strong)UILabel *valueLabel;
/** sumValue **/
@property(nonatomic,assign)CGFloat sumValue;
/** value **/
@property(nonatomic,assign)CGFloat value;
/** color **/
@property(nonatomic,assign)UIColor *color;

@end
