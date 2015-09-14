// Copyright (c) 2011-2014, Zhejiang XXXX Technologies Co., Ltd. All rights reserved.
// --------------------------------------------------------------------------------
// UVUtils.h
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 2013-11-19
// Author: chenjiaxin/00891
// Description:工具函数类
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
//
/** 工具类
 
 使用示例：
 
        
 
 */
@class UIViewController;
@interface UVUtils : NSObject

/** 返回md5加密串
 
 @param NSString 要加密的明文串
 @return NSString 返回加密后的32位md5密文
 */
+ (NSString *)md5passwd:(NSString*)str_;

//获取最顶层的viewcontroller
- (UIViewController *)topViewController;
@end
