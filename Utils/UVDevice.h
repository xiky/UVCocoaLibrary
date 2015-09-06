//
//  UVDevice.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/6/5.
//  Copyright (c) 2015年 Chenjiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UVDevice : NSObject

- (NSString*)appVersionName;
- (NSString*)appVersionCode;
- (NSString *)bundleid;
- (NSString*)getIPAddress;
@end
