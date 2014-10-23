//
//  UVUtils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 13-8-21.
//  Copyright (c) 2013年 XXXX. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "UVUtils.h"

@implementation UVUtils

+(NSString*)stringFromTime:(NSDate*)date_
{
    NSString *format_ = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format_];
    return [formatter stringFromDate:date_];
}

+ (NSString *) md5passwd: (NSString *) passwd
{
    if(nil == passwd)
    {
        return [self md5passwd:@""];
    }
    const char *cpass = [passwd UTF8String];
    unsigned char result[32];
    CC_MD5(cpass, (uint)strlen(cpass), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
