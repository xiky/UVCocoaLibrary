//
//  UVSafeData.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 16/1/3.
//  Copyright © 2016年 Uniview. All rights reserved.
//

#import "UVSafeData.h"

@implementation NSString (UVSafeData)

+ (NSString*)uv_stringByObject:(id)obj_ default:(NSString*)default_ trim:(BOOL)trim_
{
    if([obj_ isKindOfClass:[NSNull class]])
    {
        return default_;
    }
    if(obj_ == nil)
    {
        return  default_;
    }
    NSString *tmp = [NSString stringWithFormat:@"%@",obj_];
    if(trim_)
    {
        tmp= [tmp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    return tmp;
}
@end

@implementation NSNumber (UVSafeData)

+ (NSNumber*)uv_numberByObject:(id)obj_ default:(NSNumber *)default_
{
    if([obj_ isKindOfClass:[NSNull class]])
    {
        return default_;
    }
    if(obj_ == nil)
    {
        return  default_;
    }
    if(![obj_ isKindOfClass:[NSNumber class]] && ![obj_ isKindOfClass:[NSString class]])
    {
        return default_;
    }
    if([obj_ isKindOfClass:[NSString class]])
    {
        NSString *t = (NSString*)obj_;
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        NSNumber *num = [f numberFromString:t];
        if(!num)
        {
            return default_;
        }
        return num;
    }
    return (NSNumber*)obj_;
}
@end

@implementation NSDictionary (UVSafeData)

+ (NSDictionary*)uv_dictionaryByObject:(id)obj_ default:(NSDictionary *)default_
{
    if([obj_ isKindOfClass:[NSNull class]])
    {
        return default_;
    }
    if(obj_ == nil)
    {
        return  default_;
    }
    if(![obj_ isKindOfClass:[NSDictionary class]])
    {
        return default_;
    }
    return (NSDictionary*)obj_;
}
@end

@implementation NSArray (UVSafeData)

+ (NSArray*)uv_arrayByObject:(id)obj_ default:(NSArray *)default_ filterNull:(BOOL)filternull_ trim:(BOOL)trim_
{
    if([obj_ isKindOfClass:[NSNull class]])
    {
        return default_;
    }
    if(obj_ == nil)
    {
        return  default_;
    }
    if(![obj_ isKindOfClass:[NSArray class]])
    {
        return default_;
    }
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *objs = (NSArray*)obj_;
    //复制数组 过滤数组对象为空的对象
    NSString *str;
    for(id row in objs)
    {
        if([row isKindOfClass:[NSNull class]] && filternull_)
        {
            continue;
        }
        //如果是字符串，则自动过滤空格式
        if([row isKindOfClass:[NSString class]])
        {
            str = [NSString uv_stringByObject:row default:@"" trim:trim_];
            [arr addObject:str];
        }
        else
        {
            [arr addObject:row];
        }
        
    }
    return arr;
}
@end
