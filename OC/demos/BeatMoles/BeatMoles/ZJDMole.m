//
//  ZJDMole.m
//  BeatMoles
//
//  Created by qianfeng on 15-3-10.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ZJDMole.h"
#import "ZJDAudioManager.h"
@implementation ZJDMole
{
    CGFloat currentHeight;
    UILabel * _levelLabel;
}
-(void)dealloc
{
    [_levelLabel release];
    [super dealloc];
}

- (id)initWithImage: (UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        // Initialization code
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSUInteger i = 1; i <= 3; i++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Mole0%ld.png", i]]];
        }
        self.score = 1;
        self.animationImages = array;
        [array release];
        self.animationDuration = 0.5;
        self.userInteractionEnabled = YES;
        [self startAnimating];
        _levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -20, 30, 30)];
        _levelLabel.layer.masksToBounds = YES;
        _levelLabel.layer.cornerRadius = 10;
        _levelLabel.font = [UIFont boldSystemFontOfSize:15];
        _levelLabel.textColor = [UIColor greenColor];
        [self setLevel];
        [self addSubview:_levelLabel];
        [self createButton];
    }
    return self;
}

- (void)setLevel
{
    _levelLabel.backgroundColor = [UIColor colorWithRed: 1-(CGFloat)_score/10 green:0 blue:0.1 alpha:1];
    _levelLabel.text = [NSString stringWithFormat:@"Lv.%ld", _score];
}
- (void)createButton
{
    UIButton *button = [[UIButton alloc]initWithFrame:self.bounds];
    [button addTarget:self action:@selector(beBeaten) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button release];
}

- (void)beBeaten
{
    if (_isBeaten == NO) {
        [self.delegate scoreChangeByBetean: _score];
    }
    NSLog(@"be");
    [self stopAnimating];
    //self.image = [UIImage imageNamed:@"Mole04.png"];
    [[ZJDAudioManager defaultManager]playMoleBark];
    self.userInteractionEnabled = NO;
    _isBeaten = YES;
    if (_isTop == YES) {
        currentHeight = 80 - currentHeight;
    }
    
}

- (void)move
{
    CGRect frame = self.frame;
    if (_isBeaten == NO ) {
        if (_isOut == YES) {
            if (_isTop == NO ) {
                frame.origin.y -= _moveSpeed;
                currentHeight += _moveSpeed;
                if (currentHeight >= 80) {
                    _isTop = YES;
                    currentHeight = 0;
                }
            }
            else
            {
                frame.origin.y += _moveSpeed;
                currentHeight += _moveSpeed;
                if (currentHeight >= 80) {
                    [self resetMole];
                    [self levelUp];
                }
            }
        }
    }
    else
    {
        frame.origin.y += _moveSpeed;
        currentHeight -= _moveSpeed;
        if (currentHeight <= 0) {
            [self resetMole];
            _score = 1;
            _moveSpeed = 3;
            [self setLevel];
        }
    }
    self.frame = frame;
    
}

- (void)resetMole
{
    _isOut = NO;
    _isTop = NO;
    _isBeaten = NO;
    currentHeight = 0;
//    self.moveSpeed = 3;
    self.userInteractionEnabled = NO;

    [self startAnimating];
}

- (void)levelUp
{
    _score++;
    [self setLevel];
    _moveSpeed += 1.5;
}
@end
