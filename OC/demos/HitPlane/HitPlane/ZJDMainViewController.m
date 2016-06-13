//
//  ZJDMainViewController.m
//  HitPlane
//
//  Created by qianfeng on 15-3-8.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDMainViewController.h"
#import "ZJDPlane.h"
#import "ZJDBullet.h"
#import "ZJDEnemy.h"
@interface ZJDMainViewController ()

@end

@implementation ZJDMainViewController
{
    ZJDPlane *_plane;
//    UIButton * _leftButton;
//    UIButton * _rightButton;
    UILabel * _scoreLabel;
//    UISlider * _slider;
    NSTimer *_timer;
    NSTimer *bTimer;
    NSUInteger t;
    NSUInteger score;
    NSMutableArray * _bulletArray;
    NSMutableArray * _enemyArray;
}

-(void)dealloc
{
    [_plane release];
//    [_leftButton release];
//    [_rightButton release];
    [_timer release];
//    [_slider release];
    [_bulletArray release];
    [_enemyArray release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _bulletArray = [[NSMutableArray alloc]init];
        _enemyArray = [[NSMutableArray alloc]init];
        t = 0;
        score = 0;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    _plane = [[ZJDPlane alloc] initWithImage:[UIImage imageNamed:@"plane.png"]];
    _plane.frame = CGRectMake(160, 450, 40, 40);

    //_plane.font = [UIFont boldSystemFontOfSize:30];
    //[_plane setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_plane];
    
    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 520, 80, 20)];
    _scoreLabel.text = [NSString stringWithFormat:@"得分:%lu", score];
    _scoreLabel.adjustsFontSizeToFitWidth = YES;
    [_scoreLabel setTextColor:[UIColor redColor]];
    _scoreLabel.font = [UIFont boldSystemFontOfSize:20];
    [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_scoreLabel];
////    [self createLeftButton];
////    [self createRightButton];
//    
//    _slider =[[UISlider alloc]initWithFrame:CGRectMake(5, 540, 310, 20)];
//    [_slider setMinimumValue:0];
//    [_slider setMaximumValue:320];
//    [_slider addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:_slider];
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(createBullet) object:nil];
//    [thread start];
//    [thread release];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(create) userInfo:nil repeats:YES];
    bTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(createBullet) userInfo:nil repeats:YES];
}
//
//- (void)changeValue
//{
//    [_plane move:_slider.value];
//}
//- (void)createLeftButton
//{
//    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 80, 60)];
//    [_leftButton setTitle:@"<<<<<<" forState:UIControlStateNormal];
//    _leftButton.titleLabel.textColor = [UIColor redColor];
//    [_leftButton setShowsTouchWhenHighlighted:YES];
//
//    [_leftButton.titleLabel setFont : [UIFont boldSystemFontOfSize:30]];
//    [_leftButton addTarget:self action:@selector(leftOnclick) forControlEvents:UIControlEventTouchDragInside];
//    
//    [self.view addSubview:_leftButton];
//}
//
//- (void)createRightButton
//{
//    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(230, 500, 80, 60)];
//    [_rightButton setTitle:@">>>>>>" forState:UIControlStateNormal];
//    _rightButton.titleLabel.textColor = [UIColor redColor];
//    [_rightButton.titleLabel setFont : [UIFont boldSystemFontOfSize:30]];
//    [_rightButton setShowsTouchWhenHighlighted:YES];
//
//    [_rightButton addTarget:self action:@selector(rightOnclick) forControlEvents:UIControlEventTouchDragInside];
//    
//    [self.view addSubview:_rightButton];
//    
////    [self createBullet];
//}

//- (void)leftOnclick
//{
//    [_plane moveLeft];
//}
//
//- (void)rightOnclick
//{
//    [_plane moveRight];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)create
{
    
    for (ZJDBullet * b in _bulletArray) {
        [b bulletMove];
    }
    //[bullet bulletMove];
    NSUInteger getEnemy = arc4random()%3;
    if (getEnemy == 0 ) {
        NSUInteger enemyX = arc4random()%260 + 20;
        ZJDEnemy * enemy = [[ZJDEnemy alloc]initWithImage:[UIImage imageNamed:@"ghost.png"]];
        enemy.frame = CGRectMake(enemyX, 30, 40, 40);
//        enemy.text = @"👻";
//        enemy.font = [UIFont systemFontOfSize:40];
        [self.view addSubview:enemy];
        [_enemyArray addObject:enemy];
    }
    
    for (ZJDEnemy * e in _enemyArray) {
        [e enemyMove];
    }
    
    
    [self testHited];
    [self isCrashed];

}

- (void)createBullet
{
    //while (1) {
        //NSLog(@"%ld", t);
        //if (t > 5) {
          //  t = 0;
            ZJDBullet *bullet = [[ZJDBullet alloc] initWithImage:[UIImage imageNamed:@"bullet.png"]];
            bullet.frame = CGRectMake(_plane.center.x-10, _plane.center.y-30, 20, 20);
            //        bullet.text = @"👿";
            //        bullet.font = [UIFont systemFontOfSize:40];
            [self.view addSubview: bullet];
            [_bulletArray addObject:bullet];
      //  }
       // usleep(1000);
     //   t++;
    //}
        [self testHited];
    //[self isCrashed];
}

- (void)testHited
{
    for (NSUInteger i = 0; i < _bulletArray.count; i++) {
        for (NSUInteger j = 0 ; j < _enemyArray.count; j++) {
            ZJDBullet *b = _bulletArray[i];
            ZJDEnemy *e = _enemyArray[j];
            if (b.center.y - e.center.y < 30 && abs(b.center.x - e.center.x) < 30 ) {
                //b.isHitPlane = YES;
                //e.isBeaten = YES;
                [b removeFromSuperview];
                [e removeFromSuperview];
                [_enemyArray removeObject:e];
                [_bulletArray removeObject:b];
                score++;
                NSLog(@"得分: %lu", score);
                _scoreLabel.text = [NSString stringWithFormat:@"得分: %lu", score];
                break;
            }
        }
    }

}

- (void)isCrashed
{
    for (NSUInteger i = 0 ; i < _enemyArray.count; i++) {
        ZJDEnemy *e = _enemyArray[i];
        if ((_plane.center.y - e.center.y < 40 && abs(e.center.x - _plane.center.x) < 40)||e.center.y > 520) {
            [_timer setFireDate:[NSDate distantFuture]];
            [bTimer setFireDate:[NSDate distantFuture]];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over" message:[NSString stringWithFormat:@"玩儿蛋!\n得分:%ld",score] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _scoreLabel.text = 0;
        score = 0;
        for (ZJDEnemy * ee in _enemyArray) {
            [ee removeFromSuperview];
        }
        for (ZJDBullet * bb in _bulletArray) {
            [bb removeFromSuperview];
        }
        [_bulletArray removeAllObjects];
        [_enemyArray removeAllObjects];
        _plane.frame = CGRectMake(160, 450, 40, 40);

        [_timer setFireDate:[NSDate distantPast]];
        [bTimer setFireDate:[NSDate distantPast]];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    _plane.center = point;
}
@end
