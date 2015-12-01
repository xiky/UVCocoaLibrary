//
//  UVCache.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/13.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "UVCache.h"
#import "UVConest.h"
#import "UVError.h"
#import "UVHttpClient.h"
#import "NSString+UVUtils.h"

@implementation UVCache
{
    
}

- (id)init
{
    if(self = [super init])
    {
        _folder = @"UVCache";
    }
    return self;
}

- (void)dataWithUrl:(NSString*)url_ finish:(void (^)(UVError *error, NSString *path_))finish_
{
    NSString *path = UV_PATH_CACHE_WITH_NAME(_folder);
    NSFileManager *m = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if(![m fileExistsAtPath:path isDirectory:&isDirectory])
    {
        NSError *err;
        [m createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
        
        if(err != nil)
        {
            UVError *error = [UVError errorWithCodeAndMessage:UV_GENERAL_ERROR_CODE message:@"创建缓存目录失败"];
            if(finish_ != nil)
            {
                finish_(error,nil);
            }
            return;
        }
    }
    
    NSString *filename = [url_ md5passwd];
    NSString *full = [path stringByAppendingPathComponent:filename];
    if([m fileExistsAtPath:full])
    {
        //判断文件是否有效
        NSError *error;
        NSDictionary *attr = [m attributesOfItemAtPath:full error:&error];
        if(error == nil)
        {
            NSNumber  *size = attr[NSFileSize];
            if(size.floatValue > 0)
            {
                if(finish_ != nil)
                {
                    finish_(nil,full);
                }
                return;
            }
        }
        //无效文件 尝试删除
        [m removeItemAtPath:full error:&error];
    }
   

    UVHttpClient *client = [[UVHttpClient alloc] init];
    client.delegate = _delegate;
    [client download:[NSURL URLWithString:url_] save:full finish:^(NSError *error_) {
        if(error_ != nil)
        {
            UVError *error = [UVError errorWithCodeAndMessage:UV_GENERAL_ERROR_CODE message:@"加载远程文件失败"];
            if(finish_ != nil)
            {
                finish_(error,nil);
            }
            return ;
        }
        
        if(finish_ != nil)
        {
            finish_(nil,full);
        }
        
    }];
 
//    UVRequest *request =
}

- (BOOL)existsCacheByUrl:(NSString*)url_
{
    NSString *path = UV_PATH_CACHE_WITH_NAME(_folder);
    
    NSFileManager *m = [NSFileManager defaultManager];
    NSString *filename = [url_ md5passwd];
    NSString *full = [path stringByAppendingPathComponent:filename];
    return [m fileExistsAtPath:full];
}

- (void)cleanCacheByUrl:(NSString*)url_
{
    NSString *path = UV_PATH_CACHE_WITH_NAME(_folder);
    
    NSFileManager *m = [NSFileManager defaultManager];
    NSString *filename = [url_ md5passwd];
    NSString *full = [path stringByAppendingPathComponent:filename];
    if([m fileExistsAtPath:full])
    {
        NSError *error;
        [m removeItemAtPath:full error:&error];
    }
}

- (float)calcCachePathFileSize:(NSString*)folder_
{
    NSFileManager *m = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    if(folder_ != nil)
    {
        path = [path stringByAppendingPathComponent:folder_];
    }
    NSDirectoryEnumerator *enumr = [m enumeratorAtPath:path];
    float countsize = 0.f;
    NSString *row = enumr.nextObject;
    
    NSString *p;
    NSError *error;
    NSDictionary *attr;
    NSNumber *size;
    BOOL isDir = NO;
    while (row != nil)
    {
        p = [path stringByAppendingPathComponent:row];
        isDir = NO;
        if([m fileExistsAtPath:p isDirectory:&isDir])
        {
            if(!isDir)
            {
                attr = [m attributesOfItemAtPath:p error:&error];
                if(error == nil)
                {
                    size = attr[NSFileSize];
                    countsize = countsize + size.floatValue;
                }
            }
        }
        row = enumr.nextObject;
    }
    return countsize;
    
}

- (void)cleanCachePathFiles:(NSString*)folder_
{
    NSFileManager *m = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    if(folder_ != nil)
    {
        path = [path stringByAppendingPathComponent:folder_];
    }
    NSDirectoryEnumerator *enumr = [m enumeratorAtPath:path];

    NSString *row = enumr.nextObject;
    
    NSString *p;
    NSError *error;

    BOOL isDir = NO;
    while (row != nil)
    {
        p = [path stringByAppendingPathComponent:row];
        isDir = NO;
        if([m fileExistsAtPath:p isDirectory:&isDir])
        {
            if(!isDir)
            {
                [m removeItemAtPath:p error:&error];
            }
        }
        row = enumr.nextObject;
    }
}
@end
