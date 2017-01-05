//
//  MoreView.h
//  TinyShop
//
//  Created by 曹晓东 on 2017/1/3.
//  Copyright © 2017年 CXD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^MoreChooseCallBack)(NSInteger index);

@interface MoreView : UIView

@property(nonatomic, copy)MoreChooseCallBack moreChooseCallBack;

@end
