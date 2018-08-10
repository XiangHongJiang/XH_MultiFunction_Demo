//
//  AppBaseViewController.h
//  App_General_Template
//
//  Created by JXH on 2017/7/6.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppBaseTableViewDataModel.h"//Data

@interface AppBaseViewController : UIViewController

/** 上一级过来传的参数：用于新界面的使用*/
@property (nonatomic, copy) NSDictionary *params;
/** DataSource: 数据源*/
@property (nonatomic,strong) AppBaseTableViewDataModel *dataModel;

/** 请求数据*/
- (void)transData;
/** 更新参数*/
- (void)updateParams;
/** 更新子视图*/
- (void)configSubViews;
/** 返回*/
- (void)pop;
@end
