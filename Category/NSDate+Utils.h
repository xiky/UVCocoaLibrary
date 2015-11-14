//
//  NSDate+Utils.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/6.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)

- (NSString*)stringBYFmt:(NSString*)fmt_;
/**
 *  <#Description#>
 *
 *  @param fmt_  <#fmt_ description#>
 *  @param time_ 时区 如 Asia/Shanghai
 *
 *  @return <#return value description#>
 */
- (NSString*)stringBYFmt:(NSString *)fmt_ timeZone:(NSString*)time_;
@end
