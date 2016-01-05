//
//  UVSafeData.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 16/1/3.
//  Copyright © 2016年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UVSafeData)
/**
 *  任意对象转换返回一个安全的string
 *
 *  @param obj_     要转换的对象
 *  @param default_ 默认值 如 @""
 *  @param trim_    是否自动去掉空白字符
 *
 *  @return NSString
 */
+ (NSString*)uv_stringByObject:(id)obj_ default:(NSString*)default_ trim:(BOOL)trim_;
@end

@interface NSNumber (UVSafeData)
/**
 *  任意对象转换返回一个安全的NSNumber
 *
 *  @param obj_     要转换的对象
 *  @param default_ 默认值，如 @(0)
 *
 *  @return NSNumber
 */
+ (NSNumber*)uv_numberByObject:(id)obj_ default:(NSNumber*)default_;
@end

@interface NSDictionary (UVSafeData)
/**
 *  任意对象转换返回一个安全的NSDictory
 *
 *  @param obj_     要转换的对象
 *  @param default_ 默认值 哪 @{}
 *
 *  @return NSDictionary
 */
+ (NSDictionary*)uv_dictionaryByObject:(id)obj_ default:(NSDictionary*)default_;
@end

@interface NSArray (UVSafeData)
/**
 *  任意对象转换返回一个安全的NSArray
 *
 *  @param obj_        要转换的对象
 *  @param default_    默认值 如 @[]
 *  @param filternull_ 是否过滤 NSNull 元素
 *  @param trim_       字符串元素，是否过滤空白
 *
 *  @return NSArray
 */
+ (NSArray*)uv_arrayByObject:(id)obj_ default:(NSArray*)default_ filterNull:(BOOL)filternull_ trim:(BOOL)trim_;
@end
