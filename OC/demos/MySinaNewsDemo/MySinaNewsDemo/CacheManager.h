//
//  CacheManager.h
//  MySinaNewsDemo
//
//  Created by qianfeng on 15/3/26.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+(CacheManager *)defaultManager;
-(void)insertData:(NSData *)data withUrl:(NSString *)url;
-(void)deleteDataFromUrl:(NSString *)url;
-(NSData *)getDataFromUrl:(NSString *)url;
@end
