//
//  ZJDDataBaseManager.m
//  数据库访问
//
//  Created by qianfeng on 15-3-4.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDDataBaseManager.h"

#define PERROR(ret,str) if(!ret) perror(str);
@implementation ZJDDataBaseManager
{
    FMDatabase *_database;
    NSLock * _lock;//线程锁, 线程保护, 原子操作
}

-(void)dealloc
{
    [_database release];
    [_lock release];
    [super dealloc];
}

-(id)initWithDataBasePath:(NSString *)path
{
    if (self = [super init]) {
        _database = [[FMDatabase alloc]initWithPath:path];
        _lock = [[NSLock alloc]init];
        BOOL ret = [_database open];
        PERROR(ret,"open");
    }
    return self;
}


- (void)createTable:(NSString *)tableName primaryKey:(NSString *)keyName primaryType:(NSString *)colType otherColumns: (NSDictionary *)columns
{
    [_lock lock]; //加锁
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@ %@ PRIMARY KEY", tableName, keyName, colType];
    for (NSString * key in columns) {
        //key是列名
        [sql appendFormat:@", %@ %@", key, columns[key]];
    }
    
    [sql appendString:@");"];
    //FMDB会自动添加分号
    
    BOOL ret = [_database executeUpdate:sql];
    PERROR(ret, "CREATE TABLE");
    [_lock unlock];//解锁
}

- (void)dropTable: (NSString *)tableName
{
    [_lock lock]; //加锁
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@;", tableName];
    BOOL ret = [_database executeUpdate:sql];
    PERROR(ret, "DROP TABLE");
    [_lock unlock];//解锁
}

- (void)insertRecordIntoTable:(NSString *)tableName WithColumnsAndValues:(NSDictionary *)dict 
{
    [_lock lock]; //加锁
    //拼接value
    NSArray *keyArray = [dict allKeys];
    //拼接列名
    NSString *colStr = [keyArray componentsJoinedByString:@","];
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in keyArray) {
        [xArray addObject: @"?"];
        [valueArray addObject:dict[key]];
    }
    NSString *xStr = [xArray componentsJoinedByString:@","];
    NSMutableString *sql =[NSMutableString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);",tableName, colStr, xStr];
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:valueArray];
    PERROR(ret, "INSERT INTO");
    [_lock unlock];//解锁
}

//拼接筛选的字符串
- (NSString *)whereStringFromWhereDictionary:(NSDictionary *)dict
{
    //拼接删选的字符串
    NSMutableArray * whereArray = [NSMutableArray array];
    for (NSString *key in dict) {
        [whereArray addObject:[NSString stringWithFormat:@"%@=?", key]];
    }
    NSString *whereStr = [whereArray componentsJoinedByString:@" AND "];
    return whereStr;
}

- (void)deleteRecordFromTable:(NSString *)tableName where:(NSDictionary *)whereDict
{
    [_lock lock]; //加锁
    NSString *sql = nil;
    if (whereDict == nil) {
        sql = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        BOOL ret = [_database executeUpdate:sql];
        PERROR(ret,"DELETE whereDict");
        [_lock unlock];//解锁
        return;
    }
    //拼接删选的字符串
    NSString *whereStr = [self whereStringFromWhereDictionary:whereDict];
    //拼接sql
    sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", tableName, whereStr];
    
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:whereDict.allValues];
    PERROR(ret,"DELETE whereDict");
    [_lock unlock];//解锁
}


/**删除记录, 参数是字符串, 允许用户, 自定义删选条件*/
- (void)deleteRecordFromTable:(NSString *)tableName whereString:(NSString *)whereStr
{
    [_lock lock]; //加锁
    NSString *sql = nil;
    if (whereStr == nil) {
        sql = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    }else{
        sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", tableName, whereStr];
    }
    BOOL ret = [_database executeUpdate:sql];
    PERROR(ret,"DELETE whereStr");
    [_lock unlock];//解锁
}

- (FMResultSet *)select:(NSArray *)columnNames fromTable:(NSString *)tableName where :(NSDictionary *)whereDict
{
    [_lock lock];
    //首先是列的字符串
    NSString *colStr = nil;
    if (columnNames == nil) {
        colStr = @"*";
    }
    else
    {
        colStr = [columnNames componentsJoinedByString:@","];
    }
    
    NSString *sql = nil;
    if (whereDict == nil) {
        sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", colStr, tableName];
        FMResultSet *resultSet = [_database executeQuery:sql];
        [_lock unlock];
        return resultSet;

    }
    //拼接删选字符串
    NSString *whereStr = [self whereStringFromWhereDictionary:whereDict];
    //拼接sql
    sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", colStr, tableName, whereStr];
    FMResultSet *resultSet = [_database executeQuery:sql withArgumentsInArray:whereDict.allValues];
    [_lock unlock];
    return resultSet;
    
}

