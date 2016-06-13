//
//  ZJDBird.m
//  MyFlappyBird
//
//  Created by qianfeng on 15-3-9.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDBird.h"
#import "Header.h"
#import "ZJDAudioManager.h"
@implementation ZJDBird

- (id)init
{
    self = [super initWithFrame:BIRD_FRAME];
    if (self) {
        // Initialization code
        //self.image = [UIImage imageNamed:@"flappy_bird.png"];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSUInteger i = 0; i <= 2; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"bird2_%lu.png", i]];
            [array addObject:img];
        }
        self.contentMode = UIViewContentModeScaleToFill;
        self.animationImages = array;
        self.animationDuration = 0.5;
        [self startAnimating];
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 20;
    }
    return self;
}

- (void)flyUp
{
    if (self.frame.origin.y <= 0) {
        _state = 1; //飞天
        return;
    }
    _initSpeed = 0;
    self.transform = CGAffineTransformMakeRotation( -M_PI_4/2);

    CGPoint point = self.center;
    //point.x += 5;
    point.y -= BIRD_UP_SPEED;
    self.center = point;
}

- (void)flyDown
{
    if (self.frame.origin.y >= SCREEN_SIZE.height - BIRD_WIDTH) {
        _state = 2; //遁地
        return;
    }
    _initSpeed++;
    if (_initSpeed == 20) {
        [[ZJDAudioManager defaultManager]playFastFallSound];
    }
    //self.image = [UIImage imageNamed:@"birdDown.png"];
    self.transform = CGAffineTransformRotate(self.transform, M_PI_4/10);//MakeRotation(M_PI_4 * _initSpeed/10);
    CGPoint point = self.center;
    //point.x += 5;
    point.y += _initSpeed;
    self.center = point;
}


- (void)reset
{
    _state = 0;
    _initSpeed = 0;
    self.transform = CGAffineTransformMakeRotation(0);

    self.frame = BIRD_FRAME;
}
@end
