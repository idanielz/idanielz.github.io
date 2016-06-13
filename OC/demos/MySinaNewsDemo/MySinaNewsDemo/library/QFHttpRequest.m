//
//  QFHttpRequest.m
//  AppleRssDemo
//
//  Created by leisure on 15/3/24.
//  Copyright (c) 2015年 leisure. All rights reserved.
//

#import "QFHttpRequest.h"
#import "QFHttpManager.h"
#import "NSString+MD5Addition.h"
#import "NSFileManager+PathSize.h"
#import "CacheManager.h"
@interface QFHttpRequest()<NSURLConnectionDataDelegate>
{
    //系统的http协议封装类
    NSURLConnection * _httpConnection;
}
@end

@implementation QFHttpRequest
-(instancetype)init
{
    if (self=[super init]) {
        _downloadData=[[NSMutableData alloc] init];
    }
    return self;
}

+(NSString*)filePath:(NSString *)fileName
{
    NSString * homePath=NSHomeDirectory();
    //设置缓存目录
    homePath=[homePath stringByAppendingPathComponent:@"Library/MyCache"];
    NSFileManager * fm=[NSFileManager defaultManager];
    //如果不存在就创建缓存目录
    if (![fm fileExistsAtPath:homePath]) {
        [fm createDirectoryAtPath:homePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //拼接文件全路径
    if (fileName && [fileName length]!=0) {
        homePath=[homePath stringByAppendingPathComponent:fileName];
    }
    //返回
    return homePath;
    
}

//数据库
-(void)startRequest
{
    //如果开启了缓存功能
    if (self.isCache) {
        CacheManager * manager=[CacheManager defaultManager];
        NSData * data = [manager getDataFromUrl:self.httpUrl];
        //如果数据库中有data
        if (data) {
            [_downloadData setLength:0];
            [_downloadData appendData:data];
            NSLog(@"读取本地缓存数据:%@",self.httpUrl);
            //通知委拖对象请求完成
            [self requestFinished];
            return;
        }
    }
    
    //将请求地址转换成网址类对象
    //如果请求地址中包含中文或其它非法字符，需要对其进行编码
    //self.httpUrl=[self.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:self.httpUrl];
    //转换成请求类对象
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    //一旦创建好新对象，就开始了异步数据请求
    //请求过程和请求结果通过协议方法通知
    _httpConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//文件
//-(void)startRequest
//{
//    //如果开启了缓存功能
//    if (self.isCache) {
//        
//        NSString * filePath=[QFHttpRequest filePath:[self.httpUrl stringFromMD5]];
//        NSFileManager * fm=[NSFileManager defaultManager];
//        //如果对应的缓存文件存在
//        if ([fm fileExistsAtPath:filePath] && ![NSFileManager isTimeout:filePath time:3600]) {
//            //读取缓存文件内容到内存中
//            NSData * data=[NSData dataWithContentsOfFile:filePath];
//            [_downloadData setLength:0];
//            [_downloadData appendData:data];
//            NSLog(@"读取本地缓存数据:%@",self.httpUrl);
//            //通知委拖对象请求完成
//            [self requestFinished];
//            return;
//        }
//        else{
//            
//        }
//        
//    }
//    
//    //将请求地址转换成网址类对象
//    //如果请求地址中包含中文或其它非法字符，需要对其进行编码
//    //self.httpUrl=[self.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL * url=[NSURL URLWithString:self.httpUrl];
//    //转换成请求类对象
//    NSURLRequest * request=[NSURLRequest requestWithURL:url];
//    //一旦创建好新对象，就开始了异步数据请求
//    //请求过程和请求结果通过协议方法通知
//    _httpConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
//}
//当收到服务器回应时调用
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse * httpResponse=(NSHTTPURLResponse*)response;
    NSLog(@"状态码:%ld",httpResponse.statusCode);
    //200 301 404等
    //我们可以根据状态码知道请求状态
    //大多数时候我们不关心，因为只有成功或失败
    
    //收到回应就说明开始一次新的数据接收，清除旧数据
    [_downloadData setLength:0];
}
//当接收到服务器的数据时调用
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //将每一次接收到的数据保存
    [_downloadData appendData:data];
}
//回调
-(void)requestFinished
{
    //检查委拖对象self.delegate是否实现了方法self.action
    if ([self.delegate respondsToSelector:self.action]) {
        //调用委拖对象self.delegate的方法self.action,参数是self
        [self.delegate performSelector:self.action withObject:self];
    }
    
    //移除已完成(或失败)任务
    [[QFHttpManager sharedManager] removeTask:self.httpUrl];
}
//数据请求完成时调用
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //保存新请求的数据到本地缓存文件中, 文件缓存
//    NSString * filePath=[QFHttpRequest filePath:[self.httpUrl stringFromMD5]];
//    [_downloadData writeToFile:filePath atomically:YES];
    //数据库缓存
    [[CacheManager defaultManager] insertData:_downloadData withUrl:self.httpUrl];
    //通知委拖方处理请求结果
    [self requestFinished];
}
//请求失败时调用
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_downloadData setLength:0];
    [self requestFinished];
}
//停止请求
-(void)stopRequest
{
    if (_httpConnection) {
        [_httpConnection cancel];
        _httpConnection=nil;
    }
}

@end










