//
//  XHCarInWayDataHeaderView.h
//  CarInWay
//
//  Created by MrYeL on 2018/6/22.
//  Copyright © 2018年 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DataHeaderHeight 275

#import "ZZCircleProgress.h"

typedef NS_ENUM(NSInteger,DataHeaderViewClickType){
    
    DataHeaderViewClickType_PreDate,//上一个日期
    DataHeaderViewClickType_NextDate,//下一个日期
    DataHeaderViewClickType_WeekReportData,//周报告
    DataHeaderViewClickType_MounthReportData,//月报告


};


@interface XHCarInWayDataHeaderView : UIView

@property (strong, nonatomic) UIImageView *bgImageView;
@property (strong, nonatomic) UIButton *dateTitleBtn;
@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) ZZCircleProgress *progressView;
@property (strong, nonatomic) UIButton *preDateBtn;
@property (strong, nonatomic) UIButton *nextDateBtn;
@property (strong, nonatomic) UIImageView *iconImageView;

/** 点击回调*/
@property (nonatomic, copy) void(^dataHeaderViewActionBlock)(XHCarInWayDataHeaderView *,DataHeaderViewClickType);

+ (instancetype)dataHeaderViewWithFrame:(CGRect)frame andType:(NSInteger)type;

- (void)configData:(id)data withDate:(NSString *)dateStr;

@end
