//
//  ZJDHttpRequest.m
//  AppleRssDemo1
//
//  Created by qianfeng on 15/3/24.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDHttpRequest.h"
#import "ZJDHttpManager.h"

@interface ZJDHttpRequest () <NSURLConnectionDataDelegate>
{
    NSURLConnection * _urlConnection;
}
@end
@implementation ZJDHttpRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = [[NSMutableData alloc]init];
    }
    return self;
}


- (void)startRequest
{
    NSURL *requestUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    _urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"状态码: %ld", httpResponse.statusCode);
    _data.length = 0;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self.delegate respondsToSelector:self.action]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.delegate performSelector:self.action withObject:self];
#pragma clang diagnostic pop
    }
    [[ZJDHttpManager sharedManager]removeTask:self.url];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _data.length = 0;
}


-(void)stopRequest
{
    if (_urlConnection) {
        [_urlConnection cancel];
        _urlConnection = nil;
    }
}
@end
