//
//  QFHttpManager.h
//  AppleRssDemo
//
//  Created by leisure on 15/3/24.
//  Copyright (c) 2015年 leisure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFHttpManager : NSObject

//获得请求管理类的唯一实例
+(QFHttpManager*)sharedManager;

//添加一个新的请求
-(void)addTask:(NSString*)url delegate:(id)delegate action:(SEL)action;
//取消请求
-(void)removeTask:(NSString*)url;
//取消和指定对象相关的所有请求
-(void)removeAllTask:(id)delegate;

@end









