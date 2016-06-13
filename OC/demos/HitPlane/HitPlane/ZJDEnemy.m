//
//  ZJDEnemy.m
//  HitPlane
//
//  Created by qianfeng on 15-3-8.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDEnemy.h"

@implementation ZJDEnemy

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)enemyMove
{
    if (_isBeaten == YES) {
        [self removeFromSuperview];
        return;
    }
    CGFloat y = self.center.y;
    if (y < 545) {
        y += 10;
       // NSLog(@"%lf", y);
        self.center = CGPointMake(self.center.x, y);
    }
    else
        [self removeFromSuperview];
}
@end
