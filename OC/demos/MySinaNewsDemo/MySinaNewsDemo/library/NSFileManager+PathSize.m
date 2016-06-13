//
//  NSFileManager+PathSize.m
//  LimitFree
//
//  Created by DuHaiFeng on 13-12-23.
//  Copyright (c) 2013年 北京千锋互联科技有限公司. All rights reserved.
//

#import "NSFileManager+PathSize.h"

@implementation NSFileManager (PathSize)

//获得指定文件距离上次修改时间是否达到了指定值(秒)timeout
+(BOOL)isTimeout:(NSString *)path time:(NSTimeInterval)timeout
{
    //获得当前时间
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    // 取得了文件上次修改的时间
    NSDate *d = [dict objectForKey:NSFileModificationDate];
    if (now-[d timeIntervalSince1970]>timeout) {
        return YES;
    }
    return NO;
}
//计算文件夹下文件的总大小
+(float)fileSizeForDir:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //记录总值
    unsigned long long totalSize =0;
    //获得指定路径path的所有内容(文件和文件夹)
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        //拼接全路径
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        //如果指定路径存在并且不是文件夹
        //NSLog(@"fullPath:%@",fullPath);
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && !isDir)
        {
            //获得文件属性
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            totalSize+=[[fileAttributeDic objectForKey:NSFileSize] unsignedLongLongValue];
        }
        else
        {
            //如果是文件夹，递归
            totalSize+=[self fileSizeForDir:fullPath];
        }
    }
    return totalSize;
}

@end
