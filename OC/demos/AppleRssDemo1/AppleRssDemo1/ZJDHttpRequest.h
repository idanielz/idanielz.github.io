//
//  ZJDHttpRequest.h
//  AppleRssDemo1
//
//  Created by qianfeng on 15/3/24.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDHttpRequest : NSObject

@property (nonatomic, assign)id delegate;
@property (nonatomic, assign)SEL action;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, strong)NSMutableData *data;


- (void)startRequest;

- (void)stopRequest;
@end
