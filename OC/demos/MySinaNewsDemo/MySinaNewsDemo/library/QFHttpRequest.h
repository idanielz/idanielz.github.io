//
//  QFHttpRequest.h
//  AppleRssDemo
//
//  Created by leisure on 15/3/24.
//  Copyright (c) 2015年 leisure. All rights reserved.
//

#import <Foundation/Foundation.h>

//http协议数据请求类
@interface QFHttpRequest : NSObject

//委拖对象
@property (nonatomic,assign) id delegate;
//委拖对象的某一个方法
@property (nonatomic,assign) SEL action;
//请求地址
@property (nonatomic,copy) NSString * httpUrl;
//请求结果
@property (nonatomic,readonly) NSMutableData * downloadData;
//是否开启缓存
@property (nonatomic,assign) BOOL isCache;
//根据指定的文件名获得这个文件在当前程指定目录下的全路径
+(NSString*)filePath:(NSString*)fileName;
//开始请求数据
-(void)startRequest;
//停止请求数据
-(void)stopRequest;

@end











