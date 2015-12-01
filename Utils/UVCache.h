//
//  UVCache.h
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/13.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UVError;
@protocol UVHttpClientDelegate;
/**
 *  缓存封装类 指定一个URL，将URL的二进制文件内容下载到沙盘Cache目录下 使用URL进行MD5后做为文件名。因此可判断文件是否已经缓存过
 */
@interface UVCache : NSObject
/**
 *  下载进度回调
 */
@property (nonatomic,weak) id<UVHttpClientDelegate> delegate;
/**
 *  缓存目录 默认为UVCache
 */
@property (nonatomic,strong) NSString *folder;

/**
 *  根据网址获取数据  如果本地没有缓存，则自动加载并缓存  如果error不为空，path_为本地存在地址
 *
 *  @param url_    远程文件网址
 *  @param finish_ 操作完成后的回调 如果error为空，path_为本地存在地址；如果error不为空，则认为产生了错误
 */
- (void)dataWithUrl:(NSString*)url_ finish:(void (^)(UVError *error, NSString *path_))finish_;

/**
 *  根据网址判断本地缓存是否存在
 *
 *  @param url_ 远程文件网址
 *
 *  @return BOOL
 */
- (BOOL)existsCacheByUrl:(NSString*)url_;

/**
 *  根据网址清除本地缓存
 *
 *  @param url_ 远程文件网址
 */
- (void)cleanCacheByUrl:(NSString*)url_;

/**
 *  计算指定缓存目录所有文件大小 包括子目录
 *
 *  @param folder_ 沙盘Cache目录下的子目录,如果folder_为空，则为沙盘Cache目录
 *
 *  @return float 所有文件的总大小 注：如果目录文件较多，建议放在非主线程中执行
 */
- (float)calcCachePathFileSize:(NSString*)folder_;

/**
 *  删除缓存目录的所有数据 包括子目录
 *
 *  @param folder_ 沙盘Cache目录下的子目录,如果folder_为空，则为沙盘Cache目录
 */
- (void)cleanCachePathFiles:(NSString*)folder_;
@end
