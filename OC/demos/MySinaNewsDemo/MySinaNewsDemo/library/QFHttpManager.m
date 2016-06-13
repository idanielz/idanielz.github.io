//
//  QFHttpManager.m
//  AppleRssDemo
//
//  Created by leisure on 15/3/24.
//  Copyright (c) 2015年 leisure. All rights reserved.
//

#import "QFHttpManager.h"
#import "QFHttpRequest.h"
@interface QFHttpManager()
{
    //用来保存所有请求对象的字典
    //key为请求地址
    //value为请求对象(QFHttpRequest类对象)
    NSMutableDictionary * _taskDict;
}
@end
@implementation QFHttpManager

+(QFHttpManager*)sharedManager
{
    static QFHttpManager * manager;
    if (!manager) {
        manager=[[QFHttpManager alloc] init];
    }
    return manager;
}

-(instancetype)init
{
    if (self=[super init]) {
        _taskDict=[[NSMutableDictionary alloc] init];
    }
    return self;
}
//添加一个新的请求任务
-(void)addTask:(NSString *)url delegate:(id)delegate action:(SEL)action
{
    //根据请求地址查找请求对象
    QFHttpRequest * request=[_taskDict objectForKey:url];
    //如果不存在
    if (!request) {
        //创建新的请求
        request=[[QFHttpRequest alloc] init];
        request.delegate=delegate;
        request.action=action;
        request.httpUrl=url;
        //测试，所有请求开启缓存
        request.isCache=YES;
        //保存新的请求
        [_taskDict setObject:request forKey:url];
        //开始请求数据
        [request startRequest];
    }
    else{
        NSLog(@"请求任务已存在，请稍等，不能重复请求:%@",url);
    }
}
//移除已完成(或提前取消)任务
-(void)removeTask:(NSString *)url
{
    QFHttpRequest * request=[_taskDict objectForKey:url];
    if (request) {
        request.delegate=nil;
        [request stopRequest];
        
        NSLog(@"移除请求完成的任务:%@",request.httpUrl);
        [_taskDict removeObjectForKey:url];
    }
}
-(void)removeAllTask:(id)delegate
{
    NSMutableArray * deleteKeys=[NSMutableArray array];
    
    //获得所有删除任务的key
    for (NSString * key in [_taskDict allKeys]) {
        QFHttpRequest * request=[_taskDict objectForKey:key];
        if (request.delegate==delegate) {
            request.delegate=nil;
            [request stopRequest];
            
            [deleteKeys addObject:key];
        }
    }
    //删除所有相关任务
    [_taskDict removeObjectsForKeys:deleteKeys];
}

@end







