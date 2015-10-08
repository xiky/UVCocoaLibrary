//
//  UVValidate.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/26.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  正则验证类
 */
@interface UVValidate : NSObject

/**
 *  必须存在值
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)require:(NSString*)str_;
/**
 *  是否为手机号码
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)mobile:(NSString*)str_;
/**
 *  是否为邮箱
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)email:(NSString*)str_;
/**
 *  是否为电话号码
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)phone:(NSString*)str_;
/**
 *  是否为网址
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)url:(NSString*)str_;
/**
 *  是否为数字
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)number:(NSString*)str_;
/**
 *  是否为邮编
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)zip:(NSString*)str_;
/**
 *  是否为QQ号码
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)qq:(NSString*)str_;
/**
 *  是否为整数
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)integer:(NSString*)str_;
/**
 *  是否为浮点数
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)isDouble:(NSString*)str_;
/**
 *  是否为英文字母
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)english:(NSString*)str_;
/**
 *  是否为中文字母
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)chinese:(NSString*)str_;
/**
 *  是否为有效用户名
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)username:(NSString*)str_;
/**
 *  是否为弱密码
 *
 *  @param str_ 要验证的字符串
 *
 *  @return BOOL
 */
- (BOOL)unsafe:(NSString*)str_;
/**
 *  是否指定长度的字符串
 *
 *  @param str_ 要验证的字符串
 *  @param min_ 字符串最小长度
 *  @param max_ 字符串最大长度
 *
 *  @return BOOL
 */
- (BOOL)limit:(NSString*)str_ min:(NSInteger)min_ max:(NSInteger)max_;
/**
 *  是否为指定大小的数字
 *
 *  @param str_ 要验证的字符串
 *  @param min_ 数字最小值
 *  @param max_ 数字最大值
 *
 *  @return BOOL
 */
- (BOOL)range:(NSString*)str_ min:(NSInteger)min_ max:(NSInteger)max_;
/**
 *  手动设置正则验证
 *
 *  @param str_  要验证的字符串
 *  @param repx_ 正则表达式 如@"^[\u0391-\uFFE5]+$"
 *
 *  @return BOOL
 */
- (BOOL)custom:(NSString *)str_ repx:(NSString*)repx_;
@end
