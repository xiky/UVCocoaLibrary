//
//  UVCache.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/13.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UVError;
@interface UVCache : NSObject

//缓存目录 默认 UVCache
@property (nonatomic,strong) NSString *folder;

//根据网址获取数据  如果本地没有缓存，则自动加载并缓存  如果error不为空，path_为本地存在地址
- (void)dataWithUrl:(NSString*)url_ finish:(void (^)(UVError *error, NSString *path_))finish_;

//根据网址判断本地缓存是否存在
- (BOOL)existsCacheByUrl:(NSString*)url_;

//根据网址清除本地缓存
- (void)cleanCacheByUrl:(NSString*)url_;

//计算缓存目录文件大小 如果folder_为空，则为缓存的根目录
- (float)calcCachePathFileSize:(NSString*)folder_;

//清除缓存目录的所有数据 如果folder_为空，则为缓存的根目录
- (void)cleanCachePathFiles:(NSString*)folder_;
@end
