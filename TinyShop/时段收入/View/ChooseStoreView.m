//
//  ChooseStoreView.m
//  TinyShop
//
//  Created by rimi on 2016/12/26.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import "ChooseStoreView.h"
#import "ChooseTableCell.h"

@interface ChooseStoreView()<UITableViewDelegate,UITableViewDataSource,ChooseTableCellDelegate>

/** tableView **/
@property(nonatomic,strong)UITableView *tableView;
/** 内容区域 **/
@property(nonatomic,strong)UIView *contentViews;
/** 关闭按钮 **/
@property(nonatomic,strong)UIButton *close;
/** 全选按钮 **/
@property(nonatomic,strong)UIButton *chooseAll;
/** 确定按钮 **/
@property(nonatomic,strong)UIButton *chooseBtn;
/** 灰色间隔 **/
@property(nonatomic,strong)UIView *line;
/** 全选label **/
@property(nonatomic,strong)UILabel *allLabel;
/** 选中状态 **/
@property(nonatomic,strong)NSMutableArray *chooseStatus;
/** 选中个数 **/
@property(nonatomic,assign)NSInteger counts;
/** 选中id **/
@property(nonatomic,strong)NSString *shopId;
/** tmp **/
@property(nonatomic,assign)NSInteger tmp;

@end

@implementation ChooseStoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self setUpUI];
        self.counts = 0;
        UINib *nib = [UINib nibWithNibName:@"ChooseTableCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"choose"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - tableSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stores.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choose" forIndexPath:indexPath];
    cell.delegate = self;
    if ([self.chooseStatus[indexPath.row] integerValue] == 1) {
        cell.chooseSwitch.on = YES;
    }else{
        cell.chooseSwitch.on = NO;
    }
    cell.index = indexPath.row;
    ShopModel *model = [ShopModel mj_objectWithKeyValues:self.stores[indexPath.row]];
    cell.titleLabel.text = [model valueForKey:@"shop_name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - cell代理
- (void)chooseTableItem:(UITableViewCell *)cell seleted:(NSInteger)index isSeleted:(BOOL)isSeleted{
    self.tmp = self.counts;
    if (isSeleted) {
        self.chooseStatus[index] = @1;
        if (self.counts < self.stores.count) {
            self.counts++;
        }
    }else{
        self.tmp--;
        if (self.counts > 1) {
            self.chooseStatus[index] = @0;
            self.counts--;
        }
    }
    if (self.counts == self.stores.count) {
        self.chooseAll.selected = YES;
    }else{
        self.chooseAll.selected = NO;
    }
}

#pragma mark - 自定义方法
- (void)closeView{
    self.hidden = YES;
}

- (void)chooseStore{
    if (self.tmp < 1) {
        [MBProgressHUD showError:@"至少选择一个店铺"];
        return;
    }
    self.hidden = YES;
    [self getChooseShopIds];
    [self.delegate chooseShop:self.shopId];
}

- (void)chooseAlls:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.counts = self.stores.count;
        [self.chooseStatus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            weakSelf.chooseStatus[idx] = @1;
        }];
    }else{
        self.counts = 0;
        [self.chooseStatus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.counts > 1) {
                weakSelf.chooseStatus[idx] = @0;
            }
        }];
    }
    self.tmp = self.counts;
    [self.tableView reloadData];
}

- (void)getChooseShopIds{
    __block NSMutableArray *shopIds = [NSMutableArray array];
    [self.chooseStatus enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShopModel *model = [ShopModel mj_objectWithKeyValues:self.stores[idx]];
        if (obj.integerValue == 1 && ![shopIds containsObject:[model valueForKey:@"shop_id"]]) {
            [shopIds addObject:[model valueForKey:@"shop_id"]];
        }
    }];
    self.shopId = [shopIds componentsJoinedByString:@","];
}
#pragma mark - 约束
- (void)setUpUI{
    __weak typeof(self) weakSelf = self;
    [self.contentViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.9);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.85);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [self.close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(weakSelf.contentViews.mas_top).offset(5);
        make.right.equalTo(weakSelf.contentViews.mas_right).offset(-20);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.contentViews.mas_width);
        make.height.equalTo(weakSelf.contentViews.mas_height).multipliedBy(0.6);
        make.top.equalTo(weakSelf.close.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.contentViews.mas_centerX);
    }];
    [self layoutIfNeeded];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.contentViews.width, 1));
        make.bottom.equalTo(weakSelf.tableView.mas_top);
        make.centerX.equalTo(weakSelf.contentViews.mas_centerX);
    }];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.contentViews.width * 0.75, 40));
        make.bottom.equalTo(weakSelf.contentViews.mas_bottom).offset(-30);
        make.centerX.equalTo(weakSelf.contentViews.mas_centerX);
    }];
    [self.chooseAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(weakSelf.chooseBtn.mas_right).offset(5);
        make.bottom.equalTo(weakSelf.chooseBtn.mas_top).offset(-40);
    }];
    [self.allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.centerY.equalTo(weakSelf.chooseAll.mas_centerY);
        make.right.equalTo(weakSelf.chooseAll.mas_left).offset(-10);
    }];
}

#pragma mark - Setter

- (void)setStores:(NSArray *)stores{
    _stores = stores;
    if (self.counts < 1) {
        self.counts = stores.count;
        self.tmp = self.counts;
    }
    [self.tableView reloadData];
}

#pragma mark - 懒加载

- (UIView *)contentViews{
    if (!_contentViews) {
        _contentViews = [UIView new];
        _contentViews.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentViews];
    }
    return _contentViews;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.contentViews addSubview:_tableView];
    }
    return _tableView;
}

- (UIButton *)close{
    if (!_close) {
        _close = [UIButton new];
        [_close setImage:[UIImage imageNamed:@"关闭icon"] forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [self.contentViews addSubview:_close];
    }
    return _close;
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor hexColor:@"f1f2f3"];
        [self.contentViews addSubview:_line];
    }
    return _line;
}

- (UIButton *)chooseAll{
    if (!_chooseAll) {
        _chooseAll = [UIButton new];
        [_chooseAll setImage:[UIImage imageNamed:@"全选"] forState:UIControlStateSelected];
        [_chooseAll setImage:[UIImage imageNamed:@"未全选框"] forState:UIControlStateNormal];
        [_chooseAll addTarget:self action:@selector(chooseAlls:) forControlEvents:UIControlEventTouchUpInside];
        _chooseAll.selected = YES;
        [self.contentViews addSubview:_chooseAll];
    }
    return _chooseAll;
}

- (UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton new];
        _chooseBtn.backgroundColor = [UIColor redColor];
        _chooseBtn.layer.cornerRadius = 3;
        [_chooseBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseStore) forControlEvents:UIControlEventTouchUpInside];
        [self.contentViews addSubview:_chooseBtn];
    }
    return _chooseBtn;
}

- (UILabel *)allLabel{
    if (!_allLabel) {
        _allLabel = [UILabel new];
        _allLabel.text = @"全选";
        [_contentViews addSubview:_allLabel];
    }
    return _allLabel;
}

- (NSMutableArray*)chooseStatus{
    if (!_chooseStatus) {
        _chooseStatus = [NSMutableArray array];
        for (NSInteger index; index < self.stores.count; index++) {
            [_chooseStatus addObject:@1];
        }
    }
    return _chooseStatus;
}
@end
