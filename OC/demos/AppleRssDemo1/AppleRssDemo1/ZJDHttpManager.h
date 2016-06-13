//
//  ZJDHttpManager.h
//  AppleRssDemo1
//
//  Created by qianfeng on 15/3/24.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDHttpManager : NSObject


+(ZJDHttpManager *)sharedManager;


-(void)addTask:(NSString *)url delegate:(id)delegate action:(SEL)action;

-(void)removeTask:(NSString *)url;
-(void)removeAllTask:(id)delegate;
@end
