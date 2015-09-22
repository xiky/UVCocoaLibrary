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

//临时目录 返回 NSString
#define UV_PATH_TEMP_WITH_NAME(name_) [NSTemporaryDirectory() stringByAppendingPathComponent:name_]

//文档目录 返回NSString
#define UV_PATH_DOCUMENT (NSString*)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define UV_PATH_DOCUMENT_WITH_NAME(name_) [(NSString*)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:name_]

//缓存目录
#define UV_PATH_CACHE_WITH_NAME(name_) [(NSString*)([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]) stringByAppendingPathComponent:name_]

//缓存目录
#define UV_PATH_CACHE (NSString*)[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//主目录
#define UV_PATH_HOME_WITH_NAME(name_) [NSHomeDirectory() stringByAppendingPathComponent:name_]

//当前IOS版本
#define UV_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define UV_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define UV_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//读取语言
#define L(key) NSLocalizedString(key,nil)
//日期格式
#define kDateFormat         @"yyyy-MM-dd HH:mm:ss"

//从十六进制中返回UIColor 使用方法：[view setBackgroundColor:UI_COLOR_FROM_RGB(0x169E6F)];
#define UI_COLOR_FROM_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif
