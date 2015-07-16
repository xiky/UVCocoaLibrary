//
//  UVDevice.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/6/5.
//  Copyright (c) 2015年 Chenjiaxin. All rights reserved.
//

#import "UVDevice.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#include "UVUtils.h"

@implementation UVDevice



- (NSString*)UUID
{
//        CFUUIDRef puuid = CFUUIDCreate( nil );
//        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
//        NSString * result = (__bridge NSString *)uuidString;
//        CFRelease(puuid);
//        CFRelease(uuidString);
//        return result;
    NSString *ident = [NSString stringWithFormat:@"%@_%@",[self MAC],[[NSBundle mainBundle] bundleIdentifier]];
    NSLog(@"ident:%@",ident);
    return [UVUtils md5passwd:ident];
}
- (NSString *)getIPAddress
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end
