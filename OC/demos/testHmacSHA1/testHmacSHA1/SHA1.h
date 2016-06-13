//
//  SHA1.h
//  testHmacSHA1
//
//  Created by 张继东 on 16/4/15.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHA1 : NSObject
+ (NSString *) hmacSha1:(NSString*)key text:(NSString*)text;
@end
