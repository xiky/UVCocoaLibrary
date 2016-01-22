//
//  NSString+UVUtils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/26.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "NSString+UVUtils.h"


#import <CommonCrypto/CommonDigest.h>

@implementation NSString (UVUtils)

- (BOOL)uv_matchByRegpx:(NSString*)reg_
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg_];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)uv_md5passwd
{
    const char *cpass = [self UTF8String];
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

- (NSString*)uv_sha256passwd
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

- (CGSize)uv_sizeByFont:(UIFont*)font_ maxSize:(CGSize)size_
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font_,NSFontAttributeName,nil];
    // ios 7
    CGSize sizeText = [self boundingRectWithSize:size_ options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return sizeText;
}
@end
