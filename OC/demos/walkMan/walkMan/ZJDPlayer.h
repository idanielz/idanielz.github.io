//
//  ZJDPlayer.h
//  walkMan
//
//  Created by qianfeng on 15-3-11.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJDPlayer : UIImageView

@property BOOL isMoving;

@property NSUInteger direction;  //上0下1左2右3

- (void)moveRight;
- (void)moveLeft;
- (void)moveUp;
- (void)moveDown;
@end
