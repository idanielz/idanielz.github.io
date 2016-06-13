//
//  ZJDHttpManager.m
//  AppleRssDemo1
//
//  Created by qianfeng on 15/3/24.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDHttpManager.h"
#import "ZJDHttpRequest.h"
@implementation ZJDHttpManager
{
    NSMutableDictionary * _requestDict;
}

+(ZJDHttpManager *)sharedManager
{
    static ZJDHttpManager * manager;
    if (!manager) {
        manager = [[ZJDHttpManager alloc]init];
    }
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)addTask:(NSString *)url delegate:(id)delegate action:(SEL)action
{
    ZJDHttpRequest *request = [[ZJDHttpRequest alloc]init];
    request.url = url;
    request.delegate = delegate;
    request.action = action;
    [_requestDict setObject:request forKey:url];
    [request startRequest];
}
-(void)removeTask:(NSString *)url
{
    ZJDHttpRequest *request = [_requestDict objectForKey:url];
    if (request) {
        request.delegate = nil;
        [request stopRequest];
        [_requestDict removeObjectForKey:url];
    }
}
-(void)removeAllTask:(id)delegate
{
    for (NSString *key in _requestDict.allKeys) {
        ZJDHttpRequest *request = [_requestDict objectForKey:key];
        if (request.delegate == delegate) {
            request.delegate = nil;
            [request stopRequest];
            [_requestDict removeObjectForKey:key];
        }
    }
}
@end
