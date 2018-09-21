//
//  OCRTestViewController.m
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/9/4.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "OCRTestViewController.h"

#import "RectManager.h"
#import "AppBaseNavigationController.h"

#import "TBOCRVC.h"


@interface OCRTestViewController ()

/** <#desc#>*/
@property (nonatomic, strong) UIView * lineView;

@end

@implementation OCRTestViewController
#pragma mark - LazyLoad 懒加载

#pragma mark - System Method 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 1.视图配置 */
    //    [self configSubViews];
    /** 2.请求数据 */
        [self transData];
//
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(kScreenWidth - 5 - 3, 0, 3, 0);
    lineView.backgroundColor = [UIColor redColor];
    [self.tableView addSubview:lineView];
    self.lineView = lineView;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {

        if (self.tableView.contentSize.height > self.tableView.height) {//大于
            
            self.lineView.hidden = NO;
            [self.tableView bringSubviewToFront:self.lineView];
            CGRect newFrame = self.lineView.frame;
            newFrame.size.height =  200 * self.tableView.height/self.tableView.contentSize.height;
            
            //移动的距离
            CGFloat offset =  self.tableView.contentOffset.y;
            //可移动距离: contentSize.height - tableView.height
            CGFloat canOffset = self.tableView.contentSize.height - self.tableView.height;
            //滚动的距离:
            CGFloat canTrackOffset = self.tableView.contentSize.height - newFrame.size.height;
            //实际的位置
            newFrame.origin.y = canTrackOffset * (offset / canOffset);

            self.lineView.frame = newFrame;

        }
        
        
    }
   
}
- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.alpha = 0;
    } completion:^(BOOL finished) {
        self.lineView.hidden= YES;
        self.lineView.alpha = 1;
    }];
}
#pragma mark - Custom Method 自定义方法
/** 配置子视图、子控件 */
- (void)configSubViews {
    
}

#pragma mark - Stter and Getter 属性设置获取

#pragma mark - TableView DataSource 数据源方法（TableVieW）

#pragma mark - TableView Delegate 代理（TableVieW）

#pragma mark - Others Delegate 代理（其他）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self getOcr];
}

#pragma mark - NetWork 网络请求
/** 请求数据 */
- (void)transData {
    
    int i = 0;
    while (i< 50) {
        i ++;
        [self.viewModel addData:@"扫描识别" atSection:0];
    }


    
}

#pragma mark - Action 响应事件
/** 获取OCR信息*/
- (void)getOcr{
    

//    if (!TARGET_IPHONE_SIMULATOR) {
//
////        TBOCRType type = TBOCRTypeFace;
////        MGIDCardManager *cardManager = [[MGIDCardManager alloc] init];
//
////        __weak typeof(self) weakSelf = self;
//        TBOCRVC *ocrVC;
//        ocrVC = [[TBOCRVC alloc]initWithOcrType:TBOCRTypeFace];
//        AppBaseNavigationController *navi = [[AppBaseNavigationController alloc] initWithRootViewController:ocrVC];
//        [self presentViewController:navi animated:true completion:nil];
//
//        ocrVC.didScanSuc = ^(TBOCRInfo *info) {
////            UIImage *image = info.cropImage;
////            NSData *imageData = [image smallestImgToData];
////            NSData *uploadData = [image compressScaleImageForSize:kCompressSize];
//
//            TBOCRInfo *infoModel = info;
//
//
//        };
//
//    }
   

}


@end
