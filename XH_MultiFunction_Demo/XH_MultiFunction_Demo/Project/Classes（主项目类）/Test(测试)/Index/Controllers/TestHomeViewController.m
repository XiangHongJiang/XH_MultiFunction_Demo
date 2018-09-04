//
//  TestHomeViewController.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/23.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "TestHomeViewController.h"
#import "XHCarInWayDataHeaderView.h"

@interface TestHomeViewController ()

/** topView*/
@property (nonatomic, strong) XHCarInWayDataHeaderView *topView;

@end

@implementation TestHomeViewController
#pragma mark - LazyLoad 懒加载
- (XHCarInWayDataHeaderView *)topView {
    if (_topView == nil) {
         
        _topView = [XHCarInWayDataHeaderView dataHeaderViewWithFrame:CGRectMake(0, RATEHEIGHT_iPhone6(DataHeaderHeight) + 20, kScreenWidth, RATEHEIGHT_iPhone6(DataHeaderHeight)) andType:0];
    }
    return _topView;
}
#pragma mark - System Method 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 1.视图配置 */
        [self configSubViews];
    /** 2.请求数据 */
        [self transData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Method 自定义方法
/** 配置子视图、子控件 */
- (void)configSubViews {
    
    self.navigationItem.title = @"测试列表";

    self.tableView.tableHeaderView = self.topView;
    

}
#pragma mark - TableView Delegate 代理（TableVieW）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.topView configData:nil withDate:nil];

}

#pragma mark - NetWork 网络请求
/** 请求数据 */
- (void)transData {

    NSArray *functionArray = @[
                               @{kTitle:@"圆弧",@"vcName":@"CustomDrawExampleTableViewController",@"type":@(0)},
                               
                               ];
    
    [self.viewModel addDatasFromArray:functionArray atSection:0];
    
}
#pragma mark - Action 响应事件



@end
