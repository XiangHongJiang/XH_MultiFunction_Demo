//
//  App_Header_Define.h
//  App_General_Template
//
//  Created by JXH on 2017/6/27.
//  Copyright © 2017年 JXH. All rights reserved.
//

#ifndef App_Header_Define_h
#define App_Header_Define_h

//  Log:日志输出
#ifdef DEBUG
#define JLog(Format, ...) fprintf(stderr,"%s: %s->%d\n%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat:Format, ##__VA_ARGS__] UTF8String])
#else
#define JLog(Format, ...)
#endif

//  Font:字体&大小
#define FontName_Size(fontName, fontSize)      (fontName).length ? [UIFont fontWithName:fontName size:fontSize] : FontSystem(fontSize)
#define Font(fontSize)      [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize]
#define FontBold(fontSize)      [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize]
#define FontSystem(fontSize)      [UIFont systemFontOfSize:fontSize]
#define FontSystemBold(fontSize)  [UIFont boldSystemFontOfSize:fontSize]

//  Color:颜色
#define RandomColor         Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define Color(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ColorRGBA(r, g, b, alpha)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:alpha]


//app 配置
#define APP_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_Channel @"AppStore"

#endif /* App_Header_Define_h */
