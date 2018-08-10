//
//  AppBaseViewController.m
//  App_General_Template
//
//  Created by JXH on 2017/7/6.
//  Copyright © 2017年 JXH. All rights reserved.
//

#import "AppBaseViewController.h"

@interface AppBaseViewController ()


@end

@implementation AppBaseViewController
#pragma mark - Lazy Load： 懒加载
/** 基本VC数据管理模型类*/
- (AppBaseTableViewDataModel *)dataModel {
    
    if (_dataModel == nil) {
        _dataModel = [[AppBaseTableViewDataModel alloc] init];
    }
    return _dataModel;
}

//解析上一级传进来的参数，子类有需要重写实现即可
- (void)updateParams {
    //子类实现，解析字典参数
    self.navigationItem.title = self.params[kTitle];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //解析参数
    [self updateParams];

}
- (void)setParams:(NSDictionary *)params {
    
    if (self.params.count) {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self.params];
        [mDic addEntriesFromDictionary:params];
        _params = mDic;
    }else{
        _params = params;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Method
- (void)configSubViews {
    
}
/** 请求数据*/
- (void)transData {
    
    
}
//监听子类释放
- (void)dealloc {
    
    NSLog(@"-[%@ dealloc]\n\n\n\n\n\n\n\n\n\n\n\n",NSStringFromClass([self class]));
}
- (void)pop {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
