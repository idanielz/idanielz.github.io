//
//  ZJDMagazine.m
//  VistaSeeWorld
//
//  Created by qianfeng on 15-2-28.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDMagazine.h"

@implementation ZJDMagazine

-(void)dealloc
{
    self.year=nil;
    self.vol_year = nil;
    self.update_time = nil;
    self.desc=nil;
    self.cover=nil;
    self.id=nil;
    self.pub_time=nil;
    self.title=nil;
    [super dealloc];
}
@end
