//
//  NSDate+Utils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/6.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UVUtils)

- (NSString*)uv_stringByFmt:(NSString*)fmt_;
/**
 *  格式化时间，返回字符串
 *
 *  @param fmt_  设置nil，默认为yyyy-MM-dd HH:mm:ss
 *  @param time_ 时区  设置nil，默认为Asia/Shanghai
 *
 *  @return NSString
 */
- (NSString*)uv_stringByFmt:(NSString *)fmt_ timeZone:(NSString*)time_;
@end
