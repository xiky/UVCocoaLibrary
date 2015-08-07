// Copyright (c) 2011-2014, Zhejiang XXXX Technologies Co., Ltd. All rights reserved.
// --------------------------------------------------------------------------------
// UVConest.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 2013-11-19
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
//

#ifndef UVCocoaLibrary_UVConest_h
#define UVCocoaLibrary_UVConest_h

#pragma mark - 全局定义

//临时目录 返回 NSURL
#define TEMP_FILE_PATH(name_) [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), name_]]
//文档目录 返回NSString
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//应用程序主目录 返回NSString
#define PATH_OF_APP_HOME    NSHomeDirectory()
//应用程序临时目录 返回NSString
#define PATH_OF_TEMP        NSTemporaryDirectory()

//当前IOS版本
#define UV_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//读取语言
#define L(key) NSLocalizedString(key,nil)
//日期格式
#define kDateFormat         @"yyyy-MM-dd HH:mm:ss"

//从十六进制中返回UIColor 使用方法：[view setBackgroundColor:UI_COLOR_FROM_RGB(0x169E6F)];
#define UI_COLOR_FROM_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#endif
