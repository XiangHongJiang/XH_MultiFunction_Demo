//
//  App_Header_Import.h
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

/** 头文件:需要全局使用的头文件*/

#ifndef App_Header_Import_h
#define App_Header_Import_h

//cocoaPods
#pragma mark - Cocoapods
#import <YYKit.h>
#import <MJRefresh.h>
#import <Masonry.h>

//categorys:分类
#pragma mark - Categorys
#import "UIColor+additions.h"
#import "NSArray+add.h"
#import "UIView+Activity.h"
#import "UINavigationController+RoutePush.h"
#import "MBProgressHUD+XHAdd.h"
#import "UIImage+AD.h"
#import "NSString+Extension.h"

//vc
#import "LoginVC.h"
#import "AppBaseTableViewController.h"
#import "AppBaseCustomSystemTableViewController.h"

//other
#import "AppManager.h"
#import "XHTools.h"
#import "Logs_PchConfig.h"
#import "CardScaningView.h"//OCR

#import <MGIDCard/MGIDCard.h>
#import <MGBaseKit/MGImage.h>//OCR
#import <MGLivenessDetection/MGLivenessDetection.h>//OCR





#endif /* App_Header_Import_h */
