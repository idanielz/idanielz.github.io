//
//  ZJDRootViewController.m
//  Snake
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDRootViewController.h"
#import "ZJDNode.h"
#import "Header.h"
@interface ZJDRootViewController ()

@end

@implementation ZJDRootViewController
{
    NSMutableArray * _snake;
    NSMutableArray * _nodes;
    NSTimer * _timer;
//    UIView *_background;
    ZJDNode * _head;
    NSUInteger currentNum;
    float t;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _snake = [[NSMutableArray alloc]init];
        _nodes = [[NSMutableArray alloc]init];
        for (NSUInteger i = 0; i < 1000; i++) {
            ZJDNode *node = [[ZJDNode alloc]initWithFrame:CGRectMake(-20, -20, NODE_WIDTH, NODE_WIDTH)];
            [_nodes addObject:node];
            [node release];
        }

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self createBackground];
//    [self createNodes];
    t = 0.3;
    [self createSnake];
    [self randomNewNode];
    //[self addSwipe];
    [self addButtons];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtons
{
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(120, 400, 40, 40)];
    [button1 setTitle:@"上" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(swipeUp) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button1];
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(120, 480, 40, 40)];
    [button2 setTitle:@"下" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(swipeDown) forControlEvents:UIControlEventTouchDown];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [self.view addSubview:button2];
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(80, 440, 40, 40)];
    [button3 addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchDown];
    [button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [button3 setTitle:@"左" forState:UIControlStateNormal];
    [self.view addSubview:button3];
    UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(160, 440, 40, 40)];
    [button4 addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchDown];
    [button4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [button4 setTitle:@"右" forState:UIControlStateNormal];
    button4.titleLabel.text = @"右";
    [self.view addSubview:button4];
    
}
- (void)gameOver
{
    NSLog(@"%f %f", [_snake[0] frame].origin.x, [_snake[0] frame].origin.y);
    if ([_snake[0] frame].origin.x < 0 || [_snake[0] frame].origin.x > 310 || [_snake[0] frame].origin.y < 20 || [_snake[0] frame].origin.y > 560) {
        [_timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over" message:@"撞墙了" delegate:self cancelButtonTitle:@"重来" otherButtonTitles: nil];
        [alert show];
    }
    for (NSUInteger i = 1; i < _snake.count; i++) {
        if ([_snake[0] frame].origin.x == [_snake[i] frame].origin.x && [_snake[0] frame].origin.y == [_snake[i] frame].origin.y) {
            [_timer invalidate];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over" message:@"吃自己了" delegate:self cancelButtonTitle:@"重来" otherButtonTitles: nil];
            [alert show];
        }
    }
}
- (void)addSwipe
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeDown];
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeUp];
}
- (void)swipeLeft
{
    NSLog(@"left");
    if ([_snake[0] dir] == 3 && _snake.count > 1) {
        return;
    }
    [_snake[0] setDir:2];
}

- (void)swipeRight
{
    NSLog(@"right");
    if ([_snake[0] dir] == 2 && _snake.count > 1) {
        return;
    }
    [_snake[0] setDir:3];

}
- (void)swipeUp
{
    NSLog(@"up");
    if ([_snake[0] dir] == 1 && _snake.count > 1) {
        return;
    }
    [_snake[0] setDir:0];

}
- (void)swipeDown
{
    NSLog(@"down");
    if ([_snake[0] dir] == 0 && _snake.count > 1) {
        return;
    }
    [_snake[0] setDir:1];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        for (ZJDNode *node in _snake) {
            [node removeFromSuperview];
        }
        [_snake removeAllObjects];
    }
    [_nodes[currentNum - 1] removeFromSuperview];
    currentNum = 0;
    [self createSnake];
    [self randomNewNode];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

- (void)move
{
    CGPoint headPoint = [_snake[0] frame].origin;
    ZJDNode *tmp = _snake[0];
    switch ([_snake[0] dir]) {
        case 0:
            headPoint.y -= tmp.speed;
            break;
        case 1:
            headPoint.y += tmp.speed;
            break;
        case 2:
            headPoint.x -= tmp.speed;
            break;
        case 3:
            headPoint.x += tmp.speed;
            break;
        default:
            break;
    }
    for (NSUInteger i = _snake.count - 1; i >= 1; i--) {
        [_snake[i] setFrame: [_snake[i - 1] frame]];
    }
    if (headPoint.x == [_nodes[currentNum - 1] frame].origin.x && headPoint.y == [_nodes[currentNum - 1] frame].origin.y) {
        [_snake insertObject:_nodes[currentNum - 1] atIndex:0];
        [_snake[0] setDir: [_snake[1] dir]];
//        for (ZJDNode *node in _snake) {
//            node.speed += 10;
//        }
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:t-=0.01 target:self selector:@selector(move) userInfo:nil repeats:YES];
        [self randomNewNode];
    }
    [_snake[0] setFrame : CGRectMake(headPoint.x, headPoint.y, NODE_WIDTH, NODE_WIDTH) ];
    [self gameOver];
}


- (void)createSnake
{
    NSUInteger x = arc4random()%32 *10;
    NSUInteger y = 20 + arc4random()%55 *10;
    
    ZJDNode *node = [[ZJDNode alloc]initWithFrame: CGRectMake(x, y, NODE_WIDTH, NODE_WIDTH)];
    node.dir = arc4random()%4;
    [self.view addSubview:node];
    [_snake addObject:node];
}

- (void)randomNewNode
{
    NSUInteger x = arc4random()%32 *10;
    NSUInteger y = 20 + arc4random()%55 *10;
    for (ZJDNode *node in _snake) {
        if (node.frame.origin.x == x && node.frame.origin.y == y) {
            [self randomNewNode];
        }
    }
    
    ZJDNode *node = _nodes[currentNum++];
    node.frame = CGRectMake(x, y, NODE_WIDTH, NODE_WIDTH);
    [self.view addSubview:node];
}


@end
