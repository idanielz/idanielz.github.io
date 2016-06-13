//
//  ZJDNode.m
//  Snake
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDNode.h"
#import "Header.h"
@implementation ZJDNode
@synthesize speed;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
        self.speed = NODE_WIDTH;
    }
    return self;
}

@end
