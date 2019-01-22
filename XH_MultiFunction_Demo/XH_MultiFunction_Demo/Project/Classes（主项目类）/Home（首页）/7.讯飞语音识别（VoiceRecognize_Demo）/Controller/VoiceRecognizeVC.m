//
//  VoiceRecognizeVC.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2019/1/22.
//  Copyright © 2019 MrYeL. All rights reserved.
//

#import "VoiceRecognizeVC.h"

#import "VoiceRecognizerManager.h"

@interface VoiceRecognizeVC ()

/** 数据Array*/
@property (nonatomic, copy) NSArray * dataArray;
/** HeaderView*/
@property (nonatomic, strong) UIView * headerView;
/** 识别的文字*/
@property (nonatomic, weak) UILabel * textLabel;

/** 识别对象*/
@property (nonatomic, strong) VoiceRecognizerManager * voiceManager;

@end

@implementation VoiceRecognizeVC

#pragma mark - Lazy Load
- (UIView *)headerView {
    
    if (_headerView == nil) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, RATEHEIGHT_iPhone6(200))];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
        titleLabel.text = @"识别结果";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:titleLabel];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20 + 20 + 20, kScreenWidth - 30, 100)];
        [_headerView addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return _headerView;
    
}
- (VoiceRecognizerManager *)voiceManager {
    if (_voiceManager == nil) {
        _voiceManager = [VoiceRecognizerManager VoiceRecognizerWithRecognizeType:RecognizeType_Online];
    }
    return _voiceManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"开始识别",@"停止"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *headerView = self.headerView;
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [UIView new];
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
    
    __weak typeof(self) weakSelf = self;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    switch (indexPath.row) {
        case 0://开始识别
           {
               self.textLabel.text = @"识别中…";
               [self.voiceManager startRecognizeWithFile:nil andComplete:^(VoiceRecognizerManager *manger, NSString *resultStr, NSString *errorStr) {
                if (resultStr.length) {
                    weakSelf.textLabel.text = resultStr;
                }else {
                    weakSelf.textLabel.text = errorStr;
                }
            }];
           }
            break;
        case 1://停止
            [self.voiceManager stopRecognize:nil];
            break;
        default:
            break;
    }
}

#pragma mark - Action





@end
