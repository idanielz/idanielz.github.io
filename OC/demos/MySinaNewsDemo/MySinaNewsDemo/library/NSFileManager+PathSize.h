//
//  NSFileManager+PathSize.h
//  LimitFree
//
//  Created by DuHaiFeng on 13-12-23.
//  Copyright (c) 2013年 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (PathSize)

//计算文件夹下文件的总大小
+(float)fileSizeForDir:(NSString*)path;

+(BOOL)isTimeout:(NSString*)path time:(NSTimeInterval)timeout;
@end








