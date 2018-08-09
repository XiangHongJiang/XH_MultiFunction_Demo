//
//  AppBaseViewController.h
//  App_General_Template
//
//  Created by JXH on 2017/7/6.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,NavigationTransType) {
   
    NavigationTransType_Default_Img,//默认通过背景图片设置
    NavigationTransType_BarView,//通过BarView设置

};

@interface AppBaseViewController : UIViewController
/** 导航背景*/
@property (weak, nonatomic) UIView *navigationBarView;

/** 上一级过来传的参数：用于新界面的使用*/
@property (nonatomic, copy) NSDictionary *params;
/** 更新参数*/
- (void)updateParams;

/** 设置导航是否透明*/
@property (nonatomic, assign) BOOL transparentNavigationBar;//透明
/** 默认通过背景图片设置渐变*/
@property (assign, nonatomic) NavigationTransType transType;//透明方式


@end
