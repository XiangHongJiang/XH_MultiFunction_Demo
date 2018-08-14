//
//  Logs_PchConfig.h
//  XH_MultiFunction_Demo
//
//  Created by MrYeL on 2018/8/14.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#ifndef Logs_PchConfig_h
#define Logs_PchConfig_h

/** 日志上传*/
#import <DDLog.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;//收集所有
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;//收集 Error、Waring、Info
#endif

#import "XHLogsManager.h"

//#import <YYKit.h>



#endif /* Logs_PchConfig_h */
