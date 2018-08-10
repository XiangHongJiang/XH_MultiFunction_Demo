//
//  HomeFunctionListVC.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/10.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "HomeFunctionListVC.h"


@interface HomeFunctionListVC ()

@end

@implementation HomeFunctionListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData {
    

    [self.viewModel addDatasFromArray:@[@"退出登录",@"测试1",@"测试2"] atSection:0];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self loginStateChangeWithOut:YES];
            break;
            
        case 1:
            
            break;
            
        default:
            break;
    }
    
}
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