- (FMResultSet *)select:(NSArray *)columnNames fromTable:(NSString *)tableName whereString :(NSString *)whereStr
{
    [_lock lock];
    //首先是列的字符串
    NSString *colStr = nil;
    if (columnNames == nil) {
        colStr = @"*";
    }
    else
    {
        colStr = [columnNames componentsJoinedByString:@","];
    }
    
    NSString *sql = nil;
    if (whereStr == nil) {
        sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", colStr, tableName];
    }
    else{
        //拼接sql
        sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", colStr, tableName, whereStr];
    }
    FMResultSet *resultSet = [_database executeQuery:sql];
    [_lock unlock];
    return resultSet;
}

//拼接筛选的字符串
- (NSString *)updateStringFromupdateDictionary:(NSDictionary *)dict
{
    //拼接删选的字符串
    NSMutableArray * whereArray = [NSMutableArray array];
    for (NSString *key in dict) {
        [whereArray addObject:[NSString stringWithFormat:@"%@=?", key]];
    }
    NSString *whereStr = [whereArray componentsJoinedByString:@","];
    return whereStr;
}

- (void)updateTable:(NSString *)tableName setRecord:(NSDictionary *)updateDict where: (NSDictionary *)whereDict
{
    [_lock lock];
    NSMutableArray *colArray = [NSMutableArray array];
    for (NSString *key in updateDict) {
        NSString *str = [self updateStringFromupdateDictionary:updateDict];
        [colArray addObject:str];
    }
    NSString * colStr = [colArray componentsJoinedByString:@","];
    NSString *sql = nil;
    NSMutableArray * array = [NSMutableArray arrayWithArray: updateDict.allValues];
    
    if (whereDict == nil) {
        sql = [NSString stringWithFormat:@"UPDATE %@ SET %@;", tableName, colStr];
    }
    else
    {
        NSString *whereStr = [self whereStringFromWhereDictionary:whereDict];
        sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@;", tableName, colStr, whereStr];
        [array addObjectsFromArray:whereDict.allValues];
    }
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray: array];
    PERROR(ret, "UPDATE withDict");
    [_lock unlock];
}

- (void)updateTable:(NSString *)tableName setDictionary:(NSDictionary *)dict whereString: (NSString *)whereStr
{
    [_lock lock];
    NSMutableArray *colArray = [NSMutableArray array];
    for (NSString *key in dict) {
        NSString *str = [NSString stringWithFormat:@"%@=?", key];
        [colArray addObject:str];
    }
    NSString * colStr = [colArray componentsJoinedByString:@","];
    NSString *sql = nil;
    if (whereStr == nil) {
        sql = [NSString stringWithFormat:@"UPDATE %@ SET %@", tableName, colStr];
    }
    else
    {
        sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@", tableName, colStr, whereStr];
    }
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:dict.allValues];
    PERROR(ret, "UPDATE withDict");
    [_lock unlock];
}

+ (void)test
{
    ZJDDataBaseManager *dbm = [[ZJDDataBaseManager alloc]initWithDataBasePath:@"/Users/qianfeng/Desktop/DataBase/actor.db"];
    NSDictionary *columns = @{
                              @"姓名":@"varchar(128)",
                              @"国籍":@"varchar(128)"
                              };
    [dbm dropTable:@"男演员"];
    [dbm createTable:@"男演员" primaryKey:@"ID" primaryType:@"INTEGER" otherColumns:columns];
    [dbm deleteRecordFromTable:@"男演员" where: nil];

    [dbm insertRecordIntoTable:@"男演员" WithColumnsAndValues:@{@"姓名":@"刘德华",@"国籍":@"中国"}];
    [dbm insertRecordIntoTable:@"男演员" WithColumnsAndValues:@{@"姓名":@"郭富城",@"国籍":@"中国"}];
    [dbm insertRecordIntoTable:@"男演员" WithColumnsAndValues:@{@"姓名":@"威尔史密斯",@"国籍":@"美国"}];
    [dbm deleteRecordFromTable:@"男演员" where:@{@"姓名":@"郭富城"}];
    [dbm updateTable:@"男演员" setRecord:@{@"姓名":@"黎明"} where:@{@"国籍":@"中国"}];
    FMResultSet *set = [dbm select:nil fromTable:@"男演员" where:@{@"国籍":@"美国"}];
    while ([set next]) {
        int id = [set intForColumn:@"ID"];
        NSString *name = [set stringForColumn:@"姓名"];
        NSString *country = [set stringForColumn: @"国籍"];
        NSLog(@"%d %@ %@", id, name, country);
    }

}
@end
