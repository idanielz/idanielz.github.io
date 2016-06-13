//
//  ZJDRootViewController.m
//  BeatMoles
//
//  Created by qianfeng on 15-3-10.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDRootViewController.h"
#import "Header.h"
#import "ZJDAudioManager.h"

#define DOCUMENT_PATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
@interface ZJDRootViewController ()

@end

@implementation ZJDRootViewController
{
    NSTimer * _timer;
    UILabel * _scoreLabel;
    NSUInteger _score;
    UILabel * _progressLabel;
    NSMutableArray * _scoreArray;
}

-(void)dealloc
{
    if (_timer) {
        [_timer invalidate];
    }
    [_scoreLabel release];
    [_progressLabel release];
    [_scoreArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[DOCUMENT_PATH stringByAppendingPathComponent:@"score.plist"]];
    _highestScore = [dic[@"score"] integerValue];
    NSLog(@"最高分%lu %@",_highestScore,DOCUMENT_PATH);
    [self createBackground];
    [self createScore];

    [self createMoles];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(gameStart) userInfo:nil repeats:YES];
    
    //播放背景乐
    [[ZJDAudioManager defaultManager]playBackgroundMusic];
}
#pragma mark - 关于分数
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
    for (NSUInteger i = 0; i <3; i++) {
        UIImageView *imgView = (UIImageView *)[self.view viewWithTag:31+i];
        imgView.image = _scoreArray[0];
    }
}

-(void)scoreChangeByBetean:(NSUInteger)score
{
    _score+=score;
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
    CGPoint point = _progressLabel.center;
    point.x += 6 + score;
    _progressLabel.center = point;
}

#pragma mark - 背景图
//创建背景图
- (void)createBackground
{
    for (NSUInteger i = 1; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"GameBG0%ld.png", i]]];
        imageView.tag = 10 + i;
        //imageView.alpha = 0.5;
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        [imageView release];
    }
    UIView *imageView = [self.view viewWithTag:11];
    imageView.frame =CGRectMake(0, 0, 320, 267);
    imageView = [self.view viewWithTag:12];
    imageView.frame =CGRectMake(0, 227, 320, 134);
    imageView = [self.view viewWithTag:13];
    imageView.frame =CGRectMake(0, 321, 320, 123);
    imageView = [self.view viewWithTag:14];
    imageView.frame =CGRectMake(0, 409, 320, 160);
    
    [self resetScore];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 30, 95, 30)];
    [leftButton setTitle: @"SLOWDOWN" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:20]];
    [leftButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [leftButton setShowsTouchWhenHighlighted:YES];
    [leftButton addTarget:self action:@selector(slowDown) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundColor:[UIColor yellowColor]];
    leftButton.layer.masksToBounds = YES;
    leftButton.layer.cornerRadius = 5;
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(220, 30, 95, 30)];
    [rightButton setTitle: @"SPEEDUP" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:20]];
    [rightButton setShowsTouchWhenHighlighted:YES];
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [rightButton addTarget:self action:@selector(fast) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundColor:[UIColor greenColor]];
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.cornerRadius = 5;
    [self.view addSubview:leftButton];
    [self.view addSubview:rightButton];
    [leftButton release];
    [rightButton release];
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(-25, 486, 320, 30)];
    _progressLabel.backgroundColor = [UIColor redColor];
    _progressLabel.layer.masksToBounds = YES;
    _progressLabel.layer.cornerRadius = 15;
    [self.view insertSubview:_progressLabel belowSubview:imageView];

}
#pragma mark - 关于地鼠
- (void)createMoles
{
    for (NSUInteger i = 0; i < 9; i++) {
        ZJDMole *mole = [[ZJDMole alloc]initWithImage:[UIImage imageNamed:@"Mole04.png"]];
        mole.frame = CGRectMake(32+(45+56)*(i%3), 223+(12+80)*(i/3), 56, 80);
        mole.tag = 21 + i;
        mole.moveSpeed = 3;
        mole.delegate = self;
        [self.view insertSubview:mole aboveSubview:[self.view viewWithTag:11+i/3]];
        [mole release];
    }
}

- (void)gameStart
{
    CGPoint point = _progressLabel.center;
    if (point.x == -65) {
        [_timer setFireDate:[NSDate distantFuture]];
        _highestScore = _highestScore>_score ? _highestScore : _score;
        NSDictionary *dic = @{@"score":[NSString stringWithFormat:@"%lu", _highestScore]};
        [dic writeToFile:[DOCUMENT_PATH stringByAppendingPathComponent:@"score.plist"] atomically:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"时间到!" message:[NSString stringWithFormat:@"得分: %lu", _score]  delegate:self cancelButtonTitle:@"重新开始" otherButtonTitles: nil];
        [alert show];
    }
    point.x -= 0.5;
    _progressLabel.center = point;
    for (NSUInteger i = 21; i <=29; i++) {
        ZJDMole *mole = (ZJDMole *)[self.view viewWithTag:i];
        if (mole.isOut == NO) {
            NSUInteger num = arc4random()%100;
            if (num == 10) {
                if (mole.isOut == NO) {
                    //播放出洞音效
                    if (arc4random()%5 == 0) {
                        [[ZJDAudioManager defaultManager]playMoleVoice];
                    }
                    
                    mole.userInteractionEnabled = YES;

                    mole.isOut = YES;
                    mole.isBeaten = NO;
                    mole.isTop = NO;
                }
            }
        }
        [mole move];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _progressLabel.frame = CGRectMake(-25, 486, 320, 30);
        _score = 0;
        for (NSUInteger i = 0; i < 9; i++) {
            ZJDMole *mole = (ZJDMole *)[self.view viewWithTag:i+21];
            mole.frame = CGRectMake(32+(45+56)*(i%3), 223+(12+80)*(i/3), 56, 80);
            mole.score = 1;
            mole.moveSpeed = 3;
            [mole setLevel];
            [mole resetMole];
        }
        NSLog(@"最高分%lu %@",_highestScore,DOCUMENT_PATH);
        [self resetScore];
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)slowDown
{
    NSLog(@"减速");
    for (NSUInteger i = 21; i <= 29; i++) {
        ZJDMole *mole = (ZJDMole *)[self.view viewWithTag:i];
        if (mole.moveSpeed > 1) {
            mole.moveSpeed -= 0.5;
        }
    }
}
- (void)fast
{
    NSLog(@"加速");
    for (NSUInteger i = 21; i <= 29; i++) {
        ZJDMole *mole = (ZJDMole *)[self.view viewWithTag:i];
        //if (mole.moveSpeed >= 1) {
            mole.moveSpeed += 0.5;
        //}
    }
}
@end
