//
//  App_Header_Enum.h
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#ifndef App_Header_Enum_h
#define App_Header_Enum_h

#pragma mark - AppVCType :VC的加载类型

typedef NS_ENUM(NSInteger, APPVCType) {//viewController加载类型
    APPVCType_Default,//class
    APPVCType_XIB,//Xib
    APPVCType_StoryBoard,//SB
};

#pragma mark - AppBaseTableViewRefreshType：当前刷新类型
typedef NS_ENUM(NSUInteger, RefreshType) {
    RefreshTypeNone,
    RefreshTypeHeader,
    RefreshTypeFooter
};

#endif /* App_Header_Enum_h */
