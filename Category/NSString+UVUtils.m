//
//  NSString+UVUtils.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/26.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "NSString+UVUtils.h"

@implementation NSString (UVUtils)

- (BOOL)matchByRegpx:(NSString*)reg_
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg_];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
@end
