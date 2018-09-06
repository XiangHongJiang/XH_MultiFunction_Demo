//
//  TBPreApprovalVC.m
//  CangoToB
//
//  Created by KiddieBao on 10/01/2018.
//  Copyright © 2018 Kiddie. All rights reserved.
//

#import "TBPreApprovalVC.h"
#import "TBRescueVC.h"
#import "TBInsurBuyVC.h"
#import "RectManager.h"
#import "YHGPSCodeScannerViewController.h"
#import "XHCarPayWebVC.h"
#if TARGET_IPHONE_SIMULATOR

#else
#import <MGIDCard/MGIDCard.h>
#endif




@interface TBPreApprovalVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic , copy)WVJBResponseCallback callBack;

@property (nonatomic , strong)UIImagePickerController *canmeraController;

@property (nonatomic, strong)NSDictionary *ocrDict;
@end

@implementation TBPreApprovalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(weakSelf);
    [self.webViewBridge registerHandler:@"getOcr" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        [strongSelf getOcr:data withCallBack:responseCallback];
    }];
    [self.webViewBridge registerHandler:@"uploadIdCard" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        [strongSelf uploadIdCard:data withCallBack:responseCallback];
    }];
    
    [self.webViewBridge registerHandler:@"getPhotoContract" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        NSDictionary *dict = [strongSelf decodeSender:data];
        TBRescueVC *rescueVC = [TBRescueVC new];
        rescueVC.applyCd = dict[@"applyCd"];
        rescueVC.isNext = [dict[@"fromType"] intValue] == 2;
        [strongSelf.navigationController pushViewController:rescueVC animated:true];
        NSMutableArray *array = [NSMutableArray arrayWithArray:strongSelf.navigationController.viewControllers];
        [array removeObject:self];
        strongSelf.navigationController.viewControllers = array;
    }];
    
    [self.webViewBridge registerHandler:@"getComment" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        responseCallback(strongSelf.params.mj_JSONString);
    }];
    
    [self.webViewBridge registerHandler:@"scanQRCode" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        [strongSelf scanQRCode:data responCallBack:responseCallback];
    }];
    
    [self.webViewBridge registerHandler:@"weChatSharing" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        [strongSelf weChatShareSend:data responseCallBack:responseCallback];
    }];
    
    [self.webViewBridge registerHandler:@"reinitiating" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        [strongSelf reinitiating:data responseCallBack:responseCallback];
    }];
    
    [self.webViewBridge registerHandler:@"payConfirm" handler:^(id data, WVJBResponseCallback responseCallback) {
        SS(strongSelf);
        [strongSelf gotoNewWebVCWithData:data];
    }];
    
    if ([MGLicenseManager getLicense]) return;
    [MGLicenseManager licenseForNetWokrFinish:^(bool License) {
        NSLog(@"%@", [NSString stringWithFormat:@"授权%@", License ? @"成功" : @"失败"]);
    }];

}


- (void)gotoNewWebVCWithData:(id)sender {
    NSDictionary *dic;
    if ([sender isKindOfClass:[NSString class]]) {
        dic = (NSDictionary *)[self decodeSender:sender];
    }
    if ([sender isKindOfClass:[NSDictionary class]]) {
        dic = (NSDictionary *)sender;
    }
    NSString *url = dic[@"payUrl"];
    NSString *title = dic[@"title"];
    XHCarPayWebVC  *newWebVC = [XHCarPayWebVC new];
    newWebVC.url = url;
    newWebVC.title = title;
    [self.navigationController pushViewController:newWebVC animated:url];
}

- (void)weChatShareSend:(id)sender responseCallBack:(WVJBResponseCallback)responseCallback{
    NSDictionary *param = [self decodeSender:sender];
    TBWechatShare *share = [TBWechatShare modelWithDictionary:param];
    UIImage *image = share.imageUrl.isBlankString ? [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:share.imageUrl]]] : [UIImage imageNamed:@"ic_launch"];
    [WXApiRequest sendLinkURL:share.shareUrl
                      TagName:nil
                        Title:share.title
                  Description:share.secondaryTitle
                   ThumbImage:image
                      InScene:WXSceneSession];
    [WXApiManager sharedManager].didRecvGetMessageReq = ^(SendMessageToWXResp *resp) {
        if (resp.errCode != 0) {
            if (resp.errStr.isBlankString) {
                [TBProgressHUD showErrorWithtitle:resp.errStr];
            }
            return;
        }
        [TBProgressHUD showSuccessWithtitle:@"分享成功"];
    };
}

