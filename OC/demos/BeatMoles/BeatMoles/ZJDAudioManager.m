//
//  ZJDAudioManager.m
//  BeatMoles
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDAudioManager.h"
#import <AVFoundation/AVFoundation.h>
@implementation ZJDAudioManager
{
    //播放本地音频的对象
    AVAudioPlayer * _player;
}

-(void)dealloc
{
    [_player release];
    [super dealloc];
}


/**单例对象*/
+ (ZJDAudioManager *)defaultManager
{
    static id manager = nil;
    if (manager == nil) {
        manager = [[ZJDAudioManager alloc]init];
    }
    return manager;
}

/**播放背景乐*/
- (void)playBackgroundMusic
{
    if (_player) {
        [_player stop];
        [_player release];
    }
    //一个play对象, 只能播放一首歌. 如果要切换音频, 需要释放前一个, 再创建一个.
    //获取音频路径
    NSString * path = [[NSBundle mainBundle]pathForResource:@"gophermusic" ofType:@"mp3"];
    //AVAudioPlayer只能播放本地音频, URL是本地URL
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    
    //设置无限播放
    _player.numberOfLoops = -1;
    //准备播放
    [_player prepareToPlay];
    //播放音频
    [_player play];
}

/**地鼠的哀嚎*/
- (void)playMoleBark
{
    NSArray *xArray = @[@"Sound15", @"Sound16", @"Sound05"];
    [self playShortSounds:xArray];
}
/**地鼠嚣张出动*/
- (void)playMoleVoice
{
    NSArray *xArray = @[@"Sound08", @"Sound14", @"Sound18"];
    [self playShortSounds:xArray];
}
/**短音频播放*/
- (void)playShortSounds:(NSArray *)xArray
{
    //声明一个音频的ID
    SystemSoundID soundID;
    //将ID和一个音频文件绑定到一起
    AudioServicesCreateSystemSoundID((CFURLRef)[self getURLWithFileName:xArray[arc4random()%xArray.count] type:@"wav"], &soundID);
    //第一个参数是要把音频URL强转成这个类型CFURLRef
    //通过SoundID将音频托管给系统
    AudioServicesPlayAlertSound(soundID);
}

//通过名字和类型找到包中文件的URL
- (NSURL *)getURLWithFileName: (NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:type];
    return [NSURL fileURLWithPath:path];
}
@end
