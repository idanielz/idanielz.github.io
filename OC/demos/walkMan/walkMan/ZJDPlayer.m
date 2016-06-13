//
//  ZJDPlayer.m
//  walkMan
//
//  Created by qianfeng on 15-3-11.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDPlayer.h"
#import "Header.h"
@implementation ZJDPlayer
{
    NSMutableArray *upArray;
    NSMutableArray *downArray;
    NSMutableArray *leftArray;
    NSMutableArray *rightArray;
}
- (id)init
{
    self = [super initWithFrame:PLAYER_FRAME];
    if (self) {
        // Initialization code
        self.isMoving = NO;
        self.image = [UIImage imageNamed:@"player_down_1.png"];
        upArray = [[NSMutableArray alloc]init];
        downArray = [[NSMutableArray alloc]init];
        leftArray = [[NSMutableArray alloc]init];
        rightArray = [[NSMutableArray alloc]init];
        for (NSUInteger i = 1; i <= 3; i++) {
            [upArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"player_up_%lu.png", i]]];
            [downArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"player_down_%lu.png", i]]];
            [leftArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"player_left_%lu.png", i]]];
            [rightArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"player_right_%lu.png", i]]];
        }
//        self.animationImages = rightArray;
        [self setAnimationDuration:0.2];
//
//        [self startAnimating];

    }
    return self;
}

- (void)moveRight
{
    if (_direction != 3) {
        self.image = [UIImage imageNamed:@"player_right_1.png"];
        self.animationImages = rightArray;
        [self startAnimating];
        _direction = 3;
    }
    
}

- (void)moveLeft
{
    if (_direction != 2) {
        self.image = [UIImage imageNamed:@"player_left_1.png"];
        self.animationImages = leftArray;
        [self startAnimating];
        _direction = 2;
    }
}
- (void)moveUp
{
    if (_direction != 0) {
        self.image = [UIImage imageNamed:@"player_up_1.png"];
        self.animationImages = upArray;
        [self startAnimating];
        _direction = 0;
    }
    
}
- (void)moveDown
{
    if (_direction != 1) {
        self.image = [UIImage imageNamed:@"player_down_1.png"];
        self.animationImages = downArray;
        [self startAnimating];
        _direction = 1;
    }
}
@end