- (void)reinitiating:(id)sender responseCallBack:(WVJBResponseCallback)responseCallback{
    TBCustomerQO *q_o = [TBCustomerQO mj_objectWithKeyValues:self.params];
    TBInsurBuyVC *buyVC = TBInsurBuyVC.new;
    buyVC.c_q = q_o;
    [self.navigationController pushViewController:buyVC animated:true];
}

- (void)scanQRCode:(id)sender responCallBack:(WVJBResponseCallback)responseCallback{
    NSDictionary *dict = [self decodeSender:sender];
    if ([dict[@"type"] isEqualToString:@"imei"]) {
        [self.navigationController routePushViewController:@"YHGPSCodeScannerViewController" withParams:@{@"isLogisticsNum":@(YES),@"title":@"扫描单号",@"block":^(NSString *value) {
            
            if (value.length) {
                responseCallback(@{@"result" : value}.mj_JSONString);
            }
        }} animated:YES];
    }
}

- (void)uploadIdCard:(id)sender withCallBack:(WVJBResponseCallback)callBack{

    NSDictionary *dict = [self decodeSender:sender];
    self.ocrDict = dict;
    
    TBOCRType type = [dict[@"ocrType"] integerValue];
    
    if (type == TBOCRTypeImage) {
        self.callBack = callBack;
        if ([dict[@"isCamera"] integerValue] == 1) {
            [self showCamera];
        }
        else
        {
            [self showImageVC];
        }
        return;
    }
    
    // 相册, OCR都支持
    if ([dict[@"isCamera"] boolValue] == false) {
        WS(weakSelf);
        [self showActionSheetWithTitles:@[@"身份证识别",@"从相册中选择",@"取消"] message:nil inController:self titleAction:^(NSUInteger index) {
            SS(strongSelf);
            if (index == 2) return;
            
            if (index == 0) {
                
                [strongSelf getOcr:sender withCallBack:callBack];
            }
            if (index == 1) {
                strongSelf.callBack = callBack;
                [strongSelf showLibrary];
            }
        }];
    }
    
    else
    {
        [self getOcr:sender withCallBack:callBack];
    }

}

- (void)showImageVC{
    WS(weakSelf);
    [self showActionSheetWithTitles:@[@"拍照",@"从相册中选择",@"取消"] message:nil inController:self titleAction:^(NSUInteger index) {
        SS(strongSelf);
        if (index == 2) return;
        
        if (index == 0) {
            
            [self showCamera];
        }
        if (index == 1) {
            
            [strongSelf showLibrary];
        }
    }];
}

- (void)showLibrary{
    if (!self.isAuthorizePhotos) {
        [self showAlertWithSureTitle:@"去开启" cancleTitle:nil alertTitle:@"" message:@"请您设置允许APP访问您的相册\n设置>隐私>相册" sureAction:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        return;
    }
    self.canmeraController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.canmeraController animated:true completion:nil];
}

- (void)showCamera{
    if (!self.isAuthorizeCamera) {
        [self showAlertWithSureTitle:@"去开启" cancleTitle:nil alertTitle:@"" message:@"请您设置允许APP访问您的相机\n设置>隐私>相机" sureAction:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        return;
    }
    self.canmeraController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.canmeraController animated:true completion:nil];
}


