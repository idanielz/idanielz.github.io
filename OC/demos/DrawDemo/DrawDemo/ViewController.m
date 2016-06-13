//
//  ViewController.m
//  DrawDemo
//
//  Created by 张继东 on 16/3/14.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
{
    CAShapeLayer * shapeLayer;
    UIBezierPath * _path;
    NSTimer * _timer;
    UIView * _ball;
    CMMotionManager * _cmMotionManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _ball = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _ball.center = self.view.center;
    _ball.layer.masksToBounds = YES;
    _ball.layer.cornerRadius = 10;
    _ball.backgroundColor = [UIColor redColor];
    [self.view addSubview: _ball];
    [self initCAShapeLayer];
    [self initCMMotionManager];
    [self addPan];
}

- (void)initCMMotionManager
{
    _cmMotionManager = [[CMMotionManager alloc]init];
//    _cmMotionManager.gyroUpdateInterval = 3;
//    [_cmMotionManager startGyroUpdates];
//    [_cmMotionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
//        NSLog(@"%@", gyroData);
//    }];
    _cmMotionManager.accelerometerUpdateInterval = 3;
    [_cmMotionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        NSLog(@"x:%f\ny:%f\n    z:%f\n", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
    }];
}
- (void)initCAShapeLayer
{
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.view.frame;
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.lineWidth = 5.0f;
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 200)];
//    shapeLayer.path = path.CGPath;
//    shapeLayer.strokeStart = 0.9;
//    shapeLayer.strokeEnd = 1;
    [self.view.layer addSublayer:shapeLayer];
    _path = [UIBezierPath bezierPath];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(animate) userInfo:nil repeats:YES];
}

- (void)animate
{
    static int i = 0;
    static int j = 10;
    //90 100  100 110
    CGFloat one = i % 101 /100.0f;
    CGFloat two = j % 101 /100.0f;
    i += 5;
    j += 5;
    if (i == 100)
    {
        i = 0;
        j = 10;
    }
    shapeLayer.strokeStart = one;// one < two ? one : two;
    shapeLayer.strokeEnd = two;//one > two ? one : two;
    shapeLayer.strokeColor = [UIColor colorWithRed:arc4random() % 255 /255.0f green:arc4random() % 255 /255.0f blue:arc4random() % 255 /255.0f alpha:1].CGColor;
}

- (void)addPan
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)pan:(UIGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        [_path moveToPoint:[pan locationInView:self.view]];
    }
    else if (pan.state == UIGestureRecognizerStateChanged){
        [_path addLineToPoint:[pan locationInView:self.view]];
    }
    shapeLayer.path = _path.CGPath;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
