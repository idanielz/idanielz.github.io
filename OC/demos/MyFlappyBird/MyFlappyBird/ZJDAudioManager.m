//
//  ZJDAudioManager.m
//  MyFlappyBird
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDAudioManager.h"

@implementation ZJDAudioManager
{
    AVAudioPlayer * _player;
}

+ (ZJDAudioManager *)defaultManager
{
    static id manager = nil;
    if (manager == nil) {
        manager = [[ZJDAudioManager alloc]init];
    }
    return manager;
}

- (void)playFlySound
{
    NSArray *xArray = @[@"Sound17"];
    [self playShortSound:xArray];
}

- (void)playDeadSound
{
    NSArray *xArray = @[@"Sound09"];
    [self playShortSound:xArray];
}

- (void)playFastFallSound
{
    NSArray *xArray = @[@"Sound08"];
    [self playShortSound:xArray];
}
- (void)playGetScoreSound
{
    NSArray *xArray = @[@"Sound02"];
    [self playShortSound:xArray];
}
- (void)playShortSound: (NSArray *)xArray
{
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((CFURLRef)[self getURLFromPath:xArray[0] type:@"wav"], &soundID);
    AudioServicesPlayAlertSound(soundID);
}

- (NSURL *)getURLFromPath: (NSString *)string type: (NSString *)type
{
    NSString *path = [[NSBundle mainBundle]pathForResource:string ofType:type];
    return [NSURL fileURLWithPath:path];
}
@end