- (void)getOcr:(id)sender withCallBack:(WVJBResponseCallback)callBack{
#if TARGET_IPHONE_SIMULATOR
#else
    NSDictionary *dict = [self decodeSender:sender];
    TBOCRType type = [dict[@"ocrType"] integerValue];

    switch (type) {
        case TBOCRTypeFace:
        case TBOCRTypeNation:
        {
#if TARGET_IPHONE_SIMULATOR
#else
            if (!self.isAuthorizeCamera) {
                [self showAlertWithSureTitle:@"去开启" cancleTitle:nil alertTitle:@"" message:@"请您设置允许APP访问您的相机\n设置>隐私>相机" sureAction:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                return;
            }
            
            MGIDCardManager *cardManager = [[MGIDCardManager alloc] init];
            WS(weakSelf);
            [cardManager IDCardStartDetection:self
                                   IdCardSide:type == TBOCRTypeFace ? IDCARD_SIDE_FRONT : IDCARD_SIDE_BACK
                                       finish:^(MGIDCardModel *model) {
                                           UIImage *image = [model croppedImageOfIDCard];
                                           NSData *data = [image compressScaleImageForSize:100];
                                           [RectManager getOCRInfoWithData:data type:type res:^(TBOCRInfo *ocrInfo) {
                                               NSMutableDictionary *dict = ocrInfo.mj_keyValues;
                                               SS(strongSelf);
                                               [strongSelf readyWithParam:dict imageData:data callBack:callBack];
                                           }];
                                           
                                       }
                                         errr:^(MGIDCardError errorType) {
                                             //                                             weakSelf.cardView.image = nil;
                                         }];
#endif
            
        }
            break;
            
        default:
        {

            WS(weakSelf);
            TBOCRVC *ocrVC = [[TBOCRVC alloc] initWithOcrType:type];
            TBNavigationVC *navi = [[TBNavigationVC alloc] initWithRootViewController:ocrVC];
            ocrVC.didScanSuc = ^(TBOCRInfo *info) {
                TBOCRInfo *infoModel = info;
                SS(strongSelf);
                if (type == TBOCRTypeBank) {
                    infoModel.cropImage = nil;
                    callBack(infoModel.mj_keyValues.mj_JSONString);
                    return;
                }
                
                NSData *imageData = [info.cropImage compressScaleImageForSize:kCompressSize];
                NSMutableDictionary *dict = infoModel.mj_keyValues;
                dict[@"id"] = info.imageId;
                [strongSelf readyWithParam:dict imageData:imageData callBack:callBack];
            };
            [self presentViewController:navi animated:true completion:nil];
        }
            break;
    }
#endif
}


- (void)readyWithParam:(NSMutableDictionary *)dict imageData:(NSData *)imageData callBack:(WVJBResponseCallback)callBack{
   
    if ([self.url containsString:@"appss.do"]) {
        NSDictionary *body =@{@"ocrServiceRes" : @{@"body" : dict ? : @""}.mj_JSONString};
        callBack(body.mj_JSONString);
        return;
    }
    
    dict[@"cropImage"] = nil;
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithDictionary:@{@"ocrServiceRes" : dict}];
    NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    body[@"id"] = dict[@"imageId"];
    body[@"img"] = [NSString stringWithFormat:@"data:image/png;base64,%@",encodedString];
    callBack(body.mj_JSONString);
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:true completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = [image compressScaleImageForSize:kCompressSize];
    TBOCRType type = [self.ocrDict[@"ocrType"] integerValue];
    switch (type) {
        case TBOCRTypeNation:
        case TBOCRTypeFace:
        {
            WS(weakSelf);
            [RectManager getOCRInfoWithData:imageData type:type res:^(TBOCRInfo *ocrInfo) {
                NSMutableDictionary *dict = ocrInfo.mj_keyValues;
                SS(strongSelf);
                [strongSelf readyWithParam:dict imageData:imageData callBack:strongSelf.callBack];
            }];
            return;
        }
            break;
            
        default:
            break;
    }
    
    [SVProgressHUD showWithStatus:@"图片上传中..."];
    
    [[TBNetAPIClient sharedClient] POSTWithURLStr:kDocFileUpload imageData:imageData requestResult:^(NSInteger code, NSDictionary *responseObject) {
        if (code == 0) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            dict[@"img"] = [NSString stringWithFormat:@"data:image/png;base64,%@",encodedString];
            dict[@"id"] = responseObject[@"body"][kImageName];
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            self.callBack(dict.mj_JSONString);
        }
        
        else
        {
            [SVProgressHUD showInfoWithStatus:responseObject[HTTPErrorMessageKey]];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (UIImagePickerController *)canmeraController{
    if (!_canmeraController) {
        self.canmeraController = [UIImagePickerController new];
        self.canmeraController.navigationBar.barTintColor = [UIColor whiteColor];
        self.canmeraController.navigationBar.tintColor = [UIColor whiteColor];
        self.canmeraController.delegate = self;
    }
    return _canmeraController;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation TBWechatShare
@end
