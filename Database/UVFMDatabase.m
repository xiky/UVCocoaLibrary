//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVFMDBDatabase.m
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 14-3-6
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-3-6  c00891 create
//

#import "UVFMDatabase.h"
#import "FMDatabase.h"
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

static UVFMDatabase *_instance = nil;
@implementation UVFMDatabase

#pragma mark - init
-(void)initData
{
    //
    _isOpened = NO;
}

- (id)init
{
    if(self = [super init])
    {
        [self initData];
    }
    return self;
}

+ (UVFMDatabase*)instance
{
    static dispatch_once_t pred = 0;
    
    dispatch_once(&pred, ^{
        _instance = [[UVFMDatabase alloc] init];
    });
    return _instance;
}

- (NSError*)openDataBaseByName:(NSString*)name_
{
    _dbName = name_;
    NSString * doc = PATH_OF_DOCUMENT;
    NSString * path = [doc stringByAppendingPathComponent:_dbName];
    _db = [FMDatabase databaseWithPath:path];
    if(![_db open])
    {
        NSLog(@"open database failed,path:%@,code:%d,message:%@",path,_db.lastErrorCode,_db.lastErrorMessage);
        return _db.lastError;
    }
    _isOpened = YES;
    return nil;
}
- (BOOL)existsTableByName:(NSString*)name_
{
   FMResultSet *data =  [_db executeQuery:@"select rootpage from sqlite_master where type ='table' and name=? limit 1",name_];
    BOOL result = [data next];
    [data close];
    return result;
}

- (NSError*)installTableDataByFile:(NSURL*)file_ charset:(NSStringEncoding)encode_
{
    NSError *error;
    NSString *str = [NSString stringWithContentsOfURL:file_ encoding:encode_ error:&error];
    if(error)
    {
        NSLog(@"initDataByFile failed,error:%@",error);
        return error;
    }
    NSArray *list = [str componentsSeparatedByString:@"\n"];
    BOOL result;
    NSString *tmp;
    for(NSString *sql in list)
    {
        tmp = [sql stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        result = [_db executeUpdate:tmp];
        if(!result)
        {
            NSLog(@"initDataByFile,exe sql failed,code:%d,message:%@,sql:%@",_db.lastErrorCode,_db.lastErrorMessage,tmp);
        }
        tmp = nil;
    }
    list = nil;
    str = nil;
    return error;
}
- (BOOL)close
{
    BOOL result = [_db close];
    _isOpened = NO;
    return result;
}
//- (NSString*)description
//{
//    NSString *string = [NSString stringWithFormat:@"%@",self];
//    return string;
//}
@end
