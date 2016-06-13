//
//  ZJDPlane.m
//  HitPlane
//
//  Created by qianfeng on 15-3-8.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDPlane.h"

@implementation ZJDPlane

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)moveLeft
{
    CGFloat currntX =  self.center.x;
    if (currntX > 5) {
        currntX -= 5;
        self.center = CGPointMake(currntX, self.center.y);
    }
}

- (void)moveRight
{
    CGFloat currntX =  self.center.x;
    if (currntX < 315) {
        currntX += 5;
        self.center = CGPointMake(currntX, self.center.y);
    }
}

- (void)move :(CGFloat)x
{
    self.center = CGPointMake(x, self.center.y);
}
@end
