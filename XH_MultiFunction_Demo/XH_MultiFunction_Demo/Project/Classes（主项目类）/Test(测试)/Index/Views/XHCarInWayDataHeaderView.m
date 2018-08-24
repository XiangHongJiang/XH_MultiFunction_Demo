//
//  XHCarInWayDataHeaderView.m
//  CarInWay
//
//  Created by MrYeL on 2018/6/22.
//  Copyright © 2018年 wyh. All rights reserved.
//

#define HeaderImageWith_Height 180
#define IconImageView_Height 40


#import "XHCarInWayDataHeaderView.h"
#import "XHCarInwayDataDailyInfoModel.h"


@interface XHCarInWayDataHeaderView()

/** 类型*/
@property (nonatomic, assign) NSInteger type;
/** 当前进度*/
@property (nonatomic, strong) UILabel * progressLabel;
/** 当前进度标题*/
@property (nonatomic, strong) UILabel * progressTitleLabel;
/** 当前单位*/
@property (nonatomic, strong) UILabel * progressUnitLabel;

@property (strong, nonatomic) YHResetFrameButton *exchangeBtn;//切换
@property (strong, nonatomic) YHResetFrameButton *weekReportBtn;//周报告
@property (strong, nonatomic) YHResetFrameButton *mounthReportBtn;//月报告

/** XHCarInwayDataDailyInfoModel*/
@property (nonatomic, strong) XHCarInwayDataDailyInfoModel * dataModel;

@end

@implementation XHCarInWayDataHeaderView

- (ZZCircleProgress *)progressView {
    
    if (_progressView == nil) {
        _progressView = [ZZCircleProgress new];
        
        //初始化经验进度
        _progressView.pathBackColor = [UIColor clearColor];
        _progressView.pathFillColor = [UIColor whiteColor];
        _progressView.strokeWidth = 5;
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.animationModel = CircleIncreaseByProgress;
        _progressView.showProgressText = NO;
        _progressView.showPoint = NO;
        _progressView.forceRefresh = YES;
        _progressView.notAnimated = YES;
        _progressView.progress = 1;
//        _progressView.startAngle = -60;
//        _progressView.reduceValue = 30;

        
    }
    return _progressView;
}

+ (instancetype)dataHeaderViewWithFrame:(CGRect)frame andType:(NSInteger)type{

    XHCarInWayDataHeaderView *view = [[self alloc] initWithFrame:frame];
    view.type = type;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    
    UIImageView *bgImageView=[UIImageView new];
    [self addSubview:bgImageView];
    self.bgImageView=bgImageView;
    self.bgImageView.image = [UIImage imageNamed:@"data_Slice_Icon"];

    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading);
        make.top.equalTo(self.mas_top);
        make.trailing.equalTo(self.mas_trailing);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    UIButton *dateTitleBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:dateTitleBtn];
    self.dateTitleBtn=dateTitleBtn;
    
    [dateTitleBtn setTitle:@"05-24至05-30" forState:(UIControlStateNormal)];
    
    [dateTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.width.equalTo(@(150));
        make.centerX.equalTo(bgImageView.mas_centerX);
        make.top.equalTo(self.mas_top);
    }];
    
    
    UIImageView *headerImageView=[UIImageView new];
    [self addSubview:headerImageView];
    self.headerImageView=headerImageView;
    headerImageView.userInteractionEnabled = YES;
    self.headerImageView.image = [UIImage imageNamed:@"data_circle_bg"];

    
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(RATEWIDTH_iPhone6(HeaderImageWith_Height)));
        make.height.equalTo(@(RATEWIDTH_iPhone6(HeaderImageWith_Height)));
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
    ZZCircleProgress *progressView = self.progressView;
    [self addSubview:progressView];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImageView.mas_centerX);
        make.centerY.equalTo(headerImageView.mas_centerY);
        
        make.height.equalTo(headerImageView.mas_height).offset(20);
        make.width.equalTo(headerImageView.mas_width).offset(20);
        
        
    }];
    
    
    UIButton *preDateBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:preDateBtn];
    self.preDateBtn=preDateBtn;
    
    [preDateBtn setTitle:@"<" forState:(UIControlStateNormal)];
    [preDateBtn addTarget:self action:@selector(preAction) forControlEvents:UIControlEventTouchUpInside];
    
    [preDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.width.equalTo(@(60));
        make.top.equalTo(self.mas_top);
        make.leading.equalTo(self.mas_leading);
    }];
    
    
    UIButton *nextDateBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:nextDateBtn];
    self.nextDateBtn=nextDateBtn;
    
    [nextDateBtn setTitle:@">" forState:(UIControlStateNormal)];
    [nextDateBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];

    [nextDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(60));
        make.height.equalTo(@(40));
        make.top.equalTo(self.mas_top);
        make.trailing.equalTo(self.mas_trailing);
    }];
    
    
    UIImageView *iconImageView=[UIImageView new];
    [self addSubview:iconImageView];
    self.iconImageView=iconImageView;
    
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(RATEHEIGHT_iPhone6(IconImageView_Height)));
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    //当前进度
    
    self.progressLabel = [XHTools getUILabelWithFrame:CGRectZero withTitle:@"" withFont:30 withTextColor:[UIColor whiteColor]];
    [self addSubview:self.progressLabel];
    
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImageView.mas_centerX);
        make.height.equalTo(@45);
        make.centerY.equalTo(headerImageView.mas_centerY);
        make.width.equalTo(@(RATEWIDTH_iPhone6(180)-20));
    }];
    
    /** 当前进度标题*/
    self.progressTitleLabel = [XHTools getUILabelWithFrame:CGRectZero withTitle:@"今日里程" withFont:12 withTextColor:[UIColor whiteColor]];
    [self addSubview:self.progressTitleLabel];
    self.progressTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.progressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImageView.mas_centerX);
        make.height.equalTo(@20);
        make.top.equalTo(headerImageView.mas_top).offset((RATEWIDTH_iPhone6(90)-22.5-20));
        make.width.equalTo(@50);

    }];
    
    /** 切换*/
    YHResetFrameButton *exchangeBtn=[YHResetFrameButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:exchangeBtn];
    self.exchangeBtn=exchangeBtn;
    //data_icon_white_change
    exchangeBtn.imageRect = CGRectMake(25, 20, 10, 10);
    [exchangeBtn setImage:[UIImage imageNamed:@"data_icon_white_change"] forState:UIControlStateNormal];
    
