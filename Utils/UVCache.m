//
//  UVCache.m
//  UVCocoaLibrary
//
//  Created by chenjiaxin on 15/8/13.
//  Copyright (c) 2015年 Uniview. All rights reserved.
//

#import "UVCache.h"

@implementation UVCache

- (float)calcCachePathFileSize
{
    NSFileManager *m = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
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

- (void)cleanCachePathFiles
{
    NSFileManager *m = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
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
