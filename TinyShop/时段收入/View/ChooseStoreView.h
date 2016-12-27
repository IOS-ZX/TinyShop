//
//  ChooseStoreView.h
//  TinyShop
//
//  Created by rimi on 2016/12/26.
//  Copyright © 2016年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseStoreViewDelgate <NSObject>

- (void)chooseShop:(NSString*)shopid;

@end

@interface ChooseStoreView : UIView

/** 店铺 **/
@property(nonatomic,strong)NSArray *stores;
/** 代理 **/
@property(nonatomic,assign)id<ChooseStoreViewDelgate> delegate;

@end
