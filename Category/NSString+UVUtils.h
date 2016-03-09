//
//  NSString+UVUtils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/26.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (UVUtils)


- (BOOL)uv_matchByRegpx:(NSString*)reg_;

/** 返回md5加密串
 
 @param NSString 要加密的明文串
 @return NSString 返回加密后的32位md5密文
 */
- (NSString *)uv_md5passwd;

/**
 */
- (NSString*)uv_sha256passwd;

/**
 *  获取字符占用大小  主要适应一行文字的情况
 *
 *  @param font_ 字符串使用字体
 *  @param size_ 限制的尺寸
 *
 *  @return CGSize
 */
- (CGSize)uv_sizeByFont:(UIFont*)font_ maxSize:(CGSize)size_;

/**
 *  获取字符占用大小  主要适应多行文字的情况
 *
 *  @param font_ 字符串使用字体
 *  @param size_ 限制的尺寸
 *
 *  @return CGSize
 */
- (CGSize)uv_sizeByFontHeight:(UIFont*)font_ maxSize:(CGSize)size_;

/**
 *  <#Description#>
 *
 *  @param fmt_  时间格式 nil则默认yyyy-MM-dd HH:mm:ss
 *  @param time_ 时区 如 Asia/Shanghai
 *
 *  @return <#return value description#>
 */
- (NSDate*)uv_dateByFmt:(NSString*)fmt_ timeZone:(NSString*)time_;
@end
