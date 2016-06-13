//
//  ViewController.m
//  2048Game
//
//  Created by qianfeng on 15-1-30.
//  Copyright (c) 2015年 ZJD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL isMoved;
    NSUInteger score;
    UIView *bv;
}
@end

@implementation ViewController
@synthesize arrLabel, scoreLabel, colorArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isMoved = FALSE;
    score = 0;
    colorArray = [[NSMutableArray alloc]init];
    for(int i = 0; i < 14; i++)
    {
        UIColor * color = [UIColor colorWithRed:1 green:(255 - 10 * i)/255.0 blue:(232 - 20 * i )/255.0 alpha:1];
        [colorArray addObject:color];
    }
    NSLog(@"%@",colorArray);

    bv = [[UIView alloc]initWithFrame:CGRectMake(60, 20, 201, 201)];
    //bv.backgroundColor = [UIColor ];
    [self.view addSubview:bv];

    arrLabel = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            myLabel * label = [[myLabel alloc]initWithFrame:CGRectMake(i*50+1, j*50+1, 49, 49)];
            label.delegate = self;
            //[label changeColor];
            [bv addSubview:label];
            [arrLabel addObject:label];
        }
    }
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(wipeLeft)];
    [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(wipeRight)];
    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    UISwipeGestureRecognizer *recognizerUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(wipeUp)];
    [recognizerUp setDirection:UISwipeGestureRecognizerDirectionUp];
    UISwipeGestureRecognizer *recognizerDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(wipeDown)];
    [recognizerDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.view addGestureRecognizer:recognizerLeft];
    [self.view addGestureRecognizer:recognizerRight];
    [self.view addGestureRecognizer:recognizerUp];
    [self.view addGestureRecognizer:recognizerDown];
    [UIView commitAnimations];
    
    [self setColorWithNumber];
    
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 420, 300, 30)];
    [scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [scoreLabel setBackgroundColor: [UIColor clearColor]];//colorWithRed:1 green:1 blue:232/255.0 alpha:1]];
    [scoreLabel setFont: [UIFont boldSystemFontOfSize:25]];
    [scoreLabel setTextColor:[UIColor redColor]];
    scoreLabel.text = @"得分: 0";
    [self.view addSubview:scoreLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)wipeLeft
{
    NSLog(@"left");
    for (int n=0;n<=3;n++)
		for (int i=0;i<3;i++)
			for(int j=n;j<n+12;j+=4)
				if ( [[arrLabel[j] text] isEqualToString:@""] )
				{
					for(int k=j;k<n+12;k+=4)
					{
						if ( !([[arrLabel[k] text] isEqualToString: [arrLabel[k+4] text]]) )
							isMoved=YES;
						[arrLabel[k] setText: [arrLabel[k+4] text]];
					}
                    [arrLabel[ n + 12 ] setText:@""];
				}
    
	for (int n=0;n<=3;n++)
		for(int j=n;j<n+12;j+=4)
			if ([[arrLabel[j] text] isEqualToString: [arrLabel[j+4] text]] && !([[arrLabel[j] text] isEqualToString:@""]) )
			{
				isMoved=YES;
                NSString *temp = [NSString stringWithFormat:@"%d" , [[arrLabel[j] text]intValue] * 2];
				[arrLabel[j] setText:temp];
				score=score + [[arrLabel[j] text]intValue];
				for(int k=j+4;k<n+12;k+=4)
					[arrLabel[k] setText: [arrLabel[k+4] text]];
				[arrLabel[ n + 12 ] setText:@""];
			}
    [self setColorWithNumber];
    [self gameOver];
}
- (void)wipeRight
{
    NSLog(@"right");
    for (int n=0;n<=3;n++)
		for (int i=0;i<3;i++)
			for(int j=n+12;j>n;j-=4)
				if ( [[arrLabel[j] text] isEqualToString:@""] )
				{
					for(int k=j;k>n;k-=4)
					{
						if ( !([[arrLabel[k] text] isEqualToString: [arrLabel[k-4] text]]) )
							isMoved=YES;
						[arrLabel[k] setText: [arrLabel[k-4] text]];
					}
                    [arrLabel[n] setText:@""];
				}
    
	for (int n=0;n<=3;n++)
		for(int j=n+12;j>n;j-=4)
			if ([[arrLabel[j] text] isEqualToString: [arrLabel[j-4] text]] && !([[arrLabel[j] text] isEqualToString:@""]) )
			{
				isMoved=YES;
                NSString *temp = [NSString stringWithFormat:@"%d" , [[arrLabel[j] text]intValue] * 2];
				[arrLabel[j] setText:temp];
				score=score + [[arrLabel[j] text]intValue];
				for(int k=j-4;k>n;k-=4)
					[arrLabel[k] setText: [arrLabel[k-4] text]];
				[arrLabel[n] setText:@""];
			}
    [self setColorWithNumber];
    [self gameOver];
}
- (void)wipeUp
{
    NSLog(@"up");
    for (int n=0;n<=3;n++)
		for (int i=0;i<3;i++)
			for(int j=4*n;j<4*n+3;j++)
				if ( [[arrLabel[j] text] isEqualToString:@""] )
				{
					for(int k=j;k<4*n+3;k++)
					{
						if ( !([[arrLabel[k] text] isEqualToString: [arrLabel[k+1] text]]) )
							isMoved=YES;
						[arrLabel[k] setText: [arrLabel[k+1] text]];
					}
                    [arrLabel[4 * n + 3] setText:@""];
				}
    
	for (int n=0;n<=3;n++)
		for(int j=4*n;j<4*n+3;j++)
			if ([[arrLabel[j] text] isEqualToString: [arrLabel[j+1] text]] && !([[arrLabel[j] text] isEqualToString:@""]) )
			{
				isMoved=YES;
                NSString *temp = [NSString stringWithFormat:@"%d" , [[arrLabel[j] text]intValue] * 2];
				[arrLabel[j] setText:temp];
				score=score + [[arrLabel[j] text]intValue];
				for(int k=j+1;k<4*n+3;k++)
					[arrLabel[k] setText: [arrLabel[k+1] text]];
				[arrLabel[4 * n + 3] setText:@""];
			}
    [self setColorWithNumber];
    [self gameOver];
}
- (void)wipeDown
{
    NSLog(@"down");
    for (int n=0;n<=3;n++)
		for (int i=0;i<3;i++)
			for(int j=4*n+3;j>4*n;j--)
				if ( [[arrLabel[j] text] isEqualToString:@""] )
				{
					for(int k=j;k>4*n;k--)
					{
						if ( !([[arrLabel[k] text] isEqualToString: [arrLabel[k-1] text]]) )
							isMoved=YES;
						[arrLabel[k] setText: [arrLabel[k-1] text]];
					}
                    [arrLabel[4 * n] setText:@""];
				}
    for (int n=0;n<=3;n++)
		for(int j=4*n+3;j>4*n;j--)
			if ([[arrLabel[j] text] isEqualToString: [arrLabel[j-1] text]] && !([[arrLabel[j] text] isEqualToString:@""]) )
			{
				isMoved=YES;
                NSString *temp = [NSString stringWithFormat:@"%d" , [[arrLabel[j] text]intValue] * 2];
				[arrLabel[j] setText:temp];
				score=score + [[arrLabel[j] text]intValue];
				for(int k=j-1;k>4*n;k--)
					[arrLabel[k] setText: [arrLabel[k-1] text]];
				[arrLabel[4 * n] setText:@""];
			}
    [self setColorWithNumber];
    [self gameOver];
}



- (void)setColorWithNumber
{
    if (isMoved) {
        [self addNewNumber];
    }
    [scoreLabel setText: [NSString stringWithFormat:@"得分:   %d", score]];
    for (int i = 0 ; i < 16; i++) {
        int j = 0;
        if ([[arrLabel[i] text] isEqualToString:@""]) {
            j = 0;
            [arrLabel[i] setBackgroundColor:[UIColor clearColor]];
        }
        else
        {
            j = [[arrLabel[i] text] intValue];
        
            for (int k = 0; k < 20; k++) {
                if (pow(2, k) == j) {
                    [arrLabel[i] setBackgroundColor:colorArray[k]];
                    break;
                }
            }
        }
    }
    isMoved = NO;
}

- (void) addNewNumber
{
    while (TRUE) {
        int pos = arc4random()%16;
        if ([[arrLabel[pos] text] isEqualToString:@""]) {
            int num = arc4random()%5;
            if (num == 2 || num == 4) {
                [arrLabel[pos] setText:[NSString stringWithFormat:@"%d", num]];
            }
            else
                [arrLabel[pos] setText:@"2"];
            
            break;
        }
    }
}

- (void) gameOver
{
	BOOL nosame=YES;
	for(int n=0;n<=3;n++)
		for (int i=4*n;i<4*n+3;i++)
			if ( [[arrLabel[i] text] isEqualToString: [arrLabel[i+1] text]] || [[arrLabel[i] text] isEqualToString:@"" ] || [[arrLabel[i+1] text] isEqualToString:@""] )
			{
				nosame=NO;
				break;
			}
    
	
	for(int n=0;n<=3;n++)
		for (int i=n;i<n+12;i+=4)
			if ( [[arrLabel[i] text] isEqualToString: [arrLabel[i+4] text]] || [[arrLabel[i] text] isEqualToString:@""] || [[arrLabel[i+4] text] isEqualToString:@""] )
			{
				nosame=NO;
				break;
			}
    
    
	if ( nosame == YES )
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over" message:@"完儿蛋" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];//@"重新开始", nil];
        [alert show];
		return;
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    else if (buttonIndex == 1)
    {
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                myLabel * label = [[myLabel alloc]initWithFrame:CGRectMake(i*50+1, j*50+1, 49, 49)];
                //label.delegate = self;
                [bv addSubview:label];
                [arrLabel addObject:label];
            }
        }
        score = 0;
    }
}
@end
