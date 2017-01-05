
#import "GoodsSubViewController.h"
//#import "UserInstance.h"

@interface GoodsSubViewController ()

/** 店铺id数组 **/
@property(nonatomic,strong)NSMutableArray    *shopIDarr;

/** 店铺id数组 **/
@property(nonatomic,strong)MyPieChartView    *chartView;

@end

@implementation GoodsSubViewController

-(void)shopingNetworking:(NSString *)sales_copies type_name:(NSString *)type_name goods_name:(NSString *)goods_name query:(NSString *)query time:(NSString *)time
{
    __weak typeof(self) weakSelf = self;
    [NetTool checkRequest:@"goodsScaleAction" loadingMessage:@"加载中..." parameter:@{@"body":@{@"shop_id":[UserInstance sharedUserInstance].allShopIDs,@"sales_copies":sales_copies,@"type_name":type_name,@"goods_name":goods_name,@"time":time}} success:^(NSDictionary *result) {
        
        NSLog(@"result:%@",result);
        NSDictionary *dic = result[@"body"];
        NSMutableArray *allKeyarr = [[dic allKeys] mutableCopy];
        __block NSMutableArray *mainDatas = [NSMutableArray array];
        __block NSMutableArray *detailData = [NSMutableArray array];
        [allKeyarr enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat sum = [self makeSumm:dic[key]];
            if (sum > 0) {
                NSArray *ids = [key componentsSeparatedByString:@"_"];
                NSString *name = @"";
                if (ids.count > 2) {
                    name = [[UserInstance sharedUserInstance]getNameBySHopId:[NSString stringWithFormat:@"%@",ids[2]]];
                }
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
                [dic1 setObject:name forKey:@"title"];
                [dic1 setObject:[NSString stringWithFormat:@"%g",sum] forKey:@"value"];
                [mainDatas addObject:dic1];
                [detailData addObject:[self makeSubDatas:dic[key]]];
            }
        }];
        weakSelf.chartView.detailArray = detailData;
        weakSelf.chartView.dataArray = mainDatas;
        
//        NSDictionary *dic1 = result[@"body"][@"shop_id_157"];
//        NSMutableArray *allValuearr1 = [[dic1 allValues] mutableCopy];
//        //求和
//        NSInteger countone = [[allValuearr1 valueForKeyPath:@"@sum.floatValue"] integerValue];
//        NSLog(@"countone:%ld",countone);
//        
//        NSDictionary *dic2 = result[@"body"][@"shop_id_158"];
//        NSMutableArray *allValuearr2 = [[dic2 allValues] mutableCopy];
//        NSInteger countwo = [[allValuearr2 valueForKeyPath:@"@sum.floatValue"] integerValue];
//        
//        NSDictionary *dic3 = result[@"body"][@"shop_id_311"];
//        NSMutableArray *allValuearr3 = [[dic3 allValues] mutableCopy];
//        NSInteger counthere = [[allValuearr3 valueForKeyPath:@"@sum.floatValue"] integerValue];
//    
//        
//        
//        for (int i = 0; i < allKeyarr.count; i++) {
//            
//            //获取店铺id
//            NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//            NSString * remainSecond =[allKeyarr[i] stringByTrimmingCharactersInSet:nonDigits];
//           
//            [self.shopIDarr addObject:remainSecond];
//        }
//        
//        //获取店铺名称
//       NSArray *array = [[UserInstance sharedUserInstance] getNameArrayByShopIdArr:self.shopIDarr];
//        NSLog(@"array:%@",array);
//
//        NSMutableDictionary *mutableDic = @{@"title":array[0]};
        
    } error:^(NSError *error) {
        NSLog(@"error:%@",error);
        [MBProgressHUD showError:@"服务器开小差了"];
        
        
    }];
}

- (CGFloat)makeSumm:(NSDictionary*)dic{
    __block CGFloat sum = 0;
    NSArray *keys = [dic allKeys];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        sum += [dic[key] floatValue];
    }];
    return sum;
}

- (NSArray *)makeSubDatas:(NSDictionary*)dic{
    NSArray *keys = [dic allKeys];
    __block NSMutableArray *detail = [NSMutableArray array];
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:key forKey:@"title"];
        [data setObject:[NSString stringWithFormat:@"%@",dic[key]] forKey:@"value"];
        [detail addObject:data];
    }];
    return detail;
}

#pragma mark -- getter
-(NSMutableArray *)shopIDarr
{
    if (!_shopIDarr) {
        _shopIDarr = [NSMutableArray array];
    }
    return _shopIDarr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self shopingNetworking:@"sales" type_name:@"0" goods_name:@"0" query:@"day" time:@"2016-12-19"];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (MyPieChartView *)chartView{
    if (!_chartView) {
        _chartView = [[MyPieChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        [self.view addSubview:_chartView];
    }
    return _chartView;
}

@end
