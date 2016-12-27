//
//  ChooseTableCell.h
//  TinyShop
//
//  Created by rimi on 2016/12/26.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseTableCellDelegate <NSObject>

- (void)chooseTableItem:(UITableViewCell *)cell seleted:(NSInteger)index isSeleted:(BOOL)isSeleted;

@end

@interface ChooseTableCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISwitch *chooseSwitch;

/** 代理 **/
@property(nonatomic,assign)id<ChooseTableCellDelegate> delegate;
/** 下标 **/
@property(nonatomic,assign)NSInteger index;

@end
