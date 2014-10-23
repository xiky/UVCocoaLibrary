//  Copyright (c) 2014年 XXXX. All rights reserved.
// --------------------------------------------------------------------------------
// UVFMDBDatabase.h
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
@class FMDatabase;
/** FMDB数据库封装 按指定名字打开数据库 数据库存在在Documents目录下
 示例：
     UVFMDatabase *db = [UVFMDatabase instance];
     [db openDataBaseByName:@"db.db"];
    //创建表
     if(![db existsTableByName:@"fav"])
     {
     NSURL *url = [[NSBundle mainBundle] URLForResource:@"install" withExtension:@"sql"];
     [db installTableDataByFile:url charset:NSUTF8StringEncoding];
     }
 */
@interface UVFMDatabase : NSObject
//当前数据名字
@property(nonatomic,strong,readonly) NSString *dbName;
@property(nonatomic,assign,readonly) BOOL isOpened;
//数据库对象
@property(nonatomic,strong) FMDatabase *db;

/** 实例化对象
 
 @return UVFMDBDatabase
 */
+ (UVFMDatabase*)instance;

/* 按数据库名称打开一个数据库连接。如果数据不存在，则会自动创建一个空的数据库，然后再打开
 数据库默认存放在Documents目录下
 
 @param NSString name_ 数据名称 如:db.db
 @return NSError 操作失败返回NSError。如果返回nil表示操作成功
 */
- (NSError*)openDataBaseByName:(NSString*)name_;

/** 关闭数据库
 */
- (BOOL)close;

/** 检测表是否存在
 
 @param NSString name_ 表名称
 @return BOOL 存在返回YES 否则返回NO
 */
- (BOOL)existsTableByName:(NSString*)name_;

/** 从文件中读取sql语句，来对数据库进行初始化操作 如果创建或更新表，插入初始记录等
 一条sql语句必须在一行 并以回车结束 如果一条sql执行产生错误 后面的语句会继续执行
 
 @param NSURL 文件路径
 @param NSStringEccoding 文件编码 如：NSUTF8StringEncoding
 @return NSError 如果文件不存在或者打开失败会返回NSError。其它情况返回nil
 */
- (NSError*)installTableDataByFile:(NSURL*)file_ charset:(NSStringEncoding)encode_;
@end
