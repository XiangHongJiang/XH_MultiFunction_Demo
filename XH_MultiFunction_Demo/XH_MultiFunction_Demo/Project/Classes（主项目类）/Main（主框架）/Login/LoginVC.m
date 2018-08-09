//
//  LoginVC.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/9.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "LoginVC.h"

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    
    [self configSubViews];
}

- (void)configSubViews {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginWithPassword:(UIButton *)sender {
    
//    [sender addActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];
    
//    __weak typeof(self) weakSelf = self;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
////        [sender removeActivityIndicatorWithTitle:@"账户密码登录"];
//
//        if (self.loginSucceedBlock) {
//            self.loginSucceedBlock();
//        }
//
//    });
    
    
}
- (IBAction)loginWithTouchId:(UIButton *)sender {
    
//    [sender addActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];
    
//
//    [[TouchID shareInstance] showTouchIdWithDesc:nil andStateBlock:^(TBTouchIDState state, NSError *error) {
//
//        if (state == TBTouchIDStateSuccess) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                if (self.loginSucceedBlock) {
//                    self.loginSucceedBlock();
//                }
//                [sender removeActivityIndicatorWithTitle:@"TouchID登录"];
//            });
//        }else {
//
//
//        }
//
//
//    }];
    
    
}

- (void)dealloc {
    NSLog(@"%@: dealloced \n",NSStringFromClass(self.class));
    
}

@end
