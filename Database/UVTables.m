//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVTables.m
//
// Project Code: UVCocoaLibrary
// Module Name:
// Date Created: 14-2-25
// Author: chenjiaxin/00891
// Description:
//
// --------------------------------------------------------------------------------
// Modification History
// DATE        NAME             DESCRIPTION
// --------------------------------------------------------------------------------
// 14-2-25  c00891 create
//

#import "UVTables.h"
#import "UVFMDataBase.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation UVTables
{

}

- (id)initWithDatabase:(UVFMDatabase*)db_ table:(NSString*)tableName_ class:(Class)entityClass_;
{
    if(self = [super init])
    {
        _database = db_;
        _tableName = tableName_;
        _entityClass = entityClass_;
    }
    return self;
}
- (void)setDatabase:(UVFMDatabase*)database_
{
    _database = database_;
}
- (void)setTableName:(NSString *)tableName_
{
    _tableName = tableName_;
}
- (void)setTableClass:(Class)entityClass_
{
    _entityClass = entityClass_;
}
/** 获取一串字符串 
 
 @param NSInteger 循环次数 如4
 @param NSString 分隔符 如 @","
 @param NSString 分隔的字符 如 @"?" 
 @return NSString 返回 如 ?,?,?,?
 */
- (NSString*)stringWithCharLen:(NSInteger)len_ sep:(NSString*)separater char:(NSString*)char_
{
    NSMutableString *str;
    NSString *tmp;
    for(NSInteger i=0;i<len_;i++)
    {
        if(str == nil)
        {
            str = [[NSMutableString alloc] init];
            tmp = [NSString stringWithFormat:@"%@",char_];
        }
        else
        {
            tmp = [NSString stringWithFormat:@"%@%@",separater,char_];
        }
        [str appendString:tmp];
        tmp = nil;
    }
    NSString *string = [NSString stringWithString:str];
    str = nil;
    return string;
}
- (BOOL)insert:(NSDictionary*)fields_
{
    NSMutableString *field;
    NSMutableArray *value = [[NSMutableArray alloc] init];
    NSString *tmp;
    NSString *key;
    for(key in fields_)
    {
        if(field == nil)
        {
            field = [[NSMutableString alloc] init];
            tmp = [NSString stringWithFormat:@"[%@]",key];
        }
        else
        {
            tmp = [NSString stringWithFormat:@",[%@]",key];
        }
        [field appendString:tmp];
        [value addObject:fields_[key]];
    }
    NSString *seq = [self stringWithCharLen:fields_.allKeys.count sep:@"," char:@"?"];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@)VALUES(%@)",_tableName,field,seq];
    BOOL result = [self execute:sql param:value];
    value = nil;
    sql = nil;
    key = nil;
    seq = nil;
    return result;
}

-(id)findOne:(NSNumber*)id_
{
    NSString *where = [NSString stringWithFormat:@"id_=%@",id_];
    NSArray *list = [self findAll:nil where:where sort:nil limit:1 offset:0];
    id obj = list.count>0?list.lastObject:nil;
    return obj;
}
-(id)findOneByWhere:(NSString*)where
{
    NSArray *fetchedObjects = [self findAll:nil where:where sort:nil limit:1 offset:0];
    if(nil != fetchedObjects && [fetchedObjects count] >0)
    {
        return [fetchedObjects lastObject];
    }
    else
    {
        return nil;
    }
}
-(NSArray*)findAll:(NSString*) where
{
    return [self findAll:nil where:where sort:nil limit:0 offset:0];
}
-(NSArray*)findAll:(NSString*)fields_ where:(NSString*) where sort:(NSString*) sort_ limit:(NSUInteger)limit_ offset:(NSUInteger)offset_
{
    NSString *field = (fields_==nil)?@"*":fields_;
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT %@ FROM %@",field,_tableName];
    if(where!=nil)
    {
        [sql appendFormat:@" WHERE %@",where];
    }
    if(sort_!=nil)
    {
        [sql appendFormat:@" %@",sort_];
    }
    if(limit_>0)
    {
        [sql appendFormat:@" LIMIT %lu,%ld",(unsigned long)offset_,limit_];
    }
    return [self query:sql param:nil];
}
/** 执行sql语句查询
 
 @param NSString 要执行的sql语句 如 @"SELECT * FROM USERS"
 @return NSArray tableClass指定的对象列表
 */
