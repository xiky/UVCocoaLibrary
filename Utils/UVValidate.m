//
//  UVValidate.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/26.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "UVValidate.h"

@implementation UVValidate

- (BOOL)require:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@".+"];
    return result;
}
- (BOOL)mobile:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^1[3-9]\\d{9}$"];
    return result;
}
- (BOOL)email:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$/"];
    return result;
}
- (BOOL)phone:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^((\\(\\d{2,3}\\))|(\\d{3}\\-))?(\\(0\\d{2,3}\\)|0\\d{2,3}-)?[1-9]\\d{6,7}(\\-\\d{1,4})?$"];
    return result;
}
- (BOOL)url:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^http[s]?:\\/\\/[A-Za-z0-9]+\\.[A-Za-z0-9]+[\\/=\\?%\\-&_~`@[\\]\\':+!]*([^<>\\\"\\\"])*$"];
    return result;
}

- (BOOL)number:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^\\d+$"];
    return result;
}
- (BOOL)zip:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^[0-9]\\d{5}$"];
    return result;
}
- (BOOL)qq:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^[1-9]\\d{4,11}$"];
    return result;
}
- (BOOL)integer:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^[-\\+]?\\d+$"];
    return result;
}
- (BOOL)isDouble:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^[-\\+]?\\d+(\\.\\d+)?$"];
    return result;
}
- (BOOL)english:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^[A-Za-z]+$"];
    return result;
}
- (BOOL)chinese:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^[\u0391-\uFFE5]+$"];
    return result;
}
- (BOOL)username:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^[A-Za-z][A-Za-z0-9_]{3,19}$"];
    return result;
}
- (BOOL)unsafe:(NSString*)str_
{
    BOOL result = [self custom:str_ repx:@"^(([A-Z]*|[a-z]*|\\d*|[-_\\~!@#\\$%\\^&\\*\\.\\(\\)\\[\\]\\{\\}<>\?\\\\\\/\\'\\\"]*)|.{0,5})$|\\s"];
    return result;
}
- (BOOL)limit:(NSString*)str_ min:(NSInteger)min_ max:(NSInteger)max_
{
    if(str_.length>=min_ && str_.length <= max_)
    {
        return YES;
    }
    return NO;
}
- (BOOL)range:(NSString*)str_ min:(NSInteger)min_ max:(NSInteger)max_
{
    if(![self number:str_])
    {
        return NO;
    }
    NSInteger value = str_.integerValue;
    if(value >= min_ && value <= max_)
    {
        return YES;
    }
    return NO;
}

- (BOOL)custom:(NSString *)str_ repx:(NSString*)repx_
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", repx_];
    BOOL isMatch = [pred evaluateWithObject:str_];
    return isMatch;
}
@end
