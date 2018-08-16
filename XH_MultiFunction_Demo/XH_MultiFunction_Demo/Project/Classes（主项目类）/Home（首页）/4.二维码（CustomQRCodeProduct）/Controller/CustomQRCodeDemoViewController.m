//
//  CustomQRCodeDemoViewController.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/16.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "CustomQRCodeDemoViewController.h"

#import "NPQRCodeManager.h"


#define QRStr @"http://www.baidu.com"


@interface CustomQRCodeDemoViewController ()
/** title*/
@property (nonatomic, copy) NSArray *dataArray;

@property (strong, nonatomic) UIImageView *QRImgeView;


@end

@implementation CustomQRCodeDemoViewController
- (UIImageView *)QRImgeView {
    
    if (_QRImgeView == nil) {
        _QRImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    }
    return _QRImgeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataArray = @[@"默认黑色",@"自定义颜色",@"自定义logo与颜色",@"已有二维码改色",@"已有二维码加logo",@"其他"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    self.tableView.tableHeaderView = self.QRImgeView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // self.dataArray = @[@"默认黑色",@"自定义颜色",@"自定义logo与颜色",@"已有二维码改色",@"已有二维码加logo"];
    
    UIImage *resultImage = nil;
    switch (indexPath.row) {
        case 0:
            resultImage = [NPQRCodeManager createQRCode:QRStr];
            break;
        case 1:
            resultImage = [NPQRCodeManager createQRCode:QRStr withColor:[UIColor cyanColor]];
            break;
        case 2:{//先处理logo
            UIImage *logoImage = [NPQRCodeManager clipCornerRadius:[UIImage imageNamed:@"daren"] withSize:CGSizeMake(50, 50) cornerRadius:3 borderWidth:5 andBorderColor:nil];
            resultImage = [NPQRCodeManager createQRCode:QRStr withColor:[UIColor cyanColor] andLogoImageView:logoImage];
        }
            break;
        case 3:
        {
            resultImage = [NPQRCodeManager createQRCode:QRStr];
            //            resultImage = [NPQRCodeManager imageBlackToTransparent:resultImage withRed:155 andGreen:155 andBlue:155];
            resultImage = [NPQRCodeManager changeQRCodeImage:resultImage withColor:[UIColor greenColor]];
            
        }
            break;
        case 4:{
            UIImage *logoImage = [NPQRCodeManager clipCornerRadius:[UIImage imageNamed:@"daren"] withSize:CGSizeMake(50, 50) cornerRadius:5 borderWidth:10 andBorderColor:nil];
            resultImage = [NPQRCodeManager createQRCode:QRStr];
            resultImage = [NPQRCodeManager addLogoImage:resultImage withLogoImage:logoImage ofTheSize:resultImage.size];
        }
            break;
        case 5:
            break;
            
        default:
            break;
    }
    
    self.QRImgeView.image = resultImage;
    
}


@end
