//
//  ZJDRootVViewController.m
//  walkMan
//
//  Created by qianfeng on 15-3-11.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDRootVViewController.h"
#import "ZJDPlayer.h"
#import "ZJDRouter.h"
@interface ZJDRootVViewController ()

@end

@implementation ZJDRootVViewController
{
    ZJDPlayer * _player;
    NSTimer * _timer;
    BOOL _istouched;
    NSMutableArray * _routerArray;
    ZJDRouter * _router;
}

-(void)dealloc
{
    [_player release];
    if (_timer) {
        [_timer invalidate];
    }
    [_routerArray release];
    [_router release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _istouched = NO;
        _routerArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map.png"]];
    _player = [[ZJDPlayer alloc]init];

    [self.view addSubview:_player];
}

- (void)refresh
{
    if (_istouched == NO) {
        return;
    }
    if (_player.isMoving == NO) {
        [_routerArray addObject: _router];
        return;
    }

    [self move];

}

- (void)beginMove
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(changeMovingState)];
    _player.center = [_routerArray[0] point];
    [UIView commitAnimations];
}
-(void)changeMovingState
{
    if (_istouched == NO) {
        return;
    }

    [self restartTimer];
}
- (void)move
{
    static NSUInteger i = 1;
    if (i < _routerArray.count) {

        CGPoint currentPoint = _player.center;
        CGPoint nextPoint = [_routerArray[i] point];
        if (abs(nextPoint.y - currentPoint.y) > abs(nextPoint.x - currentPoint.x)) {
            if (nextPoint.y > currentPoint.y) {
                [_player moveDown];
            }
            else{
                [_player moveUp];
            }
        }
        else{
            if (nextPoint.x > currentPoint.x) {
                [_player moveRight];
            }
            else{
                [_player moveLeft];
            }
        }

            _player.center = [_routerArray[i] point];
            ZJDPlayer * newPlayer = [[ZJDPlayer alloc]init];
            newPlayer.animationImages = _player.animationImages;
            newPlayer.center = _player.center;
            newPlayer.bounds = CGRectMake(0, 0, 20, 20);
            [newPlayer startAnimating];
            [self.view addSubview:newPlayer];
            [newPlayer release];
            i++;
           // [_player stopAnimating];
        
    }
    else
    {
        [self pauseTimer];
        i = 1;
        _player.isMoving = NO;
        _istouched = NO;
    }
}
-(void)pauseTimer
{
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)restartTimer
{
    [_timer setFireDate:[NSDate distantPast]];
//

}

- (void)createTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self.view addSubview:_player];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView: self.view];
    _router = [[ZJDRouter alloc]init];
    _router.point = point;
    [_routerArray removeAllObjects];

    [_routerArray addObject:_router];
    if (_timer) {
        [_timer invalidate];
    }
    [self createTimer];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _istouched = YES;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView: self.view];
    _router = [[ZJDRouter alloc]init];
    _router.point = point;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self pauseTimer];
    if (_istouched == YES) {
        _player.isMoving = YES;

    }
    [self beginMove];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
