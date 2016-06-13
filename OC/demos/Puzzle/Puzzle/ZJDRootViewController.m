//
//  ZJDRootViewController.m
//  Puzzle
//
//  Created by qianfeng on 15-3-19.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDRootViewController.h"
#import "ZJDMyImageView.h"
#import "ZJDMyLabel.h"

#define AUTO_NUM (arc4random() % 0x100 / (CGFloat)0xFF)
@interface ZJDRootViewController ()

@end

@implementation ZJDRootViewController
{
    NSUInteger steps;
    UILabel * _score;
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
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"bg_night"]];
    [self createOriginPlaces];
    [self createDestPlaces];
    
    [self createOriginalImages];
    [self createScore];
    [self createButtons];
}
- (void)createButtons
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 100, 40)];
    
    [button setTitle:@"重新开始" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor purpleColor]];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    [button addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)createScore
{
    _score = [[UILabel alloc]initWithFrame:CGRectMake(160, 40, 320, 40)];
    _score.text = [NSString stringWithFormat:@"步数: %ld", steps];
    _score.textColor = [UIColor yellowColor];
    _score.font = [UIFont boldSystemFontOfSize:30];
    [self.view addSubview:_score];
}

- (void)createOriginalImages
{
    for (NSUInteger i = 1; i <= 9 ; i++) {
        NSUInteger num = arc4random()%9 + (arc4random()%2+1)*100;
        ZJDMyImageView *view = (id)[self.view viewWithTag:num];
        if (view.isHold) {
            i--;
        }
        else{
            view.isHold = YES;
            ZJDMyLabel *label = [[ZJDMyLabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            label.center = [view center];
            label.text = [NSString stringWithFormat:@"%ld", i];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:1 green:AUTO_NUM blue:AUTO_NUM alpha:1];
            label.font = [UIFont boldSystemFontOfSize:50];
            label.userInteractionEnabled = YES;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 10;
            label.tag = 299 + i;
            label.superTag = num;
            UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            [label addGestureRecognizer:pgr];
            [pgr release];
            [self.view addSubview:label];
            [label release];
        }
        
    }
}


- (void)pan:(UIPanGestureRecognizer *)pgr
{
    static CGPoint originPoint ;
    static ZJDMyLabel *label;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        originPoint = pgr.view.center;
        label = (id)pgr.view;
    }
    if (pgr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pgr translationInView:self.view];
        pgr.view.center = CGPointMake(originPoint.x + translation.x, originPoint.y + translation.y);
        
    }
    if (pgr.state == UIGestureRecognizerStateEnded) {
        BOOL isMatched = NO;
        for (NSUInteger i = 0; i < 9; i++) {
            ZJDMyImageView * destImageView = (id)[self.view viewWithTag:200+i];
            ZJDMyImageView * origImageView = (id)[self.view viewWithTag:100+i];
            CGPoint destPoint = [destImageView center];
            CGPoint origPoint = [origImageView center];
            CGFloat destDistance = sqrt(pow(destPoint.x - label.center.x, 2) + pow(destPoint.y - label.center.y, 2));
            CGFloat origDistance = sqrt(pow(origPoint.x - label.center.x, 2) + pow(origPoint.y - label.center.y, 2));
            ZJDMyImageView *img = (id)[self.view viewWithTag:label.superTag];
            if (destDistance < 30 && destImageView.isHold == NO) {
                label.center = destPoint;
                destImageView.isHold = YES;
                img.isHold = NO;
                label.superTag = destImageView.tag;
                isMatched = YES;
                steps++;
                _score.text = [NSString stringWithFormat:@"步数: %ld", steps];
                break;
            }
            else if (origDistance < 30 && origImageView.isHold == NO)
            {
                label.center = origPoint;
                origImageView.isHold = YES;
                
                img.isHold = NO;
                label.superTag = origImageView.tag;
                isMatched = YES;
                steps++;
                _score.text = [NSString stringWithFormat:@"步数: %ld", steps];
                break;
            }
        }
        if (isMatched == NO) {
            pgr.view.center = originPoint;
        }
        [self isFinished];
    }
    
}

- (void)createOriginPlaces
{
    for (NSUInteger i = 0; i < 3; i++) {
        for (NSUInteger j = 0; j < 3; j++) {
            ZJDMyImageView *imageView = [[ZJDMyImageView alloc]initWithFrame:CGRectMake(55 + j * 75, 90 + i * 75, 60, 60)];
            imageView.isHold = NO;
            imageView.tag = 100 + i*3+j;
            imageView.layer.borderColor = [UIColor cyanColor].CGColor;
            imageView.layer.borderWidth = 3;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 10;
            [self.view addSubview:imageView];
            [imageView release];
        }
    }
}
- (void)createDestPlaces
{
    UIColor *color = [UIColor colorWithRed:0.1 green:AUTO_NUM blue:AUTO_NUM alpha:0.5];
    for (NSUInteger i = 0; i < 3; i++) {
        for (NSUInteger j = 0; j < 3; j++) {
            ZJDMyImageView *imageView = [[ZJDMyImageView alloc]initWithFrame:CGRectMake(55 + j * 75, 340 + i * 75, 60, 60)];
            imageView.isHold = NO;
            imageView.tag = 200 + i*3+j;
            imageView.backgroundColor = color;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 10;
            imageView.layer.borderWidth = 3;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            [self.view addSubview:imageView];
            [imageView release];
        }
    }
}

- (void)isFinished
{
    BOOL isFinished = YES;
    for (NSUInteger i = 0; i < 9; i++) {
        if (!CGRectIntersectsRect([[self.view viewWithTag:200+i]frame], [[self.view viewWithTag:300+i ] frame]) ) {
            isFinished = NO;
        }
    }
    if (isFinished == YES) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜完成" message:[NSString stringWithFormat:@"U R SO CLEVER\n使用步数%ld",steps] delegate:self cancelButtonTitle:@"重新开始" otherButtonTitles: nil];
        [alert show];
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
        [self restart];
    }
}

- (void)restart
{
    UIColor *color = [UIColor colorWithRed:0.1 green:AUTO_NUM blue:AUTO_NUM alpha:0.5];
    for (NSUInteger i = 0; i < 9; i++) {
        ZJDMyLabel *label = (id)[self.view viewWithTag:300+i];
        [label removeFromSuperview];
        ZJDMyImageView *oriImage = (id)[self.view viewWithTag:100+i];
        ZJDMyImageView *desImage = (id)[self.view viewWithTag:200+i];
        oriImage.isHold = NO;
        desImage.isHold = NO;
        desImage.backgroundColor = color;
    }
    steps = 0;
    _score.text = [NSString stringWithFormat:@"步数: %ld", steps];
    [self createOriginalImages];
}
@end
