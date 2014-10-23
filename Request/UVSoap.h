//
//  UVSoap.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 14/10/20.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UVSoap : NSObject

/**
 *  发送soap请求
 *
 *  @param method_ 方法
 *  @param data_   参数
 *
 *  @return 返回结果
 */
+ (NSDictionary*)sendSoap:(NSURL*)url_ method:(NSString*)method_ data:(NSString*)data_;
@end