- (NSArray*)query:(NSString*)sql
{
    return [self query:sql param:nil];
}

/** 执行sql语句查询
 
 @param NSString 要执行的sql语句 如 @"SELECT * FROM USERS WHERE id_=? AND user=?"
 @param NSArray 执行sql语句的参数，必须和sql的?号一一对应 如 @[@(1),@"abc"]
 @return NSArray tableClass指定的对象列表
 */
- (NSArray*)query:(NSString*)sql param:(NSArray*)param
{
    FMResultSet *record;
    
    if(param == nil)
    {
       record = [_database.db executeQuery:sql];
    }
    else
    {
        record = [_database.db executeQuery:sql withArgumentsInArray:param];
    }
    id obj;
    NSMutableArray *list;
    NSInteger columnCount=0;
    NSString *columnName;
    id value;
    NSInteger i;
    while ([record next])
    {
        if(obj == nil)
        {
            obj = [[_entityClass alloc] init];
        }
        if(list == nil)
        {
            list = [[NSMutableArray alloc] init];
        }
        columnCount = [record columnCount];
        for(i=0;i<columnCount;i++)
        {
            columnName = [record columnNameForIndex:(int)i];
            value = [record objectForColumnName:columnName];
            //值不为空，并且实体类成员方法存在
            if(![value isKindOfClass:[NSNull class]])
            {
                [obj setValue:value forKey:columnName];
            }
            
        }
        [list addObject:obj];
        obj = nil;
    }
    [record close];
    return list;
}
-(BOOL)updateById:(NSNumber*)id_ data:(NSDictionary*)data_
{
    NSString *where = [NSString stringWithFormat:@"id_=%@",id_];
    return [self update:where data:data_];
}
-(BOOL)update:(NSString*) where data:(NSDictionary*)data_
{
    NSString *key;
    NSMutableString *field;
    NSMutableArray *value;
    NSString *tmp;
    for(key in data_)
    {
        if(field == nil)
        {
            field = [[NSMutableString alloc] init];
            value = [[NSMutableArray alloc] init];
            tmp = [NSString stringWithFormat:@"[%@]=?",key];
        }
        else
        {
            tmp = [NSString stringWithFormat:@",[%@]=?",key];
        }
        [field appendString:tmp];
        [value addObject:data_[key]];
    }
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",_tableName,field,where];
    BOOL result = [self execute:sql param:value];
    sql = nil;
    field = nil;
    value = nil;
    tmp = nil;
    key = nil;
    return result;
}
-(BOOL)delById:(NSNumber*)id_
{
    NSString *where = [NSString stringWithFormat:@"id_=%@",id_];
    BOOL result =  [self delByWhere:where];
    where = nil;
    return result;
}
- (BOOL)delByWhere:(NSString*)where_
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"DELETE FROM %@",_tableName];
    if(where_)
    {
        [sql appendFormat:@" WHERE %@",where_];
    }
    BOOL result =  [self execute:sql param:nil];
    return result;
}
/* 执行一条sql语句 一般是非SELECT的语句 如果delete insert等
 
 @param NSString 要执行的sql语句 如 delete from users where id_=1
 @return BOOL 操作成功返回YES
 */
- (BOOL)execute:(NSString*)sql
{
    return [self execute:sql param:nil];
}

/* 执行一条sql语句 一般是非SELECT的语句 如果delete insert等
 
 @param NSString 要执行的sql语句 如 delete from users where id_=? AND name=?
 @param NSArray sql语句的参数 ，必须和sql的?号一一对应 如 @[@(1),@"abc"]
 @return BOOL 操作成功返回YES
 */
- (BOOL)execute:(NSString *)sql param:(NSArray*)param_
{
    BOOL result = NO;
    if(param_ == nil)
    {
        result = [_database.db executeUpdate:sql];
    }
    else
    {
        result = [_database.db executeUpdate:sql withArgumentsInArray:param_];
    }
    return result;
}

- (NSInteger)lastIncreaseId
{
    NSString *sql = @"select last_insert_rowid() as id_";
    FMResultSet *record = [_database.db executeQuery:sql];
    NSInteger result = 0;
    if([record next])
    {
        result = [record intForColumn:@"id_"];
    }
    [record close];
    return result;
}
@end
