//
//  ZJDRequest.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDRequest.h"

@implementation ZJDRequest


- (void)requestURL:(NSString *)url
{
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(requestData:) object:url];
    [thread start];
    [thread release];
}


- (void)requestData:(NSString *)url
{
    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    self.block(data);
}

-(void)dealloc
{
    self.block = nil;
    [super dealloc];
}
@end
