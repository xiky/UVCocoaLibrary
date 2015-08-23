//
//  UVCache.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/13.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UVCache : NSObject

//+ (void)dataWithUrl:(NSString*)url_ finish:();
//+ (void)delCacheByUrl:(NSString*)url_;
//+ (BOOL)existsCacheByUrl:(NSString*)url_;
- (float)calcCachePathFileSize;
- (void)cleanCachePathFiles;
@end
