//
//  ZJDBird.h
//  MyFlappyBird
//
//  Created by qianfeng on 15-3-9.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJDBird : UIImageView

@property BOOL isUp;
@property NSUInteger state;
@property NSUInteger initSpeed;
- (void)flyUp;
- (void)flyDown;
- (void)reset;
@end
