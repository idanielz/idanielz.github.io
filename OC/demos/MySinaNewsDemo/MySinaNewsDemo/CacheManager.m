//
//  CacheManager.m
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/26.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "CacheManager.h"
#import "ZJDDataBaseManager.h"
#define DB_NAME [NSHomeDirectory() stringByAppendingPathComponent:@"Library/MyCache/news.db"]
#define TABLE_NAME @"news"
@implementation CacheManager
{
    ZJDDataBaseManager * _db;
}
+(CacheManager *)defaultManager
{
    static CacheManager * manager = nil;
    if (!manager) {
        manager = [[CacheManager alloc]init];
    }
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTable];
    }
    return self;
}

-(void)createTable
{
    //设置缓存目录
    NSLog(@"%@",DB_NAME);
    _db =  [[ZJDDataBaseManager alloc]initWithDataBasePath:DB_NAME];
    NSDictionary *otherColumns = @{@"data": @"text", @"date":@"datetime"};
    [_db createTable:@"news" primaryKey:@"url" primaryType:@"varchar(256)" otherColumns:otherColumns];
}

-(void)insertData:(NSData *)data withUrl:(NSString *)url
{
    NSLog(@"正在写入数据");
    NSDictionary *dataDict = @{@"url":url, @"data":data, @"date":[NSDate date]};
    [_db insertRecordIntoTable:TABLE_NAME WithColumnsAndValues:dataDict];
}

-(void)deleteDataFromUrl:(NSString *)url
{
    [_db deleteRecordFromTable:TABLE_NAME where:@{@"url":url}];
}

-(NSData *)getDataFromUrl:(NSString *)url
{
    FMResultSet *set = [_db select:@[@"data",@"date"] fromTable:TABLE_NAME where:@{@"url":url}];
    if (set.next == NO) {
        return nil;
    }
    NSDate *date = [set dateForColumn:@"date"];
    NSString *str = [set stringForColumn:@"data"];
    NSLog(@"%@",str);
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    if (-timeInterval > 3600) {
        NSLog(@"超过一小时,重新获取");
        [self deleteDataFromUrl:url];
        return nil;
    }
    NSLog(@"未超过一小时,直接读取");
    NSData *data = [set dataForColumn:@"data"];
    return data;
    
}
@end
