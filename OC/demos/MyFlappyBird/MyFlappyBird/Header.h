//
//  Header.h
//  MyFlappyBird
//
//  Created by qianfeng on 15-3-9.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define PAGE_NUM 100

#define PIPE_WIDTH 100
#define PIPE_HEIGHT (SCREEN_SIZE.height - 130)

#define PIPE_SPACE 150
#define PIPE_SPEED 6


#define BIRD_WIDTH 40
#define BIRD_UP_SPEED 50
#define BIRD_FRAME CGRectMake(5, 284, BIRD_WIDTH, BIRD_WIDTH-10)