//    [exchangeBtn setTitle:@"＞.＜" forState:(UIControlStateNormal)];
    [exchangeBtn addTarget:self action:@selector(exchangeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(60));
        make.height.equalTo(@(40));
        make.centerX.equalTo(headerImageView.mas_centerX);
        make.bottom.equalTo(self.progressTitleLabel.mas_top);
    }];
    
    /** 当前单位*/
    
    self.progressUnitLabel = [XHTools getUILabelWithFrame:CGRectZero withTitle:@"km" withFont:12 withTextColor:[UIColor whiteColor]];
    [self addSubview:self.progressUnitLabel];
    self.progressUnitLabel.textAlignment = NSTextAlignmentCenter;
    [self.progressUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImageView.mas_centerX);
        make.height.equalTo(@20);
        make.bottom.equalTo(headerImageView.mas_bottom).offset(-(RATEWIDTH_iPhone6(90)-22.5-20));
        make.width.equalTo(@30);

    }];
    
    /** 周报告*/
    CGFloat margin =  kScreenWidth *0.25 -  RATEWIDTH_iPhone6(45) - 27.5;

    YHResetFrameButton *weekReportBtn=[YHResetFrameButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:weekReportBtn];
    self.weekReportBtn=weekReportBtn;
    weekReportBtn.titleRect = CGRectMake(0, 27.5, 55, 20);
    weekReportBtn.imageRect = CGRectMake(20, 10, 15, 17.5);
    weekReportBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [weekReportBtn setTitle:@"周报告" forState:(UIControlStateNormal)];
    [weekReportBtn addTarget:self action:@selector(weekReportAction) forControlEvents:UIControlEventTouchUpInside];
    weekReportBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [weekReportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(55));
        make.height.equalTo(@(55));
        make.bottom.equalTo(self.headerImageView.mas_bottom);
        make.left.equalTo(self.mas_left).offset(margin);
    }];
    weekReportBtn.layer.cornerRadius =27.5;
    [weekReportBtn setImage:[UIImage imageNamed:@"data_icon_week_report"] forState:UIControlStateNormal];
    [weekReportBtn setBackgroundImage:[UIImage imageNamed:@"data_icon_red_mask"] forState:UIControlStateNormal];

    /** 月报告*/
    YHResetFrameButton *mounthReportBtn=[YHResetFrameButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:mounthReportBtn];
    self.mounthReportBtn=mounthReportBtn;
    
    mounthReportBtn.titleRect = CGRectMake(0, 27.5, 55, 20);
    mounthReportBtn.imageRect = CGRectMake(20, 10, 15, 17.5);

    mounthReportBtn.titleLabel.textAlignment = NSTextAlignmentCenter;

    [mounthReportBtn setTitle:@"月报告" forState:(UIControlStateNormal)];
    [mounthReportBtn addTarget:self action:@selector(mounthReportAction) forControlEvents:UIControlEventTouchUpInside];
    mounthReportBtn.titleLabel.font = [UIFont systemFontOfSize:12];

    [mounthReportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(55));
        make.height.equalTo(@(55));
        make.bottom.equalTo(self.headerImageView.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-margin);
        
    }];
    
    mounthReportBtn.layer.cornerRadius =27.5;
    [mounthReportBtn setBackgroundImage:[UIImage imageNamed:@"data_icon_red_mask"] forState:UIControlStateNormal];
    [mounthReportBtn setImage:[UIImage imageNamed:@"data_icon_month_report"] forState:UIControlStateNormal];

    //隐藏
    self.preDateBtn.hidden = self.nextDateBtn.hidden = self.dateTitleBtn.hidden = self.iconImageView.hidden = YES;
    self.progressLabel.text = @"0.00";
}
#pragma mark - Setter and Getter
- (void)setType:(NSInteger)type {
    _type = type;
    
    switch (type) {
        case 0:
            self.progressTitleLabel.text = @"今日里程";
            break;
        case 1:
            self.progressTitleLabel.text = @"总里程";
            break;
        case 2:
            break;
        default:
            break;
    }
}

