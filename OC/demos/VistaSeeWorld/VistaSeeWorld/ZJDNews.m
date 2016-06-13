//
//  ZJDNews.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDNews.h"

@implementation ZJDNews



-(void)dealloc
{
    self.author=nil;
    self.desc=nil;
    self.icon=nil;
    self.id=nil;
    self.pub_time=nil;
    self.title=nil;
    [super dealloc];
}
@end
