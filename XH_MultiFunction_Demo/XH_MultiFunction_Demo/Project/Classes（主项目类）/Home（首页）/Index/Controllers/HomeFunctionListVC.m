//
//  HomeFunctionListVC.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/10.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "HomeFunctionListVC.h"

typedef NS_ENUM(NSInteger,Function_Type){
    
    Function_Type_Login,//登录
    Function_Type_CustomDrawTable_Demo,//自定义表格绘制
    
};

@interface HomeFunctionListVC ()

@end

@implementation HomeFunctionListVC

#pragma mark - System Method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Method
- (void)configData {
    
    NSArray *functionArray = @[
                                   @{kTitle:@"退出登录",@"type":@(Function_Type_Login)},
                                   @{kTitle:@"0.自定义表格绘制",@"type":@(Function_Type_CustomDrawTable_Demo)},

                                   ];
    
    [self.viewModel addDatasFromArray:functionArray atSection:0];
    
}
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *functionDic = [[self.viewModel.allDataDic objectForKey:@(indexPath.section)] safeObjectAtIndex:indexPath.row];
    Function_Type type = [functionDic[@"type"] integerValue];//type
    NSString *title = functionDic[kTitle]?functionDic[kTitle]:@"";//name
    
    switch (type) {
        case Function_Type_Login:
            [self loginStateChangeWithOut:YES];
            break;
            
        case Function_Type_CustomDrawTable_Demo:
            [self.navigationController routePushViewController:@"CustomDrawExampleTableViewController" withParams:@{kTitle:title} animated:YES];

            break;
            
        default:
            break;
    }
    
    
}
#pragma mark - Action
/** 退出登录*/
- (void)loginStateChangeWithOut:(BOOL)isOut {
    
    if (isOut) {
        
        [AppManager.instance saveUserLoginInfo];
    }
    LoginVC *login = [LoginVC new];
    
    __block LoginVC *wsLogin = login;
    login.loginSucceedBlock = ^{
        
        AppManager.instance.userLoginInfo.USERID = @"1234";
        [AppManager.instance saveUserLoginInfo];
        [wsLogin dismissViewControllerAnimated:YES completion:nil];
        wsLogin = nil;
        
    };
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}


@end
