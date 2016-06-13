//
//  ZJDMainViewController.m
//  MyFlappyBird
//
//  Created by qianfeng on 15-3-9.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDMainViewController.h"
#import "Header.h"
#import "ZJDBird.h"
#import "ZJDAudioManager.h"
@interface ZJDMainViewController ()

@end

@implementation ZJDMainViewController
{
    NSMutableArray * _pipeUpArray;
    NSMutableArray * _pipeDownArray;
    NSMutableArray * _scoreArray;
    NSUInteger _score;
    ZJDBird * _bird;
    NSTimer * _timer;
}
-(void)dealloc
{
    [_pipeDownArray release];
    [_pipeUpArray release];
    if (_timer) {
        [_timer invalidate];
    }
    [_bird release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _pipeUpArray = [[NSMutableArray alloc]init];
        _pipeDownArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self createBackground];
//    self.view.frame = CGRectMake(0, 20, 320, 548);
    _highestScore = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScore"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    [self initPipes];
    [self randomPipes];
    [self createPipes];
    [self createBird];
    [self createScore];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScore
{
    _scoreArray = [[NSMutableArray alloc]init];
    for (NSUInteger i = 48; i <= 57; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"font_0%lu.png", i]];
        [_scoreArray addObject:img];
    }
    for (NSUInteger i = 0; i <3; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame: CGRectMake(125 + 25*i, 25, 20, 30)];
        imgView.tag = 31 + i;
        imgView.image = _scoreArray[0];
        [self.view addSubview:imgView];
    }
}

- (void)resetScore
{
    for (NSUInteger i = 0; i < 3; i++) {
        UIImageView *imgView = (UIImageView *)[self.view viewWithTag:31+i];
        imgView.image = _scoreArray[0];
    }
}

- (void)initPipes
{

    for (NSUInteger i = 0; i < PAGE_NUM; i++) {
        UIImageView *pipeUp = [[UIImageView alloc]initWithFrame:CGRectMake(-320, 0, PIPE_WIDTH, PIPE_HEIGHT)];
        pipeUp.image = [UIImage imageNamed:@"pipedown1.png"];
        pipeUp.contentMode = UIViewContentModeRedraw;
        UIImageView *pipeDown = [[UIImageView alloc]initWithFrame:CGRectMake(-320, 0, PIPE_WIDTH, PIPE_HEIGHT)];
        pipeDown.image = [UIImage imageNamed:@"pipeup1.png"];
        pipeDown.contentMode = UIViewContentModeRedraw;
        pipeUp.layer.masksToBounds = YES;
        pipeUp.layer.cornerRadius = 5;
        pipeDown.layer.masksToBounds = YES;
        pipeDown.layer.cornerRadius = 5;
        [_pipeUpArray addObject:pipeUp];
        [_pipeDownArray addObject:pipeDown];
        [self.view addSubview: pipeUp];
        [self.view addSubview: pipeDown];
        [pipeUp release];
        [pipeDown release];
        
    }
}

- (void)randomPipes
{
    for (NSUInteger i = 0; i < PAGE_NUM; i++) {
        CGRect upRect = [_pipeUpArray[i] frame];
        CGRect downRect = [_pipeDownArray[i] frame];
        NSUInteger p = arc4random()%10 + 1;
        CGFloat up = 0;
        CGFloat down = 0;
        if (p >= 1 && p <= 9) {
            up = PIPE_HEIGHT * p /10;
            down = PIPE_HEIGHT * (10 - p) /10;
        }
        else
        {
            down = up = PIPE_HEIGHT/2;
        }
        upRect.origin.y = up - PIPE_HEIGHT;
        downRect.origin.y = SCREEN_SIZE.height - down;
        [_pipeUpArray[i] setFrame:  upRect];
        [_pipeDownArray[i] setFrame:  downRect];
    }
}

- (void)createPipes
{
    for (NSUInteger i = 0; i < PAGE_NUM; i++) {
        CGRect upRect = [_pipeUpArray[i] frame];
        CGRect downRect = [_pipeDownArray[i] frame];
        upRect.origin.x = downRect.origin.x = (PIPE_WIDTH + PIPE_SPACE) * i + 240;
        [_pipeUpArray[i] setFrame:  upRect];
        [_pipeDownArray[i] setFrame:  downRect];
    }
}

