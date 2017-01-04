//
//  TypeTableViewCell.m
//  FrameTinyShop
//
//  Created by Mac on 16/12/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "TypeTableViewCell.h"
#import "Masonry.h"

@interface TypeTableViewCell()
<
UITableViewDelegate,
UITableViewDataSource
>
//第二个颜色
@property (nonatomic,strong)UIColor *secondColor;
//第三个颜色
@property (nonatomic,strong)UIColor *thirdColor;
@end

@implementation TypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.detialLabel];
        [self.contentView addSubview:self.typeBackground];
        [self.typeBackground addSubview:self.typeLabel];
        [self.contentView addSubview:self.goodsTableView];
        
        __weak typeof(self) weakSelf = self;
        
        [self.detialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(5);
            make.top.equalTo(weakSelf.mas_top);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
        }];
        [self.typeBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.contentView).multipliedBy(0.12);
            make.bottom.equalTo(weakSelf.contentView).offset(-10);
            make.left.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.detialLabel.mas_bottom);
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(15);
            make.height.equalTo(weakSelf.typeBackground);
            make.center.equalTo(weakSelf.typeBackground);
        }];
        
        
        [self.goodsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.typeBackground.mas_right).offset(5);
            make.right.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.typeBackground);
            make.bottom.equalTo(weakSelf.typeBackground);
        }];
    }
    return self;
}
#pragma mark- Getter
-(UIView *)typeBackground
{
    if (!_typeBackground) {
        _typeBackground = [[UIView alloc]init];
    }
    return _typeBackground;
}
-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.numberOfLines = 0;
        _typeLabel.backgroundColor = [UIColor clearColor];
    }
    return _typeLabel;
}
-(UILabel *)detialLabel
{
    if (!_detialLabel) {
        _detialLabel = [[UILabel alloc]init];
        _detialLabel.textColor = [UIColor redColor];
        _detialLabel.text = @"订单详情";
        _detialLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detialLabel;
}
-(UITableView *)goodsTableView
{
    if (!_goodsTableView) {
        _goodsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _goodsTableView.delegate = self;
        _goodsTableView.dataSource = self;
        [_goodsTableView registerClass:[GoodsTableViewCell class] forCellReuseIdentifier:@"GoodsTableViewCell"];
        _goodsTableView.scrollEnabled = NO;
        _goodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _goodsTableView;
}

#pragma mark- Setter
-(void)setTypeModel:(TypeModel *)typeModel
{
    _typeModel = typeModel;
    
    self.typeBackground.backgroundColor = [self colorByIndex:0];
    self.secondColor = [self colorByIndex:1];
    self.thirdColor = [self colorByIndex:2];
    self.typeLabel.text = self.typeModel.kindName;
    self.goodsTableView.rowHeight = self.typeModel.goodCellHeight;
    
    [self.detialLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.typeModel.typeCellIndex == 0) {
            make.height.mas_equalTo(40);
        }else{
            
            make.height.mas_equalTo(0);
        }
        
    }];
    [self.goodsTableView reloadData];
}

#pragma mark- General
- (UIColor *)colorByIndex:(NSUInteger)colorIndex
{
    UIColor *color = [UIColor whiteColor];
    switch (self.typeModel.typeCellIndex % 2) {
        case 0://偶数
            if (colorIndex == 0) {
                color = [UIColor colorWithRed:250 / 255.0  green:37  / 255.0 blue:54 / 255.0 alpha:1.0];
            }else if(colorIndex == 1){
                color =[UIColor colorWithRed:251 / 255.0  green:119  / 255.0 blue:100 / 255.0 alpha:1.0];
            }else if (colorIndex == 2){
                color = [UIColor colorWithRed:250 / 255.0  green:126  / 255.0 blue:115 / 255.0 alpha:1.0];
            }
            break;
        case 1://奇数
            if (colorIndex == 0) {
                color = [UIColor colorWithRed:20 /255.0 green:150 / 255.0 blue:239 / 255.0 alpha:1.0];
            }else if(colorIndex == 1){
                color = [UIColor colorWithRed:48 / 255.0  green:182  / 255.0 blue:239 / 255.0 alpha:1.0];
            }else if (colorIndex == 2){
                color = [UIColor colorWithRed:98 / 255.0  green:194  / 255.0 blue:242 / 255.0 alpha:1.0];
            }
            break;
            
        default:
            break;
    }
    return color;
}

#pragma mark- UITableViewDetegate & UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeModel.goods.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsTableViewCell *goodCell = [tableView dequeueReusableCellWithIdentifier:@"GoodsTableViewCell" forIndexPath:indexPath];
    goodCell.leftColor = self.secondColor;
    goodCell.rightColor = self.thirdColor;
    goodCell.goodCellHeight = self.typeModel.goodCellHeight;
    goodCell.goodModel = self.typeModel.goods[indexPath.row];
    goodCell.contentView.backgroundColor = [UIColor whiteColor];
    return goodCell;
}

@end
