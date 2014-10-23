//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVTables.h
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

/**
  数据表操作父类
 
 使用前必须设置 tableName,database和entityClass的值
 
 */
@class UVFMDatabase;

@interface UVTables : NSObject
{
 
}
//指定当前操作的表
@property(strong,nonatomic,readonly) NSString *tableName;
//当前操作的数据库
@property(nonatomic,strong,readonly) UVFMDatabase *database;
//表对应的实体类
@property(nonatomic,strong,readonly) Class entityClass;

/** 实例化表对象
 
 @param UVFMDatabase 当前操作的数据库
 @param NSString 当前操作的表名称
 @param Class 数据表的对象类 查询记录时会将结果映射到这个类上 注意：这个对象的属性必须和数据表的字段一一对应
 @return 实例化的表对象
 */
- (id)initWithDatabase:(UVFMDatabase*)db_ table:(NSString*)tableName_ class:(Class)entityClass;

/*设置当前操作的数据库
 
 */
- (void)setDatabase:(UVFMDatabase*)database_;

/*设置当前操作的数据表
 
 */
- (void)setTableName:(NSString *)tableName_;

/*设置当前操作的数据表对象类
 
 */
- (void)setTableClass:(Class)entityClass;


/* 插入一条新记录，如果操作成功返回新的记录 失败返回nil
 
 @param NSDictionary 字符键值 如@{@"name":@"abc",@"age":@(23)}
 @return BOOL 操作成功返回YES 操作失败可以通过 UVFMDatabase 的db.lastErrorMessage来获取错误信息
 */
- (BOOL)insert:(NSDictionary*)fields_;

/* 查询一条对象
 
@param NSNumber 唯一id
@return id tableClass指定的对象
 */
- (id)findOne:(NSNumber*)id_;

/* 根据where条件查询一条对象
 
 @param NSString where条件 如 @"name='abc' AND age=23"
 @return id tableClass指定的对象
 */
-(id)findOneByWhere:(NSString*)where;

/* 根据where条件查询记录
 
 @param NSString where条件 如 @"name='abc' AND age=23"
 @return NSArray tableClass指定的对象列表
 */
- (NSArray*)findAll:(NSString*) where;

/* 查询表记录
 
 @param NSString fields 要查询字段 如 @"name,age,count(*) as a" 为nil时表示*
 @param NSString where条件 如 @"name='abc' AND age=23"
 @param NSString sort 排序 如 @"id_ DESC,name asc"
 @param NSUInteger limit_ 要查询的条数
 @param NSUInteger offset 记录起始位置 注 只有在limit_大于0时才有效
 @return NSArray tableClass指定的对象列表
 */
- (NSArray*)findAll:(NSString*)fields_ where:(NSString*) where sort:(NSString*) sort_ limit:(NSUInteger)limit_ offset:(NSUInteger)offset_;

/** 执行sql语句查询
 
 @param NSString 要执行的sql语句 如 @"SELECT * FROM USERS"
 @return NSArray tableClass指定的对象列表
 */
- (NSArray*)query:(NSString*)sql;

/** 执行sql语句查询
 
 @param NSString 要执行的sql语句 如 @"SELECT * FROM USERS WHERE id_=? AND user=?"
 @param NSArray 执行sql语句的参数，必须和sql的?号一一对应 如 @[@(1),@"abc"]
 @return NSArray tableClass指定的对象列表
 */
- (NSArray*)query:(NSString*)sql param:(NSArray*)param;

/* 根据id更新记录
 
 @param NSNumber 要更新记录的id
 @param NSDictionary 要更新的字段 如 @{"age":23}
 @param BOOL 操作成功返回YES
 */
- (BOOL)updateById:(NSNumber*)id_ data:(NSDictionary*)data_;

/* 根据条件更新记录
 
 @param NSNumber 要更新记录的id
 @param NSDictionary 要更新的字段 如 @{"age":23}
 @param BOOL 操作成功返回YES
 */
- (BOOL)update:(NSString*) where data:(NSDictionary*)data_;

/* 根据ID删除记录
 
 @param NSNumber 要删除记录的ID
 @return BOOL 删除成功返回YES
*/
- (BOOL)delById:(NSNumber*)id_;

/* 根据条件删除记录
 
 @param NSString 删除记录的条件
 @return BOOL 删除成功返回YES
 */
- (BOOL)delByWhere:(NSString*)where_;

/* 执行一条sql语句 一般是非SELECT的语句 如果delete insert等
 
 @param NSString 要执行的sql语句 如 delete from users where id_=1
 @return BOOL 操作成功返回YES
 */
- (BOOL)execute:(NSString*)sql;

/* 执行一条sql语句 一般是非SELECT的语句 如果delete insert等
 
 @param NSString 要执行的sql语句 如 delete from users where id_=? AND name=?
 @param NSArray sql语句的参数 ，必须和sql的?号一一对应 如 @[@(1),@"abc"]
 @return BOOL 操作成功返回YES
 */
- (BOOL)execute:(NSString *)sql param:(NSArray*)param_;

/** 获取最后插入记录的自增ID
 
 @return NSInteger 最后插入记录的自增ID
 */
- (NSInteger)lastIncreaseId;
@end
