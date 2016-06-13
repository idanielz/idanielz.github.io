//
//  ZJDRequest.h
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDRequest : NSObject

@property (copy) void (^block)(NSData *);
- (void)requestURL:(NSString *)url;
@end
