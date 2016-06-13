//
//  ZJDAudioManager.h
//  BeatMoles
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import <Foundation/Foundation.h>

/**为了保证代码模块间的低耦合, 将音频交由该类管理*/
@interface ZJDAudioManager : NSObject


/**单例对象*/
+ (ZJDAudioManager *)defaultManager;
/**播放背景乐*/
- (void)playBackgroundMusic;

/**地鼠的哀嚎*/
- (void)playMoleBark;

- (void)playMoleVoice;
@end
