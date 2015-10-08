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
/**
 *  给定一个目录或文件名称，返回TEMP目录下的绝对路径
 *
 *  @param name_ 文件或目录的名字
 *
 *  @return NSString
 */
#define UV_PATH_TEMP_WITH_NAME(name_) [NSTemporaryDirectory() stringByAppendingPathComponent:name_]

/**
 *  返回Document目录下的绝对路径
 *
 *  @return NSString
 */
#define UV_PATH_DOCUMENT (NSString*)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/**
 *  给定一个目录或文件名称，返回Document目录下的绝对路径
 *
 *  @param NSString 文件或目录的名字
 *
 *  @return NSString
 */
#define UV_PATH_DOCUMENT_WITH_NAME(name_) [(NSString*)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:name_]

/**
 *  给定一个目录或文件名称，返回Cache目录下的绝对路径
 *
 *  @param NSString 文件或目录的名字
 *
 *  @return NSString
 */
#define UV_PATH_CACHE_WITH_NAME(name_) [(NSString*)([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]) stringByAppendingPathComponent:name_]

/**
 *  返回Cache目录下的绝对路径
 *
 *  @return NSString
 */
#define UV_PATH_CACHE (NSString*)[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 *  给定一个目录或文件名称，返回Home目录下的绝对路径
 *
 *  @param NSString 文件或目录的名字
 *
 *  @return NSString
 */
#define UV_PATH_HOME_WITH_NAME(name_) [NSHomeDirectory() stringByAppendingPathComponent:name_]

/**
 *  当前IOS版本
 *
 *  @return CGFloat
 */
#define UV_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  当前屏幕的宽度
 *
 *  @return CGFloat
 */
#define UV_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**
 *  当前屏幕的高度
 *
 *  @return CGFloat
 */
#define UV_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  使用一个R、G、B值，返回UIColor对象
 *
 *  @param r R的值 如199.f
 *  @param g G的值 如199.f
 *  @param b B的值 如199.f
 *
 *  @return UIColor
 */
#define UV_COLOR_RGB(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
/**
 *  使用一个R、G、B值，返回UIColor对象
 *
 *  @param r R的值 如199.f
 *  @param g G的值 如199.f
 *  @param b B的值 如199.f
 *  @param alpha alpha的值 如1.f
 *
 *  @return UIColor
 */
#define UV_COLOR_RGB_ALPHA(r,g,b,alpha) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:alpha]

/**
 *  使用一个16进制颜色值返回UIColor对象
 *
 *  @param hexValue 16进制颜色值 如0x169E6F
 *
 *  @return UIColor
 */
#define UV_COLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

/**
 *  快捷读取语言字符串
 *
 *  @param key
 *
 *  @return NSString
 */
#define UV_L(key) NSLocalizedString(key,nil)
/**
 *  默认日期格式
 *
 *  @return NSString
 */
#define UV_DateFormat         @"yyyy-MM-dd HH:mm:ss"

#endif