#pragma mark - Custom Method
- (void)configData:(XHCarInwayDataDailyInfoModel *)data withDate:(NSString *)dateStr {
    
    self.progressView.notAnimated = NO;

    if ([data isKindOfClass:[XHCarInwayDataDailyInfoModel class]]) {
        //关键性赋值
        self.dataModel = data;
        self.type = 0;
        self.progressUnitLabel.text = @"km";
        CGFloat miles = self.type ? self.dataModel.totalMiles.floatValue: self.dataModel.todayMiles.floatValue;

        __weak typeof(self) weakSelf = self;
        if (miles > 0) {
            
            self.progressView.progress = 1;
            
//            self.progressView.progressChangedBlock = ^(CGFloat progress) {
//
//                if (miles > 10000) {
//                    weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.0f",miles * progress];
//                }else {
//                    weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.2f",miles * progress];
//
//                }
//
//            };
        }else {
            if (miles > 10000) {
                weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.0f",miles];
            }else {
                weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.2f",miles];
                
            }
        }

    }else {
        [self test];
    }
}
- (void)test {
    self.progressView.progress = 1;
    __weak typeof(self) weakSelf = self;
//    self.progressView.progressChangedBlock = ^(CGFloat progress) {
//        weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.2f",progress *0];
//    };
}
#pragma mark - Action
- (void)preAction {
    if (self.dataHeaderViewActionBlock) {
        self.dataHeaderViewActionBlock(self, DataHeaderViewClickType_PreDate);
    }
}
- (void)nextAction {
    if (self.dataHeaderViewActionBlock) {
        self.dataHeaderViewActionBlock(self, DataHeaderViewClickType_NextDate);
    }
}

- (void)exchangeAction {
    
    self.type = self.type > 0 ? 0:1;
    
   CGFloat miles = self.type ? self.dataModel.totalMiles.floatValue: self.dataModel.todayMiles.floatValue;

    //单位与数值更换
//    if (miles > 10000) {
//
//        miles = miles / 10000.0;
//        self.progressUnitLabel.text = @"万km";
//
//    }else {
        self.progressUnitLabel.text = @"km";
        
//    }
    //是否动画
    if (miles > 0) {
        self.progressView.notAnimated = NO;
    }else {
        self.progressView.notAnimated = YES;
        self.progressLabel.text = @"0.00";

    }
    self.progressView.progress = 1;

    __weak typeof(self) weakSelf = self;
//    self.progressView.progressChangedBlock = ^(CGFloat progress) {
//        if (miles > 10000) {
//            weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.0f",miles * progress];
//        }else {
//            weakSelf.progressLabel.text = [NSString stringWithFormat:@"%.2f",miles * progress];
//
//        }
//    };
//    showMessage(@"切换数据");
}
- (void)weekReportAction {
    if (self.dataHeaderViewActionBlock) {
        self.dataHeaderViewActionBlock(self, DataHeaderViewClickType_WeekReportData);
    }
}
- (void)mounthReportAction {
    if (self.dataHeaderViewActionBlock) {
        self.dataHeaderViewActionBlock(self, DataHeaderViewClickType_MounthReportData);
    }
}
@end
