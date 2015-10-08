//
//  UVDevice.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/6/5.
//  Copyright (c) 2015年 Chenjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UVDevice : NSObject

/**
 *  当前APP的外部版本号
 *
 *  @return NSString
 */
- (NSString*)appVersionName;
/**
 *  当前APP的内部版本号
 *
 *  @return NSString
 */
- (NSString*)appVersionCode;
/**
 *  当前APP的bundle id
 *
 *  @return NSString
 */
- (NSString *)bundleid;
/**
 *  当前设备IP地址
 *
 *  @return <#return value description#>
 */
- (NSString*)getIPAddress;
@end
