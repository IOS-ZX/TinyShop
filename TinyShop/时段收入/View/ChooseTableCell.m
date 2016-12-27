//
//  ChooseTableCell.m
//  TinyShop
//
//  Created by rimi on 2016/12/26.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ChooseTableCell.h"

@implementation ChooseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)choose:(UISwitch*)sender {
    [self.delegate chooseTableItem:self seleted:self.index isSeleted:sender.on];
}

@end
