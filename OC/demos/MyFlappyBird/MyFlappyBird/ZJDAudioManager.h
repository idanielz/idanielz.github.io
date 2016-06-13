//
//  ZJDAudioManager.h
//  MyFlappyBird
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface ZJDAudioManager : NSObject

+ (ZJDAudioManager *)defaultManager;
- (void)playFlySound;
- (void)playDeadSound;
- (void)playGetScoreSound;
- (void)playFastFallSound;
@end