- (void)createBird
{
     _bird = [[ZJDBird alloc]init];
    [self.view addSubview:_bird];
}

- (void)refresh
{
    if (_bird.state != 0) {
        _bird.transform = CGAffineTransformRotate(_bird.transform, M_PI_4);
        return;
    }
    for (UIImageView *pipeUp in _pipeUpArray) {
        CGPoint point = pipeUp.center;
        point.x -= PIPE_SPEED;
        pipeUp.center = point;
    }
    for (UIImageView *pipeDown in _pipeDownArray) {
        CGPoint point = pipeDown.center;
        point.x -= PIPE_SPEED;
        pipeDown.center = point;
    }
    [self down];
    [self isCrash];
}

- (void)down
{
    static NSUInteger i = 0;
    if (i % 20 == 0) {
        [_bird flyDown];
    }
}

- (void)isCrash
{
    if (_bird.state == 1) {
        [[ZJDAudioManager defaultManager]playDeadSound];
        //[_timer setFireDate:[NSDate distantFuture]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GAME OVER" message:[NSString stringWithFormat: @"你是要飞啊!\n得分: %ld 最高分: %ld",_score, _highestScore] delegate:self cancelButtonTitle:@"重玩" otherButtonTitles: @"换一关",nil];
        [alert show];
        return;
    }
    if (_bird.state == 2)
    {
        [[ZJDAudioManager defaultManager]playDeadSound];
        //[_timer setFireDate:[NSDate distantFuture]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GAME OVER" message:[NSString stringWithFormat: @"我靠 掉屎坑了! \n得分: %ld 最高分: %ld",_score, _highestScore] delegate:self cancelButtonTitle:@"重玩" otherButtonTitles: @"换一关",nil];
        [alert show];
        return;
    }
    for (NSUInteger i = 0; i < _pipeUpArray.count; i++) {
        if ( CGRectIntersectsRect([_pipeUpArray[i] frame],_bird.frame)||CGRectIntersectsRect([_pipeDownArray[i] frame],_bird.frame)) {
            _bird.state = 3;
            //[_timer setFireDate:[NSDate distantFuture]];
            [[ZJDAudioManager defaultManager]playDeadSound];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GAME OVER" message:[NSString stringWithFormat: @"脑子撞秀逗了!\n得分: %ld 最高分: %ld",_score, _highestScore] delegate:self cancelButtonTitle:@"重玩" otherButtonTitles: @"换一关",nil];
            [alert show];
            return;
        }
        if (_bird.frame.origin.x > [_pipeUpArray[i] frame].origin.x+PIPE_WIDTH && _bird.frame.origin.x < [_pipeUpArray[i+1] frame].origin.x)
        {
            if (_score > i) {
                return;
            }
            _score = i+1;
            _highestScore = _highestScore > _score ? _highestScore : _score;
            [[NSUserDefaults standardUserDefaults] setInteger:_highestScore forKey:@"highScore"];
            if (_score < 10) {
                UIImageView *imgView = (UIImageView *)[self.view viewWithTag:33];
                imgView.image = _scoreArray[_score];
            }
            else if (_score < 100)
            {
                UIImageView *imgView = (UIImageView *)[self.view viewWithTag:32];
                imgView.image = _scoreArray[_score/10];
                imgView = (UIImageView *)[self.view viewWithTag:33];
                imgView.image = _scoreArray[_score%10];
            }
            else if (_score < 1000)
            {
                UIImageView *imgView = (UIImageView *)[self.view viewWithTag:32];
                imgView.image = _scoreArray[_score%100/10];
                imgView = (UIImageView *)[self.view viewWithTag:33];
                imgView.image = _scoreArray[_score%100%10];
                imgView = (UIImageView *)[self.view viewWithTag:31];
                imgView.image = _scoreArray[_score/100];
            }
            [[ZJDAudioManager defaultManager]playGetScoreSound];
            return;
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_bird flyUp];
    [[ZJDAudioManager defaultManager]playFlySound];
    [self isCrash];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"重玩");
    }
    else if (buttonIndex == 1) {
        NSLog(@"创建新一关");
        [self randomPipes];
    }
    [self createPipes];
    [_timer setFireDate:[NSDate distantPast]];
    [_bird reset];
    [self resetScore];
    _score = 0;
}
@end

